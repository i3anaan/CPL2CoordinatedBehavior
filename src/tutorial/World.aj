package tutorial;

public aspect World {
	pointcut greeting() : execution( * HelloWorld.sayHello(..));
	
	after() returning: greeting(){
		System.out.print("World!");
	}

}
