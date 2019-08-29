class LunarRover():
    def __init__(self, porosity, hardness):
        self.porosity = porosity
        self.hardness = hardness
        self.excavatingProtocol = []

    def __str__(self):
        return f'a Rover with porosity={self.porosity} hardness={self.hardness}'

class Drill():
    def __init__(self, clockwise, speed, duration_in_seconds):
        self.clockwise = clockwise
        self.speed = speed
        self.duration_in_seconds = duration_in_seconds
    
    def execute(self):
        message = f'the drill drills with a speed of {self.speed} for {self.duration_in_seconds} seconds'
        if self.clockwise:
            message+=' clockwise'
        else:
            message+=' counter-clockwise'
        print(message)
    
    def __str__(self):
        rep = f'a Drill with speed of {self.speed} and duration of {self.duration_in_seconds} seconds'
        if self.clockwise:
            rep+=', it drills clockwise.'
        else:
            rep+=', it drills counter-clockwise'
        return rep
        
        

lr = LunarRover(100,5)
d = Drill(True, '15RPM',100)
print(d)
print(lr)
