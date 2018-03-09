Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeCIQIz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:08:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeCIQIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:08:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3E020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 9 Mar 2018 17:08:50 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 4/6] dt-bindings: power: supply: axp20x: add AXP813
 battery DT binding
Message-ID: <20180309160850.v3cf3ixe2hpr4txo@earth.universe>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <002a5a7730f8c8ca9b75147cb139cdcea6bb62f1.1519813976.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pttjghqy6q4cy6pp"
Content-Disposition: inline
In-Reply-To: <002a5a7730f8c8ca9b75147cb139cdcea6bb62f1.1519813976.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pttjghqy6q4cy6pp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2018 at 11:35:59AM +0100, Quentin Schulz wrote:
> The AXP813 can have a battery as power supply, so let's add it to the
> list of compatibles.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 ++=
+----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_batter=
y.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> index c248866..41916f6 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -4,12 +4,12 @@ Required Properties:
>   - compatible, one of:
>  			"x-powers,axp209-battery-power-supply"
>  			"x-powers,axp221-battery-power-supply"
> +			"x-powers,axp813-battery-power-supply"
> =20
> -This node is a subnode of the axp20x/axp22x PMIC.
> +This node is a subnode of its respective PMIC DT node.
> =20
> -The AXP20X and AXP22X can read the battery voltage, charge and discharge
> -currents of the battery by reading ADC channels from the AXP20X/AXP22X
> -ADC.
> +The supported devices can read the battery voltage, charge and discharge
> +currents of the battery by reading ADC channels from the ADC.
> =20
>  Example:
> =20
> --=20
> git-series 0.9.1

--pttjghqy6q4cy6pp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqisZEACgkQ2O7X88g7
+prQmw//fiRKNyFaUTm+ekmywlgtqQb9DsZqm9Fwf/e1elogpyvqxlhU/gXd47Gz
MD9rr918qNi3Xy/Awj6WQWXBBzAI4dgVG9HEYeG66eOY3Riuc28QCJM1QbYLLCHO
VuazFhlS67L8Oh5q390ARwe3vRonXPeSJZZWuayP7clL99b2T4KeK1y738Oadlr3
pbcrwUmkO53/udG/XGyuhchQJ6VhsIfp6uXeZhtwld5mqQLRJdbIPDo9dXGutDnu
UkKT2lZjDWe90GfaBYJHr6dzFKug2SLAxb+WTy6CYcZjQN19bDRgBrwt+ZPSlAFP
+rc0rGIQbo4Err4OixsQkFE9/RlrP9n1wFxS8Yuqx1tqVXJssvG07MLY+Ue8+a0L
DLCWU7x9m0+Yag8Dd8NMGZRvAGuHoypYVrd6GyrZwcq2DF4UIIjMu8AqIPodwniI
QnuaPynsp8Js/Z8Gdev9MmZZLGDoN11n0JtrQJu3f507D1wn8zCeqKJW4hal0KUX
mUJ6ZXu0mM0Z3APku7UeX/7hF21IbTz8CQdOgSInWTT0pKA/2+FP15qtnkLErL9H
Nmfr2WEbhF0fYmglczuHfjn4fXj6S1/f/nlvxSmRCE0/XzH3E/P+x6hvr+riEc7X
HUNb7i/R0XeJrxSoP1wODuBhWtvfTX2hg8Q8t4fLlMuS0rnlL9U=
=YP1Y
-----END PGP SIGNATURE-----

--pttjghqy6q4cy6pp--
