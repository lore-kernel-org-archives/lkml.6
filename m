Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeDFWlP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:41:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48366 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDFWlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:41:14 -0400
Date: Sat, 7 Apr 2018 00:41:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: x32 suspend failuer in Re: linux-next: Tree for Apr 4
Message-ID: <20180406224112.GA5940@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404075047.GB9342@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20180404075047.GB9342@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-04 09:50:47, Pavel Machek wrote:
> Hi!
>=20
> > Please do not add any v4.18 destined stuff to your linux-next included
> > trees until after v4.17-rc1 has been released.
>=20
> On thinkpad x60, suspend does not suspend at all with this -next
> version. Previous versions suspended/resumed fine but broke networking.

I bisected networking breakage to

c16add24522547bf52c189b3c0d1ab6f5c2b4375

which is slightly weird. But it modifies ACPI in strange way, so maybe
not that weird.

Networking breakage is still in next-20180406.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrH94gACgkQMOfwapXb+vKrCACgnBzeRARVDy5dGoLek+mGucou
lN8An1ExBHyO73ypHm1chtJRXLdtgUNP
=Lzuj
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
