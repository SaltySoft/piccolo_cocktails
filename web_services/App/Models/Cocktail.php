<?php
/**
 * Copyright (C) 2013 Antoine Jackson
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 * OR OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 * @Entity @Table(name="cocktails")
 */
class Cocktail extends Model
{

    public function __construct()
    {
        $this->ingredients = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * @Id @GeneratedValue(strategy="AUTO") @Column(type="integer")
     */
    public $id;

    /**
     * @Column(type="string")
     */
    private $name;

    /**
     * @Column(type="integer")
     */
    private $difficulty;

    /**
     * @Column(type="integer")
     */
    private $originality;

    /**
     * @Column(type="integer")
     */
    private $duration;

    /**
     * @ManyToOne(targetEntity="User")
     * @JoinColumn(name="author_id", referencedColumnName="id")
     */
    private $author;



    /**
     * @Column(type="text")
     */
    private $description;



    /**
     * @Column(type="text")
     */
    private $recipe;


    /**
     * @Column(type="string")
     */
    private $picture_url;

    /**
     * @ManyToMany(targetEntity="Ingredient", inversedBy="cocktails")
     */
    private $ingredients;

    /**
     * @ManyToMany(targetEntity="User", mappedBy="favorites")
     */
    private $users;

    /**
     * @Column(type="boolean")
     */
    private $alchohol;


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


    public function getIngredients()
    {
        return $this->ingredients;
    }

    public function setAuthor($author)
    {
        $this->author = $author;
    }

    public function getAuthor()
    {
        return $this->author;
    }

    public function setDescription($description)
    {
        $this->description = $description;
    }

    public function getDescription()
    {
        return $this->description;
    }

    public function setDifficulty($difficulty)
    {
        $this->difficulty = $difficulty;
    }

    public function getDifficulty()
    {
        return $this->difficulty;
    }

    public function setDuration($duration)
    {
        $this->duration = $duration;
    }

    public function getDuration()
    {
        return $this->duration;
    }

    public function setOriginality($originality)
    {
        $this->originality = $originality;
    }

    public function getOriginality()
    {
        return $this->originality;
    }

    public function setPictureUrl($picture_url)
    {
        $this->picture_url = $picture_url;
    }

    public function getPictureUrl()
    {
        return $this->picture_url;
    }

    public function setRecipe($recipe)
    {
        $this->recipe = $recipe;
    }

    public function getRecipe()
    {
        return $this->recipe;
    }

    public function setAlchohol($alchohol)
    {
        $this->alchohol = $alchohol;
    }

    public function getAlchohol()
    {
        return $this->$alchohol;
    }

    public function addIngredient($ingredient)
    {
        $this->ingredients->add($ingredient);
    }

    public function toArray()
    {
        $array = array();
        $ingredients = array();

        foreach ($this->ingredients as $ingredient)
        {
            $ingredients[] = $ingredient->toArray();
        }

        $array["id"] = $this->id;
        $array["name"] = $this->name;
        $array["difficulty"] = $this->difficulty;
        $array["originality"] = $this->originality;
        $array["duration"] = $this->duration;
        $array["author"] = $this->author != null ? $this->author->getName() : "";
        $array["author_id"] = $this->author != null ? $this->author->getId() : "";
        $array["description"] = $this->description;
        $array["recipe"] = $this->recipe;
        $array["ingredients"] = $ingredients;
        $array["picture_url"] = $this->picture_url;
        $array["alchohol"] = $this->alchohol;

        return $array;
    }




}