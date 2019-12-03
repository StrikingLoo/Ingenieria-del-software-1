class StringInputComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      userId: "",
      password: "",
    }
  }
  
  handleUserIdChange(event) {
	this.setState({
      userId: event.target.value
    })
  };
  
  handlePasswordChange(event) {
	this.setState({
      password: event.target.value
    })
  };

  handleSend() {
    const {
      router,
    } = this.props

    const {
      userId,
      password,
    } = this.state

    getLocalAsJson(`createCart?user=${userId}&password=${password}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        router.navigate("/list", { substrings: ["caca", "pis"], cartId: json })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  render() {
    const {
      userId,
      password,
    } = this.state

    const {
      classes,
    } = this.props

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Ingrese su usuario y contraseña
          </Typography>
        <FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">Usuario</InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={userId}
            onChange={(ev)=>this.handleUserIdChange(ev)}
            startAdornment={<InputAdornment position="start">></InputAdornment>}
            labelWidth={60}
          />
        </FormControl>
        <FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">Contraseña</InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={password}
            onChange={(ev)=>this.handlePasswordChange(ev)}
            startAdornment={<InputAdornment position="start">></InputAdornment>}
            labelWidth={60}
          />
        </FormControl>

        <Button
          color="inherit"
          onClick={(ev)=>this.handleSend(ev)}>
          Enviar
      </Button>
      </div>
    )
  }
}

// Add style
const StringInputView = withStyles(styles, {
  withTheme: true
})(StringInputComponent)
