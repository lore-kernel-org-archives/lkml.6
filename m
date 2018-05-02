Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeEBVVJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:21:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53365 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeEBVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:21:07 -0400
Date: Wed, 2 May 2018 23:21:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, Tomas Hlavacek <tomas.hlavacek@nic.cz>
Subject: Re: led: hw-trigger, global brightness and multi-colored leds
Message-ID: <20180502212105.GA9869@amd>
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> on the Turris Omnia[1] the LEDs are controllable via an i2c device. Each
> LED can be either in "manual mode" or in a mode I'd call "native mode"
> which is the default. In this native mode the LED being on or off
> depends on an input line that is controlled by another hardware. So a
> LED signals for example activity on the WAN ethernet port without any
> software intervention, but can be used as a normal LED, too, when in
> "manual mode" where it can be switched on and off by a register
> write.

"Native mode" is quite common. We have it for example on Nokia N900
here (charger has hw option to automatically control the LED).

I believe reasonable solution would be to have "hardware" trigger, and
have it selected by default. When active, LED would be controlled by
hardware.

> Another feature of the LED device is that there is a global brightness
> register that influences all LED's brightness (if on) independent of the
> operating mode.

We can't describe that easily.

> Further the color of each LED can be set to an RGB triplet.

We normally handle RGB LED as three independend LEDs, like
notify::red, notify::green, notify::blue. Again, example is Nokia N900
or Motorola Droid 4.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrqK8EACgkQMOfwapXb+vInGACePNDa9yUYYpG9Tw19Lpwtpq9G
fjIAoL88+HUnZbkpURN5Hvl3Tq3j2yRl
=Lzwg
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
