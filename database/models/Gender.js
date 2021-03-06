module.exports = function (sequelize, DataTypes) {
  const cols = {
    idgenders: {
      type: DataTypes.INTEGER(1),
      allowNull: false,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(45),
      allowNull: false
    }
  }
  const config = {
    tableName: 'genders',
    timestamps: false
  };

  const Gender = sequelize.define('Gender', cols, config);

  Gender.associate = function (models) {

    //Asosiacion 1:M
    Gender.hasMany(models.User, {  //Pelicula es el alias
      as: "users",  //Asociacion entre peliculas y genero
      foreignKey: "genders_idgenders"
    })

  }

  return Gender;

};
