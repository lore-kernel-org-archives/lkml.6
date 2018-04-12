Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDLVJn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:09:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55098 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeDLVJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:09:41 -0400
Date: Thu, 12 Apr 2018 23:09:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dan Williams <dcbw@redhat.com>
Cc: Woody Suwalski <terraluna977@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Message-ID: <20180412210939.GA28527@amd>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
 <20180319092106.GA5683@amd>
 <1521474008.20208.2.camel@redhat.com>
 <20180319173356.GA28462@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20180319173356.GA28462@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-03-19 18:33:56, Pavel Machek wrote:
> On Mon 2018-03-19 10:40:08, Dan Williams wrote:
> > On Mon, 2018-03-19 at 10:21 +0100, Pavel Machek wrote:
> > > On Mon 2018-03-19 05:17:45, Woody Suwalski wrote:
> > > > Pavel Machek wrote:
> > > > > Hi!
> > > > >=20
> > > > > With recent linux-next, after resume networkmanager often claims
> > > > > that
> > > > > "network is disabled". Sometimes suspend/resume clears that.
> > > > >=20
> > > > > Any ideas? Does it work for you?
> > > > > 								=09
> > > > > Pavel
> > > >=20
> > > > Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.
> > >=20
> > > Thanks for testing... but yes, 4.16 should be ok. If not fixed,
> > > problem will appear in 4.17-rc1.
> >=20
> > Where does the complaint occur?  In the GUI, or with nmcli, or
> > somewhere else?  Also, what's the output of "nmcli dev" after resume?
>=20
> In the GUI. I click in place where I'd select access point, and menu
> does not show up, telling me that "network is disabled".

Ouch and the bug now crept to mainline.. and it happens on X220,
too. With ethernet, bug is harder to see, because "network is
disabled" and "no network" icon is there, but ethernet still works.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrPyxMACgkQMOfwapXb+vIIzwCbBgJld8U7RPMs/ag034iGh1OK
N8YAoLryE+/ujTW2usV0GwuRl76bbHIb
=NbZH
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
