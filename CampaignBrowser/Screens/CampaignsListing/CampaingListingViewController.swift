import UIKit
import RxSwift


/**
 The view controller responsible for listing all the campaigns. The corresponding view is the `CampaignListingView` and
 is configured in the storyboard (Main.storyboard).
 */
class CampaignListingViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet
    private(set) weak var typedView: CampaignListingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(typedView != nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Load the campaign list and display it as soon as it is available.
        fetchAndDisplayData()
    }
    
    private func fetchAndDisplayData() {
     
        ServiceLocator.instance.networkingService
            .createObservableResponse(request: CampaignListingRequest())
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] campaigns in
                self?.typedView.display(campaigns: campaigns)
                }, onError: { [weak self] error in
                    
                    guard let strongSelf = self else { return }
                    strongSelf.alert(title: String.localized(key: .alert_error_title),
                                     text: String.localized(key: .alert_no_internet_connection_message),
                                     actions: [.Retry])
                        .subscribe(onNext: { [unowned strongSelf] action in
                            
                            /*
                            in this exact case it could be done just like:
 
                             .subscribe(onNext: { [unowned strongSelf] _ in
                             
                                strongSelf.fetchAndDisplayData()
                             }
                            */
                            
                                //with switch we can handle all actions provided in alert(_, _, actions) argument
                            switch action {
                                
                            case .Retry:
                                strongSelf.fetchAndDisplayData()
                            }
                            
                        }).addDisposableTo(self!.disposeBag)
            })
            .addDisposableTo(disposeBag)
    }
}
