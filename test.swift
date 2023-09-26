// Объявление структуры
// При объявлении структуры или класса определяется новый тип Swift
struct ChessPlayer {  // типам нужно давать UpperCamelCase имена
// свойства - те качества, которыми будут обладать объекты (экземпляры), принадлежащие этой структуре
    var name: String  // свойствам lowerCamelCase
    var nickname: String
    var age: Int
    victory: Int
    defeat: Int
// методы - это функции, встроенные в структуры или классы [которые ассоциируются с определенным "типом"]
func thisIsMethod() -> Void {
    print("Привет, я шахматист!")
}
}
// Экземпляр структуры — это объект, который создается при инициализации структуры и имеет доступ ко всем полям и свойствам этой структуры.
/* Встроенный инициализатор
Чтобы создать экземпляр структуры необходимо использовать встроенный инициализатор.
Инициализатор — это специальная функция, которую мы используем для создания объектов определенного класса, структуры или перечисления.
Имя инициализатора совпадает с именем типа, для которого вызывается инициализатор.
*/
var semen = ChessPlayer(name: "Semen", nickname: "Shark", age: 23, victory 32, defeat: 4)
// Если пропустить хоть одно свойство при использовании встроенного инициализатора, то компилятор выдаст ошибку!

// Дальше мы можем обращаться к любым его свойствам:
semen.name
semen.age
// Вывести на консоль
print(semen.defeat)

// Изменение значения свойства объекта
semen.victory = 33
// Если свойства структуры будут константными параметрами, то их нельзя будет поменять извне

// Чтобы вызвать метод нужно использоваь экземпляр структуры и через точку обратиться к методу:
semen.thisIsMethod


// Создание собственных инициализаторов
/* ПРИ СОЗДАНИИ СОБСТВЕННОГО ИНИЦИАЛИЗАТОРА ВСТРОЕННЫЙ ПЕРЕСТАЕТ ИСПОЛЬЗОВАТЬСЯ (то же будет верно и в обратном случае!)
init(имя_передаваемого_параметра: тип_параметра){
    тело инициализатора
}

И, естественно, нам нужно будет присвоить входящий параметр из инициализатора тому свойству, которое нам нужно проинициализировать, в нашем случае это будет age. Чтобы это сделать, нам потребуется в теле инициализатора произвести присвоение аргумента нужному свойству
ПИШЕТСЯ ВНУТРИ СТРУКТУРЫ
init(age: Int){
    self.age = age
}
Тем самым мы явно указываем при помощи self, что аргумент age должен быть присвоен свойству age, принадлежащему самой структуре.

Чтобы работал собственныый инициализатор, нужно в него добавить все свойства которые будут проинициализированы, а остальные должны быть уже проинициализированными!
*/




/* Классы
Класс является описанием объекта, а объект представляет экземпляр класса