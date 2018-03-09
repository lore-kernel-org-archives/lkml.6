Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeCIRE1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:04:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35036 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeCIRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:04:26 -0500
Date: Fri, 9 Mar 2018 18:04:22 +0100
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 3/6] power: supply: axp20x_battery: use data struct
 for variant specific code
Message-ID: <20180309170422.svf2covhrtxgnj5o@qschulz>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <c157320cf4c443e6904346c9072f46e713498161.1519813976.git-series.quentin.schulz@bootlin.com>
 <20180309160825.fde2am6jo6qs6vp6@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qghohmptoyiqutrd"
Content-Disposition: inline
In-Reply-To: <20180309160825.fde2am6jo6qs6vp6@earth.universe>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qghohmptoyiqutrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Fri, Mar 09, 2018 at 05:08:25PM +0100, Sebastian Reichel wrote:
> Hi Quentin,
>=20
> On Wed, Feb 28, 2018 at 11:35:58AM +0100, Quentin Schulz wrote:
> > We used to use IDs to select a function or a feature depending on the
> > variant. It's easier to maintain the code by adding data structure
> > storing the few differences between variants so that we don't add a pile
> > of if conditions.
> >=20
> > Let's use this data structure and update the code to use it.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>=20
> I applied this, but modified the patch slightly, so that
> it actually calls your new set_max_voltage() callback in
> axp20x_battery_set_prop(). Please check that the resulting
> patch looks correct to you:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t/commit/?h=3Dfor-next&id=3D648badd797c762a713b48afc3b67d56abdd0073b
>=20

You actually fixed an error in this patch while doing so, so thank you :)

Looks good to me.

Quentin

--qghohmptoyiqutrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJaor6TAAoJEIS4mnU+4PGj4EwQAIdIaLSWiWozdYRfFYDDlA3h
mNuYT1icR+CSre7IumWyGCpr69Lp0ScBV8PvgLQuui1xpqw8ziJcC89AJMDGqcEs
KHHL+VDesDqdqbXTXVbJXaBHnFWmDHV8oshhARqOOsTPrq70+YhKF8Qr07CKeQt4
iRFrONSxwhE0QiwfYK5fusUUohDmP0rmu+cx7xsfIGZOqI+lowFXrnBREzSwISgm
jW09SXaZ58gVRlQfKO55PHMOxEmQ/bBH09bvGmWAvs/bUaULBYtpaNzcJhytBrBx
IH998Efz40ZaKy+h/ujRCrHboxFMSe6RYI9L6irAQ/cjxlnwKgrF9PSiWWZDUS/C
/VQ86/QDpndtEGQCG1ij+JLCisQJBqlRr3J7pYoXwdDIYCQRdRbv0dRUJ1e1Yxua
1j4QDf78aoQ5M5Zexf7xX28mBRyux0KU1eXVA7bRQA41kRfOtfugEycVMSphk79/
zJqzSHsXe3bVdFPGU8A7hpQuJFHLj7NTzv0Tq4+gTg/miB7lZKsi1R+UXd3Z4zrZ
02pba+IJYtWc/ADaC7a3fL57NTNwaVn72ob62Zbmx/K4cjqI9w3FqsZXupGTmu9v
thiaBwNvtOWOgM2mEk2aICYbHrkjwetLAqpXJEGORcOAiiz3BYHbkYhpyOffGF/o
tGu4iawM4OW73tOEfl8o
=UJqe
-----END PGP SIGNATURE-----

--qghohmptoyiqutrd--
