class LoginComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      user: "",
      password: "",
    }
  }

  handleChange(event) {
    this.setState({
      sentence: event.target.value
    })
  };

  handleSend() {
    const {
      router,
    } = this.props

    const {
      sentence,
      user,
      password,
    } = this.state

    getLocalAsJson(`substrings?sentence=${sentence}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        router.navigate("/list", { substrings: json })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  render() {
    const {
      sentence,
    } = this.state

    const {
      classes,
    } = this.props

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Login
          </Typography>
        <FormControl fullWidth className={classes.textField} variant="outlined">
          <InputLabel htmlFor="outlined-adornment-amount">
            Usuario
          </InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={sentence}
            onChange={(ev)=>this.handleChange(ev)}
            startAdornment={<InputAdornment position="start">></InputAdornment>}
            labelWidth={60}
          />
          <InputLabel htmlFor="outlined-adornment-amount">Contraseña </InputLabel>
          <OutlinedInput
            id="outlined-adornment-amount"
            value={sentence}
            onChange={(ev)=>this.handleChange(ev)}
            startAdornment={<InputAdornment position="start">></InputAdornment>}
            labelWidth={60}
          />
        </FormControl>

        <Button
          color="inherit"
          onClick={(ev)=>this.handleChange(ev)}>
          Ingresar
      </Button>
      </div>
    )
  }
}

// Add style
const LoginView = withStyles(styles, {
  withTheme: true
})(LoginComponent)
