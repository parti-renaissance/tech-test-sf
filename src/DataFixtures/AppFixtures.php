<?php

declare(strict_types=1);

namespace App\DataFixtures;

use App\Entity\Category;
use App\Entity\Event;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;

class AppFixtures extends Fixture
{
    private const CATEGORIES = [
        'Conférence',
        'Concert',
        'Festival',
        'Atelier',
        'Exposition',
        'Spectacle',
        'Sport',
        'Networking',
    ];

    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create('fr_FR');

        $categories = [];
        foreach (self::CATEGORIES as $name) {
            $category = new Category();
            $category->setName($name);
            $manager->persist($category);
            $categories[] = $category;
        }

        for ($i = 0; $i < 1000; $i++) {
            $event = new Event();
            $event->setTitle($faker->sentence(3));
            $event->setDescription($faker->paragraph());
            $event->setDate(\DateTimeImmutable::createFromMutable($faker->dateTimeBetween('-1 year', '+1 year')));
            $event->setLocation($faker->city());
            $event->setImageUrl('https://picsum.photos/seed/' . $faker->word() . '/200/200');
            $event->setCategory($faker->randomElement($categories));

            $manager->persist($event);
        }

        $manager->flush();
    }
}
