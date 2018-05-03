Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeECTAU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:00:20 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:33028 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeECS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:59:00 -0400
Subject: Re: led: hw-trigger, global brightness and multi-colored leds
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, Tomas Hlavacek <tomas.hlavacek@nic.cz>
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
 <20180502212105.GA9869@amd>
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <69651d45-7566-95ad-2a83-53dd76e5680e@kleine-koenig.org>
Date: Thu, 3 May 2018 20:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502212105.GA9869@amd>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Zp70xxEw6kIWCp715fzKSOcN8YPO9KsQL"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zp70xxEw6kIWCp715fzKSOcN8YPO9KsQL
Content-Type: multipart/mixed; boundary="7A7rD1OAfPetVSHf2uiO53fZGsGZHC1Nt";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 linux-kernel@vger.kernel.org, Tomas Hlavacek <tomas.hlavacek@nic.cz>
Message-ID: <69651d45-7566-95ad-2a83-53dd76e5680e@kleine-koenig.org>
Subject: Re: led: hw-trigger, global brightness and multi-colored leds
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
 <20180502212105.GA9869@amd>
In-Reply-To: <20180502212105.GA9869@amd>

--7A7rD1OAfPetVSHf2uiO53fZGsGZHC1Nt
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

On 05/02/2018 11:21 PM, Pavel Machek wrote:
>> on the Turris Omnia[1] the LEDs are controllable via an i2c device. Ea=
ch
>> LED can be either in "manual mode" or in a mode I'd call "native mode"=

>> which is the default. In this native mode the LED being on or off
>> depends on an input line that is controlled by another hardware. So a
>> LED signals for example activity on the WAN ethernet port without any
>> software intervention, but can be used as a normal LED, too, when in
>> "manual mode" where it can be switched on and off by a register
>> write.
>=20
> "Native mode" is quite common. We have it for example on Nokia N900
> here (charger has hw option to automatically control the LED).

git grep -i n900 -- drivers/leds doesn't yield any output. Do I miss
anything?

> I believe reasonable solution would be to have "hardware" trigger, and
> have it selected by default. When active, LED would be controlled by
> hardware.

There is no prior art for that available as source code, right?

>> Another feature of the LED device is that there is a global brightness=

>> register that influences all LED's brightness (if on) independent of t=
he
>> operating mode.
>=20
> We can't describe that easily.

Given that I can give an RGB value (i.e. 3x 8 bit) for the LED, I can
change brightness per LED. Have to play around a bit.

>> Further the color of each LED can be set to an RGB triplet.
>=20
> We normally handle RGB LED as three independend LEDs, like
> notify::red, notify::green, notify::blue. Again, example is Nokia N900
> or Motorola Droid 4.

I cannot find source code for LEDs on the Droid 4 either.

An ugly property here is that the hardware trigger only operates on all
three colors at once. Hmm, will think a bit about the way to go.

Best regards and thanks for your input,
Uwe


--7A7rD1OAfPetVSHf2uiO53fZGsGZHC1Nt--

--Zp70xxEw6kIWCp715fzKSOcN8YPO9KsQL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlrrWdIACgkQwfwUeK3K
7AnzGgf/X/nbwuHt9FIUt7XDboeADP0kGEZcvr7y5m68VVN2rWAf83YzN0J/B6jw
d2iNP4NEL1QSWlZmQEkSjTwdS7EyjbdBjb342Jbs6qxviAexaiGAA8bJKdcL2zAo
3DkHQlPV4WBw9R7z/3LfT7VS3FlQZabd5qDZKb1JLqcB4jCwscRnW1N8+yu9sTse
hfaIhpVSnsIhkhFNIJfzE8BcqLJOSwzNW57GLBW6t4BNscv/rkVXLcsEg68W+H3n
3Fi2ZEfKmPMukX7aDutpmhGUpsskr6bQifqh7cphK+22Z7G19ApBp+fjkjFBT0ZP
tkeAJob6OdknH8hUV29cFwa67bVgBA==
=Gnu0
-----END PGP SIGNATURE-----

--Zp70xxEw6kIWCp715fzKSOcN8YPO9KsQL--
