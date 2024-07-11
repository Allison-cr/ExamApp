import UIKit

class MokData {
    func categoryWorkModel() -> [CategoryModel.Card] {
        [
            CategoryModel.Card(
                name: "Задачи", image: UIImage(systemName: "folder.fill") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "Проекты", image: UIImage(systemName: "folder.fill") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "Команда", image: UIImage(systemName: "folder.fill") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "Мероприятия", image: UIImage(systemName: "folder.fill") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "Тех долг", image: UIImage(systemName: "folder.fill") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "Образование", image: UIImage(systemName: "folder.fill") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "Встречи", image: UIImage(systemName: "folder.fill") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "Новое", image: UIImage(systemName: "folder.fill") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "Настройки", image: UIImage(systemName: "folder.fill") ?? UIImage()
                )
        ]
    }
    func categoryEducationModel() -> [CategoryModel.Card] {
        [
            CategoryModel.Card(
                name: "2", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "2", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "2", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "2", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "2", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "2", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "2", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                )
        ]
    }
    
    
    func categoryNewsModel() -> [CategoryModel.Card] {
        [
            CategoryModel.Card(
                name: "1", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "2", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "3", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                ),
            CategoryModel.Card(
                name: "4", image: UIImage(systemName: "square.and.pencil") ?? UIImage()
                )
        ]
    }
    
    func bannerNewsModel() -> [UIImage?] {
           return [
               UIImage(named: "image1"),
               UIImage(named: "image2"),
               UIImage(named: "image3")
           ]
       }

}
