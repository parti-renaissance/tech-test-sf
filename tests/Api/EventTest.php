<?php

declare(strict_types=1);

namespace App\Tests\Api;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class EventTest extends WebTestCase
{
    public function testGetEventsReturnsSuccessfulResponse(): void
    {
        $client = static::createClient();
        $client->request('GET', '/events');

        $this->assertResponseIsSuccessful();
    }
}
