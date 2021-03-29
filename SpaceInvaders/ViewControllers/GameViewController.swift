//
//  GameViewController.swift
//  SpaceInvaders
//
//  Created by Разработчик on 22.03.2021.
//

import UIKit

final class GameViewController: UIViewController {

    //MARK: - Аутлеты и свойства
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var leftMoveButton: UICustomButton!
    @IBOutlet weak var rightMoveButton: UICustomButton!
    @IBOutlet weak var shootButton: UICustomButton!
    @IBOutlet weak var labelDefeat: UILabel!
    @IBOutlet weak var backToMenuButton: UICustomButton!
 
    //Верхняя граница
    let borderTop = [UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.minY+80, width: UIScreen.main.bounds.width, height: 1))]
    //Нижняя граница
    let borderBottom = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-200, width: UIScreen.main.bounds.width, height: 1))
    //Создаем корабль игрока
    private let ourShipImage = UIImage(named: "ourShip")
    private var ourShipImageView = UIImageView()
    
    //Image for rocket
    private let rocketOurImage = UIImage(named: "rocketOur")

    //Создаем вражеские корабли
    private let enemyShipImage = UIImage(named: "enemyShip")
    private var enemyShipImageView = [UIImageView]()
    
    //Состояние игры
    var state = false
    var score = Int()
    var speed = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGame()
    }
    // Установка начальных параметров и вызов основных методов
    private func initGame(){
        speed = 50000
        score = 0 //Очки
        backToMenuButton.isHidden = true
        backToMenuButton.isEnabled = false
        state = true //Состояние игры
        scoreLabel.text = String(0) //Очки на экране
        labelDefeat.isHidden = true //Прячем
        createOurShip() // Создаем корабль игрока
        createEnemyShip() // Вражеские корабли
        buttonTargets() // Кнопки
        checkState() // Проверить состояние игры
        moveEnemyShips() // Движение вражеских кораблей
    }
    // Проверка состояния игры
    private func checkState(){
        DispatchQueue.global(qos: .userInteractive).async {
            while(self.state){
                usleep(10000)
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.state == false{
                        self.backToMenuButton.isHidden = false
                        self.backToMenuButton.isEnabled = true
                        self.labelDefeat.isHidden = false
                        self.leftMoveButton.isEnabled = false
                        self.rightMoveButton.isEnabled = false
                        self.shootButton.isEnabled = false
                        print("label")
                    }
                }
            }
        }
    }
    // Коллизия между ракетами и враж. кораблями
    private func collision(rocket: UIImageView,ship: [UIView]) -> Int{
        for i in 0..<ship.count{
            if rocket.frame.intersects(ship[i].frame) && ship[i].isHidden==false{
                return i
            }
        }
        return -1 //Промах
    }
    // Возвтра в меню
    @IBAction func backToMainMenu(_ sender: UICustomButton) {
        performSegue(withIdentifier: "backToMainMenuTwo", sender: nil)
    }
    // MARK: - Методы для вражеских кораблей
    private func createEnemyShip(){
        for i in 0..<15{
            let enemyShip = UIImageView(image: enemyShipImage)
            switch i{
            case 0..<5:
                enemyShip.frame = CGRect(x: (i)*60+5, y: 100, width: 40, height: 40)
                self.enemyShipImageView.append(enemyShip)
                self.view.addSubview(self.enemyShipImageView[i])
                print("Create \(i) ship")
            case 5..<10:
                enemyShip.frame = CGRect(x: (i-5)*60+5, y: 150, width: 40, height: 40)
                self.enemyShipImageView.append(enemyShip)
                self.view.addSubview(self.enemyShipImageView[i])
                print("Create \(i) ship")
            case 10..<15:
                enemyShip.frame = CGRect(x: (i-10)*60+5, y: 200, width: 40, height: 40)
                self.enemyShipImageView.append(enemyShip)
                self.view.addSubview(self.enemyShipImageView[i])
                print("Create \(i) ship")
            default:
                print("ship none")
            }
        }
    }
    //Движение вражеских кораблей
    private func moveEnemyShips(){
        var direction = true
        var caunter = 0
        DispatchQueue.global(qos: .userInitiated).async {
            while(self.state){
                usleep(useconds_t(self.speed))
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    
                    if self.enemyShipImageView.isEmpty{
                        self.createEnemyShip()
                    }
                    switch direction{
                    case true:
                        if self.enemyShipImageView[self.enemyShipImageView.endIndex-1].frame.maxX<UIScreen.main.bounds.width{
                            for object in self.enemyShipImageView{
                                object.center = CGPoint(x: object.center.x+3, y: object.center.y+1)
                            }
                        }
                    case false:
                        if self.enemyShipImageView[self.enemyShipImageView.startIndex].frame.minX>0{
                            for object in self.enemyShipImageView{
                                object.center = CGPoint(x: object.center.x-3, y: object.center.y+1)
                            }
                        }
                    }
                    var index = 0
                    for i in 0..<self.enemyShipImageView.count{
                        if self.enemyShipImageView[i].isHidden == false{
                            index = i
                        }
                    }
                    if self.enemyShipImageView[index].center.y>self.borderBottom.center.y{
                        self.state = false
                    }

                    caunter += 1
                    if caunter == 40{
                        caunter = 0
                        direction = !direction
                    }
                }
            }
        }
        
    }
    
    // MARK: - Методы игрока
    //Создание игрока
    private func createOurShip(){
        ourShipImageView = UIImageView(image: ourShipImage)
        ourShipImageView.frame = CGRect(x: 0,
                                        y: 0,
                                        width: 50,
                                        height: 50)
        ourShipImageView.center = self.view.center
        ourShipImageView.center.y = leftMoveButton.center.y-75
        self.view.addSubview(ourShipImageView)
    }
    //Создание ракеты
    private func createRocket(object: UIImageView) -> UIImageView{
        
        let rocket = UIImageView(image: rocketOurImage)
        
        rocket.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        rocket.center.x = object.center.x
        rocket.center.y = object.center.y - 40
 
        self.view.addSubview(rocket)
        return rocket
        
    }
    //Выстрел
    private func Shoot(){
        let rocketOurImageView = createRocket(object: ourShipImageView)
        var rocketFly = true
        DispatchQueue.global(qos: .userInteractive).async {
            while (rocketFly){
                usleep(10000)
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    rocketOurImageView.frame = CGRect(x: rocketOurImageView.frame.origin.x,
                                                           y: rocketOurImageView.frame.origin.y-5,
                                                           width: rocketOurImageView.frame.width,
                                                           height: rocketOurImageView.frame.height)
                    let index = self.collision(rocket: rocketOurImageView, ship: self.enemyShipImageView)
                    if index>=0{
                        self.enemyShipImageView[index].isHidden = true //removeFromSuperview()
                        //self.enemyShipImageView.remove(at: index)
                        rocketOurImageView.removeFromSuperview()
                        rocketFly = false
                        self.score += 100
                        self.scoreLabel.text = String(self.score)
                    }
                    var countOfHidden = 0
                    for ship in self.enemyShipImageView{
                        if ship.isHidden{
                            countOfHidden += 1
                            
                        }
                        
                    }
                    
                    if countOfHidden == self.enemyShipImageView.count{
                        self.enemyShipImageView.removeAll()
                        self.speed -= 5000
                    }
                    
                    if self.collision(rocket: rocketOurImageView, ship: self.borderTop) == 0{
                        rocketOurImageView.removeFromSuperview()
                        rocketFly = false
                    }
                }
            }
        }
    }
    
    //Задержка выстрела
    @objc private func shootTimer(sender: UICustomButton){
        self.shootButton.isEnabled = false
        self.Shoot()
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(buttonIsEnabled(sender:)), userInfo: nil, repeats: false)

    }
    
    @objc private func buttonIsEnabled(sender: Any?){
        self.shootButton.isEnabled = true
    }
    
    //MARK: - Action for buttons
    
    private func buttonTargets(){
        self.leftMoveButton.addTarget(self, action: #selector(moveShipLeft(sender:)), for: .touchDown)
        self.rightMoveButton.addTarget(self, action: #selector(moveShipRight(sender:)), for: .touchDown)
        self.shootButton.addTarget(self, action: #selector(shootTimer(sender:)), for: .touchDown)
    }
    
    @objc private func moveShipLeft(sender: UICustomButton){
        if leftMoveButton.isHighlighted && ourShipImageView.frame.minX>self.view.bounds.minX{
            ourShipImageView.center = CGPoint(x: ourShipImageView.center.x-3, y: ourShipImageView.center.y)
            perform(#selector(moveShipLeft(sender:)), with: nil, afterDelay: 0.015)
        }
    }
 
    @objc private func moveShipRight(sender: UICustomButton){
        if rightMoveButton.isHighlighted && ourShipImageView.frame.maxX<self.view.bounds.width{
            ourShipImageView.center = CGPoint(x: ourShipImageView.center.x+3, y: ourShipImageView.center.y)
            perform(#selector(moveShipRight(sender:)), with: nil, afterDelay: 0.015)
        }
    }
    
}

