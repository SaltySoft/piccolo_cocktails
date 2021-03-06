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
 * @Entity @Table(name="users")
 */
class User extends UserBase
{

    public  function  __construct()
    {
       $this->favorites = new \Doctrine\Common\Collections\ArrayCollection();
    }


    /**
     * @Id @GeneratedValue(strategy="AUTO") @Column(type="integer")
     */
    public $id;

    /**
     * @Column(type="string")
     */
    public $name;


    /**
     * @Column(type="string")
     */
    public  $email;


    /**
     * @ManyToMany(targetEntity="Cocktail", inversedBy="users")
     */
    private $favorites;


    public function getId()
    {
        return $this->id;
    }


    public function setEmail($email)
    {
        $this->email = $email;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function setName($name)
    {
        $this->name = $name;
    }

    public function getName()
    {
        return $this->name;
    }

    public function getFavorites()
    {
        return $this->favorites;
    }

    public function addFavorite($cocktail)
    {
        $this->favorites->add($cocktail);
    }

    public function removeFavorite($cocktail)
    {
        $this->favorites->removeElement($cocktail);
    }



    public function toArray()
    {
        $array = array(
            "id" => $this->id,
            "name" => $this->name,
            "email" => $this->email,
            "hash" => $this->hash,
            "admin" => $this->admin
        );

        return $array;
    }


}