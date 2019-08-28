class LunarRover():
    def __init__(self, porosity, hardness):
        self.porosity = porosity
        self.hardness = hardness
        self.excavatingProtocol = []

    def __str__(self):
        return f'a Rover with por={self.porosity} hardness={self.hardness}'

lr = LunarRover(100,5)
print(lr)
