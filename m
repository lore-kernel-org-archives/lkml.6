Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeENUQe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:16:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41791 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeENUQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:16:33 -0400
Date: Mon, 14 May 2018 22:16:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dan Murphy <dmurphy@ti.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: lm3601x: Introduce the lm3601x LED driver
Message-ID: <20180514201631.GC3276@amd>
References: <20180510174717.26540-1-dmurphy@ti.com>
 <20180510174717.26540-2-dmurphy@ti.com>
 <41267191-1308-6b9b-78fa-2893a525b49a@gmail.com>
 <17630aca-1225-df61-7a5d-a921ecd9c78c@ti.com>
 <86c2bc2f-e622-9447-e4bb-b4ee37e2d44a@ti.com>
 <20180514200503.GB3276@amd>
 <4a631a8e-18ba-0886-039e-004980ae0cc3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <4a631a8e-18ba-0886-039e-004980ae0cc3@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-05-14 15:13:34, Dan Murphy wrote:
> Pavel
>=20
> On 05/14/2018 03:05 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >>> OK.
> >>
> >> OK I looked at the max776973 driver and well if the flash-max-microamp=
 and
> >> flash-max-timeout-us nodes are missing it sets a default value for eac=
h if the
> >> node is not present.
> >>
> >> So should we remove this code from the Max77693 driver too and fail pr=
obe as being asked
> >> in this driver?
> >=20
> > Well, modifying driver without access to the hardware is tricky
> > :-(. If it does something stupid (like using other than minimum values
> > for the flash-max-microamp/flash-max-timeout-us), it needs to be
> > fixed.
>=20
> Well we should be able to test the probe/parse dt node and reject the pro=
be if the node is not
> present.  That can be done without HW the setup is done pretty early in t=
he probe without even attempting to communicate
> with the hardware.
>=20

Well, yes, you can do that.

But if someone is actively using board with DT w/o flash-max-microamp,
you'll make them unhappy.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr57p8ACgkQMOfwapXb+vJFlACgujXcpnRObguYLvWCam06W1E+
mdAAnjT0OKVSwVfmzmQc6Fl5i/YNYoNU
=NBSs
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
