const fs = require('fs');
const path = require('path');
const bcrypt = require('bcrypt');

const usersFilePath = path.join(__dirname, '../data/users.json');
const users = JSON.parse(fs.readFileSync(usersFilePath, 'utf-8'));

const categoriesFilePath = path.join(__dirname, '../data/categories.json');
const categoriesJSON = JSON.parse(fs.readFileSync(categoriesFilePath, 'utf-8'));



const registerController = {
    /*Render-get register-form*/
    registro: (req, res) => {
        res.render('registerFormCompleto', {
            categoriesJSON
        });
    },

    /*Register: Almacenar nuevo usuario*/
    store: (req, res, next) => {
        //console.log(req.body);
        const newUser = {
            id: users[users.length - 1].id + 1,
            name: req.body.name,
            lastname: req.body.lastname,
            email: req.body.email,
            password: bcrypt.hashSync(req.body.password, 10)
        };

        const userToSave = [...users, newUser];
        fs.writeFileSync(usersFilePath, JSON.stringify(userToSave, null, ' '));
        res.redirect('/');
    },

    /*Login: Almacenar nuevo usuario*/
    login: (req, res, next) => {
        const email = req.body.email;
        const password = req.body.password;

        const usuario = users.find((user) => {
            return user.email == email;
        });

        if (!usuario) {
            res.render('register', {
                error: 'Usuario y/o contraseña incorrecto',
                categoriesJSON
            });
        }
        if (!bcrypt.compareSync(password, usuario.password)) {
            res.render('register', {
                error: 'Usuario y/o contraseña incorrecto',
                categoriesJSON
            });
        }

        res.redirect('/');
    }
};

module.exports = registerController;