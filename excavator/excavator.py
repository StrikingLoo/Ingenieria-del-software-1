class LunarRover():
    def __init__(self, porosity, hardness):
        self.porosity = porosity
        self.hardness = hardness
        self.excavatingProtocol = []

    def __init__(self, porosity, hardness, protocol):
        self.porosity = porosity
        self.hardness = hardness
        self.excavatingProtocol = protocol

    def execute(self):
        print('starting process...')
        for step in self.excavatingProtocol:
            step.execute()
        print('process finished successfully!')

    def __str__(self):
        return f'a Rover with porosity={self.porosity} hardness={self.hardness} and protocol {self.excavatingProtocol}'

class Drill():
    def __init__(self, clockwise, speed, duration_in_seconds):
        self.clockwise = clockwise
        self.speed = speed
        self.duration_in_seconds = duration_in_seconds
    
    def execute(self):
        message = f'the drill drills with a speed of {self.speed} for {self.duration_in_seconds} seconds'
        if self.clockwise:
            message+=' clockwise.'
        else:
            message+=' counter-clockwise.'
        print(message)
    
    def __str__(self):
        rep = f'a Drill with speed of {self.speed} and duration of {self.duration_in_seconds} seconds'
        if self.clockwise:
            rep+=', it drills clockwise.'
        else:
            rep+=', it drills counter-clockwise'
        return rep

class Claw():
    def __init__(self, isOpen = True):
        self.isOpen = isOpen

    def actionMessage(self):
        if self.isOpen:
            return 'closed'
        else:
            return 'opened'

    def switch(self):
        self.isOpen = not self.isOpen

    def execute(self):
        action = self.actionMessage()
        self.switch()
        message = f'the claw is {action}'
        
        print(message)
    
    def __str__(self):
        rep = f'a Claw that is'
        rep+= ' open' if self.isOpen else ' closed'
        return rep

def is_stone(HARDNESS, POROSITY):
    return HARDNESS > 0 and POROSITY <= 0

def is_dust(HARDNESS, POROSITY):
    return HARDNESS <= 0 and POROSITY > 0


HARDNESS = 1 #positive for hard, negative or 0 for soft
POROSITY = 0 #positive for porose (like dust), negative or 0 for soft

if is_stone(HARDNESS, POROSITY):
    first_drill = Drill(True,150,10)
    claw = Claw()
    second_drill = Drill(False,150,10) #client did not specify how long. must double-check.
    
    rover = LunarRover(POROSITY, HARDNESS, [first_drill,claw, second_drill])
elif is_dust(HARDNESS, POROSITY):
    first_drill = Drill(False,100,5)
    claw = Claw()
    second_drill = Drill(True,100,5) #client did not specify how long. must double-check.
    
    rover = LunarRover(POROSITY, HARDNESS, [first_drill,claw, second_drill])

rover.execute()



