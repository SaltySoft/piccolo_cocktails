<?php
/**
 * Created by JetBrains PhpStorm.
 * User: Irenicus
 * Date: 04/07/13
 * Time: 11:34
 * To change this template use File | Settings | File Templates.
 */
    /**
     * @Entity @Table(name="ingredients")
     */
class Ingredient extends Model
{

    /**
     * @Id @GeneratedValue(strategy="AUTO") @Column(type="integer")
     */
    public $id;

    /**
     * @Column(type="string")
     */
    private $name;

    /**
     * @ManyToMany(targetEntity="Cocktail", mappedBy="ingredients")
     */
    private $cocktails;


    public function getId()
    {
        return $this->id;
    }

    public function setName($name)
    {
        $this->name = $name;
    }

    public function getName()
    {
        return $this->name;
    }



    public function toArray()
    {
        $array = array(
            "id" => $this->id,
            "name" => $this->name
        );

        return $array;
    }


    public function getCocktails()
    {
        return $this->cocktails;
    }

    public function addCocktail($cocktail)
    {
        $this->cocktails->add($cocktail);
    }

}