Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbeDCKtn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:49:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54707 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755049AbeDCKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:49:40 -0400
Date: Tue, 3 Apr 2018 12:49:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv3 8/8] ARM: dts: omap4-droid4: Add LCD panel rotation
 property
Message-ID: <20180403104938.GG6758@amd>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-9-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <20180330171822.25896-9-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 19:18:22, Sebastian Reichel wrote:
> This adds a LCD panel rotation hint to the Droid 4. If the
> display is rotated this way the keyboard can be used properly.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Hmm. Aha. And this the place where confusion matters. I believe most
users would consider top to be elsewhere on Droid 4.... but this
indeed makes sense for keyboard...

								Pavel

>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> index bdf73cbcec3a..3ed090a9db6c 100644
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -214,6 +214,7 @@
> =20
>  		width-mm =3D <50>;
>  		height-mm =3D <89>;
> +		rotation =3D <90>;
>  		backlight =3D <&lcd_backlight>;
> =20
>  		panel-timing {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDXEIACgkQMOfwapXb+vK/JgCdHzM28pFBq/xFlMqfNv5DhsxS
jIYAmQFwxydjWiDm3/h4zemBwu3i++h8
=Nski
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
