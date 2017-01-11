<?php

use Illuminate\Database\Seeder;
use App\User;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $jef = [
            'name' => 'Jef',
            'email' => 'jef@vanhoyweghen.net',
            'password' => Hash::make('secret'),
        ];

        User::create($jef);
    }
}
