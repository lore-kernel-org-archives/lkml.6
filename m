Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeBUJvj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:51:39 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:55785 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbeBUJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:51:37 -0500
Date: Wed, 21 Feb 2018 10:51:35 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 00/13] add support for AXP813 ADC and battery power
 supply
Message-ID: <20180221095135.qasoo527jvlu6fsw@flea.lan>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dv5ei2er35pztlai"
Content-Disposition: inline
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dv5ei2er35pztlai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 01:47:23PM +0100, Quentin Schulz wrote:
> The AXP813 PMIC is relatively close to the already supported AXP20X and
> AXP22X. It provides three different power outputs: battery, AC and USB, a=
nd
> measures a few different things: temperature, power supply status, current
> current and voltage supplied, maximum current limit, battery capacity, min
> and max voltage limits.
>=20
> One of its two GPIOs can be used as an ADC.
>=20
> There are a few differences with AXP20X/AXP22X PMICs though:
>   - a different constant charge current formula,
>   - battery temperature, GPIO0 and battery voltages are the only voltages
>   measurable,
>   - all data are stored on 12 bits (AXP20X/AXP22X had one type of data th=
at
>   was stored on 13 bits),
>   - different scales and offsets,
>   - a different ADC rate formula and register,
>=20
> This patch series adds support for the PMIC's ADC and battery power supply
> in the existing drivers.
>=20
> Make the axp20x MFD automatically probe the ADC driver, add the battery
> power supply node in axp81x node and enable it for the TBS A711 since it
> has a soldered battery.
>=20
> I suggest patches:
>   - 1,2,4,10,11,12 go through Maxime and Chen-Yu's tree,

Applied, thanks!
Maxiime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--dv5ei2er35pztlai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqNQSYACgkQ0rTAlCFN
r3Trsw/9EJBb7CEZav54SzhHbxqn6M72R75nl0OsNvvTDl043d8UapMH8lNPvIal
nemW+99/JuxT+M/+uGr0I/wYiV0jBnA5nasgSerFWU2Thc2TXFOXx02ZlQB9EExP
yXO2NlGTy6D8MYuPfFRbH/SQrWoy0XRXB26tRJ2wLa5SNW2MhZCNc+3jORu3dNM+
EQ3HPpYiHd3RyqlSSJmRX63fKRA38MP9TenW65h8IwCTg96P93OHy0nxKjjvWvFQ
tc2MO2NKICuPrD7lLeO6kuJC7VYGpJtSQHb0FNoy5lVSeiolF/amNEX3cM+UZ7f3
FEJVpfNI+e1Cw5U0VZkKlM768WODk7nEHIh0kfAuOKyuuoAL3VlSrXNucw9GuBtF
m5SFNbqIOLSNwJZW7XaO8YmeRnyUplu8GlIghMVfoQVWVhKxuLEN1Yn0UOqzMDTl
QVduS+EErJg5HCNin1mUZVCiMGCfJxPXwZCLagks16SMuOmlSDWzhfubdYlKk3u2
ybU2nvXFjv49mk0ecD+oSe8rmGH4bRHe3DSRCdgRL8oAOOyFGrRJfZSWm/N7MDaj
sy561Q6JrwmP0phkKvKelcdBDbJAS/FkpcJCCpVopVTCBvi6inta3a8k+zT8BW4F
cClcyodzEra3bEkqcRP7vwEbyu3pLqjx6oEklnkediO6K6hAq1c=
=lZ7e
-----END PGP SIGNATURE-----

--dv5ei2er35pztlai--
