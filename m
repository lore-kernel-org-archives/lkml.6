Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935029AbeEIOZa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:25:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58147 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933887AbeEIOZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:25:28 -0400
Date: Wed, 9 May 2018 16:25:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: jacek.anaszewski@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Add SC27xx breathing light
 controller documentation
Message-ID: <20180509142526.GA25131@amd>
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch adds the binding documentation for Spreadtrum SC27xx series
> breathing light controller, which supports 3 outputs: red LED, green
> LED and blue LED.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - Change the compatible string to be one explicit SoC name.
>  - Change the child node name.
>  - Change to be upper case for the first character.
> ---
>  .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |   41 ++++++++++++++=
++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bl=
tc.txt
>=20
> diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt =
b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
> new file mode 100644
> index 0000000..b3de7fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
> @@ -0,0 +1,41 @@
> +LEDs connected to Spreadtrum SC27XX PMIC breathing light controller
> +
> +The SC27xx breathing light controller supports to 3 outputs:
> +red LED, green LED and blue LED. Each LED can work at normal
> +PWM mode or breath light mode.

> +Required properties:
> +- compatible: Should be "sprd,sc2731-bltc".

If this is for 2731, I'd say so in the title and the filename...?

> +- #address-cells: Must be 1.
> +- #size-cells: Must be 0.
> +- reg: Specify controller address.

the controller...

> +Required child properties:
> +- reg: Number of LED line (could be from 0 to 2).

Uff. "Port this LED is connected to"?

With that fixed...

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrzBNYACgkQMOfwapXb+vJAuQCgvcB9K0kKr4+5DMMuDIbDRnsS
g00AoK8sAt+IgvgozXJ3/+Y5F/Xd59wK
=n0xY
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
