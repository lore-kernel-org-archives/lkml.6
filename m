Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeDVTW5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 15:22:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43947 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeDVTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 15:22:55 -0400
Date: Sun, 22 Apr 2018 21:22:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Woody Suwalski <terraluna977@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Message-ID: <20180422192253.GA5174@amd>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
 <20180319092106.GA5683@amd>
 <6e43123a-5227-96c4-a1f5-4416bdb5b0db@gmail.com>
 <c7d96582-e2e6-d9c8-1140-3f1dab836132@gmail.com>
 <20180415161551.GF10802@amd>
 <01331018-8c62-30b2-673c-11b0bcd38c0e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <01331018-8c62-30b2-673c-11b0bcd38c0e@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >I guess you can't reproduce it easily? I tried bisecting, but while it
> >happens often enough to make v4.17 hard to use, it does not permit
> >reliable bisect.
> >
> >These should be bad according to my notes
> >
> >b04240a33b99b32cf6fbdf5c943c04e505a0cb07
> >  ed80dc19e4dd395c951f745acd1484d61c4cfb20
> >  52113a0d3889d6e2738cf09bf79bc9cac7b5e1c6
> >  4fc97ef94bbfa185d16b3e44199b7559d0668747
> >  14ebdb2c814f508936fe178a2abc906a16a3ab48
> >  639adbeef5ae1bb8eeebbb0cde0b885397bde192
> >
> >bisection claimed
> >
> >c16add24522547bf52c189b3c0d1ab6f5c2b4375
> >
> >is first bad commit, but I'm not sure if I trust that.
> >									Pavel
> It has not happen on any of my systems in the last month. Good, but bad f=
or
> getting more info :-(

My current theory is that it only happens if you suspend your machine
for > ten minutes, or something like that.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrc4Q0ACgkQMOfwapXb+vIQpwCgpM8nPkG3H+uI0ljZDTsEtrUj
CvMAnjGGSsz404huS0NVvFl7eeQxj2/U
=ylki
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
