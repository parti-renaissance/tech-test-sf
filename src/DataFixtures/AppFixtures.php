<?php

namespace App\DataFixtures;

use App\Entity\Event;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create('fr_FR');

        for ($i = 0; $i < 1000; $i++) {
            $event = new Event();
            $event->setTitle($faker->sentence(3));
            $event->setDescription($faker->paragraph());
            $event->setDate($faker->dateTimeBetween('-1 year', '+1 year'));
            $event->setLocation($faker->city());
            $event->setImageUrl('https://picsum.photos/seed/' . $faker->word() . '/200/200');

            $manager->persist($event);
        }

        $manager->flush();
    }
}
