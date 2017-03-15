
import UIKit

let kNotificationLanguageChanged        = "kNotificationLanguageChanged";

func Localization(string:String) -> String{
    return Localisator.sharedInstance.localizedStringForKey(string)
}

func SetLanguage(language:String) -> Bool {
    return Localisator.sharedInstance.setLanguage(language)
}

class Localisator
{
    private let userDefaults                    = NSUserDefaults.standardUserDefaults()
    private var availableLanguagesArray         = ["DeviceLanguage", "English_en", "Albanian_sq", "Serbian_sr"]
    private var dicoLocalisation:NSDictionary!
    
    private let kSaveLanguageDefaultKey         = "kSaveLanguageDefaultKey"
    var currentLanguage                         = "DeviceLanguage"
    
    
    var saveInUserDefaults:Bool {
        get {
            return (userDefaults.objectForKey(kSaveLanguageDefaultKey) != nil)
        }
        set {
            if newValue {
                userDefaults.setObject(currentLanguage, forKey: kSaveLanguageDefaultKey)
            } else {
                userDefaults.removeObjectForKey(kSaveLanguageDefaultKey)
            }
            userDefaults.synchronize()
        }
    }
    
    
    class var sharedInstance :Localisator {
        struct Singleton {
            static let instance = Localisator()
        }
        return Singleton.instance
    }
    
    
    init() {
        if let languageSaved = userDefaults.objectForKey(kSaveLanguageDefaultKey) as? String {
            if languageSaved != "DeviceLanguage" {
                self.loadDictionaryForLanguage(languageSaved)
            }
        }
    }
    
    func getArrayAvailableLanguages() -> [String] {
        return availableLanguagesArray
    }
    
    func getLanguage() -> Int
    {
        switch currentLanguage
        {
            case "English_en":
                return 0
            case "Albanian_sq":
                return 1
            case "Serbian_sr":
                return 2
            default:
                return 0
        }
    }
    
    private func loadDictionaryForLanguage(newLanguage:String) -> Bool {
        
        let arrayExt = newLanguage.componentsSeparatedByString("_")
        
        for ext in arrayExt {
            if let path = NSBundle(forClass:object_getClass(self)).URLForResource("Localizable", withExtension: "strings", subdirectory: nil, localization: ext)?.path {
                if NSFileManager.defaultManager().fileExistsAtPath(path) {
                    currentLanguage = newLanguage
                    dicoLocalisation = NSDictionary(contentsOfFile: path)
                    return true
                }
            }
        }
        return false
    }
    
    private func localizedStringForKey(key:String) -> String {
        
        if let dico = dicoLocalisation {
            if let localizedString = dico[key] as? String {
                return localizedString
            }  else {
                return key
            }
        } else {
            return NSLocalizedString(key, comment: key)
        }
    }
    
    private func setLanguage(newLanguage:String) -> Bool {
        
        if (newLanguage == currentLanguage) || !availableLanguagesArray.contains(newLanguage)
        {
            return false
        }
        
        if newLanguage == "DeviceLanguage"
        {
            currentLanguage = newLanguage
            dicoLocalisation = nil
            NSNotificationCenter.defaultCenter().postNotificationName(kNotificationLanguageChanged, object: nil)
            return true
        }
        else if loadDictionaryForLanguage(newLanguage)
        {
            NSNotificationCenter.defaultCenter().postNotificationName(kNotificationLanguageChanged, object: nil)
            if saveInUserDefaults
            {
                userDefaults.setObject(currentLanguage, forKey: kSaveLanguageDefaultKey)
                userDefaults.synchronize()
            }
            return true
        }
        return false
    }
}

