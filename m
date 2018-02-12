Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeBLUKP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:10:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56502 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753836AbeBLUKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:10:12 -0500
Date: Mon, 12 Feb 2018 21:10:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/3] dt-bindings: mfd: axp20x: Document backup battery
 charging property
Message-ID: <20180212201010.GB25608@amd>
References: <20171230152330.28946-1-contact@paulk.fr>
 <20171230152330.28946-2-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20171230152330.28946-2-contact@paulk.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This adds documentation for the "backup" property of the axp20x driver,
> that controls the charging mechanism for the backup battery on axp20x.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documenta=
tion/devicetree/bindings/mfd/axp20x.txt
> index 9455503b0299..382776b29932 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -58,6 +58,11 @@ Optional properties:
>  	      See Documentation/devicetree/bindings/regulator/regulator.txt
>  	      for more information on standard regulator bindings.
> =20
> +- backup: An array of two integers for backup battery charging (axp20x-o=
nly),
> +	  describing the charging voltage in mV first and the charging current
> +	  in uA second. Backup battery charging is only enabled when these two
> +	  fields are filled.

Well...

We do want to charge batteries other than your backup
battery. Probably this should get separate "backup battery" node with
properties explaining how it is charged?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqB9KIACgkQMOfwapXb+vLuXgCguLT57URur6PyA8WAC2+0/cl2
IG0Anjz1c68nRjbpeNtFUob5O4VALkNX
=BL7q
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
