//
//  ViewController.swift
//  NAProject
//

import UIKit

class ViewController: UICollectionViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var personList = [Person]()
    var newName = "anonymous"
    var delete = false
    var touchedPath :IndexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toForm))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePerson))
        navigationItem.title = "Agenda"
        navigationItem.prompt = "Tap a profile to see details!"
        let defaults = UserDefaults.standard
        
        if let savedPeople = defaults.object(forKey: "personList") as? Data {
            personList = NSKeyedUnarchiver.unarchiveObject(with: savedPeople) as! [Person]
        }
        
    }

    @objc func toForm()
    {
        performSegue(withIdentifier: "toForm", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
        
        let person = personList[indexPath.item]
        
        cell.name.text = person.name
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsPath = paths[0]
        let path = documentsPath.appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(delete){
            personList.remove(at: indexPath.item)
            save()
            collectionView.reloadData()
            
        }
        else {
            
            touchedPath = indexPath
            performSegue(withIdentifier: "toDetail", sender: self)
            
            
           
            
        }
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            let detailViewController = segue.destination as! DetailViewController
            let person = personList[touchedPath.item]
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsPath = paths[0]
            let path = documentsPath.appendingPathComponent(person.image)
           detailViewController.pImage = UIImage(contentsOfFile: path.path)
            
            detailViewController.pName = personList[touchedPath.item].name
             detailViewController.pPhone = personList[touchedPath.item].phone
             detailViewController.pEmail = personList[touchedPath.item].email
            
        }else {
           // fatalError("Unknown segue")
        }
        
        
        
    }
    
    func addImage() {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
       
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let profileImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsPath = paths[0]
        let imageName = UUID().uuidString
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(profileImage, 70) {
            try? jpegData.write(to: imagePath)
        }
        personList[personList.count-1].image = imageName
        self.collectionView?.reloadData()
        save()
        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        personList.remove(at: personList.count-1)
        self.collectionView?.reloadData()
        save()
        dismiss(animated: true)
    }
    
    func save() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: personList)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "personList")
    }
    
    @objc func deletePerson(){
        if(!delete){
        delete = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(deletePerson))
            navigationItem.prompt = "Tap a profile to delete it"
        }
        else
        {
            delete = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePerson))
            navigationItem.prompt = "Tap a profile to see details!"
        }
        
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue){
        if(segue.identifier == "unwindToMain") {
        let formView = segue.source as! FormViewController
            let person = Person(name: formView.name!, image: "",phone: formView.phone!, email: formView.email!)
        self.personList.append(person)
        save()
        addImage()
        
        } else {
            fatalError("Unknown Segue")
        }
    }


}

