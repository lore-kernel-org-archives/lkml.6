Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932065AbeD2WnQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 18:43:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33849 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754359AbeD2WnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 18:43:15 -0400
Date: Mon, 30 Apr 2018 00:43:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429224313.GA4515@amd>
References: <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429220519.GQ5965@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20180429220519.GQ5965@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> What would be useful is if people gave reports that listed exactly
> what laptop and distributions they are using.  Just "a high spec x86
> laptop" isn't terribly useful, because *my* brand-new Dell XPS 13
> running Debian testing is working just fine.  The year, model, make,
> and CPU type plus what distribution (and distro version number) you
> are running is useful, so I can assess how wide spread the unhappiness
> is going to be, and what mitigation steps make sense.

Thinkpad X60,
model name	: Genuine Intel(R) CPU           T2400  @ 1.83GHz
pavel@amd:~$ cat /etc/debian_version
8.10

I already posted some dmesg snippets, but system boots. On _this_
boot, it was ok, and I do not see anything:

pavel@amd:/data/l/linux-next-32$ dmesg | grep urandom
pavel@amd:/data/l/linux-next-32$

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrmSoEACgkQMOfwapXb+vLFIwCfXbLNu2rh7s9YPg9AIn1vI7P8
OxYAnRxQuCK9KonIu2fpSWgeoh+YcH97
=Wv2N
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
