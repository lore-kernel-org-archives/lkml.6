Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeEVOau (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:30:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33003 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeEVOaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:30:46 -0400
Date: Tue, 22 May 2018 16:30:44 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3] arm64: allwinner: a64: Add Amarula A64-Relic initial
 support
Message-ID: <20180522143044.pgwawojiwnk2lzxb@flea>
References: <20180522132228.6564-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ygqx2izorne4ivrt"
Content-Disposition: inline
In-Reply-To: <20180522132228.6564-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ygqx2izorne4ivrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 06:52:28PM +0530, Jagan Teki wrote:
> Amarula A64-Relic is Allwinner A64 based IoT device, which support
> - Allwinner A64 Cortex-A53
> - Mali-400MP2 GPU
> - AXP803 PMIC
> - 1GB DDR3 RAM
> - 8GB eMMC
> - AP6330 Wifi/BLE
> - MIPI-DSI
> - CSI: OV5640 sensor
> - USB OTG

You claim that this is doing OTG...

[..]

> +&usb_otg {
> +	dr_mode =3D "peripheral";
> +	status =3D "okay";
> +};

=2E.. and yet you're setting it as peripheral...

> +&usbphy {
> +	usb0_id_det-gpios =3D <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
> +	usb0_vbus-supply =3D <&reg_drivevbus>;

While you have an ID pin and a controllable VBUS. Which one is it?

Maxime
--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ygqx2izorne4ivrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsEKZMACgkQ0rTAlCFN
r3RuIA//eelMnLMqezMlXJ4x0tEgp9khNB/u/pIJndLpZ8Wu6CtE0vZgQhXb0xMS
kb1sCegrW63NPL6B4GaO9sfyfcCKmRlM0vNx3mojRjHxn4Nb3u+09LVMLFQMFRr4
QEQED2IGZ+GonKtaDTKdaKp3jvmMkEkbsMdjUM35aAFm8DYa8E2C5SZvD0ubVqen
PClqI3qJj/qFG8OBbxRg9Ss/UR3ixUm5Zn6p+X2UdAS0LiadQYtEUZJn3ltlvJzE
ERRMl02A/6tsLNwAt365jm1m4CCCcTJNTo9kLzylM0ur6XObIePhDrdJd83b1voQ
cOJioEi0nKi5T6QxqHezhQvfUbrh0lAnDSLYIzJwVVK9c2rHTqXQfVpc0e0mTxQn
9918U9nv5L+nBVDrf6rRkxohG4QWInglzxRtoe/GxIK5HeX+Vxd5Kw5g7kLoHjHw
R7KiyjWUn9dDjRmcXfwVnxIzY45yGiFA17Wd6rq9GjaDo63FcFrvcDPYXxHd/c4S
s452hR/Jp/KYwLfamNsCmRt6xNsfQzJDg7AR4OArlT/+Ybv/wAEn5t8edlhNnLqG
8unQV5CyydSDrVyP9O6YYUWyXcoV6vvfPQ1xgKplKofg8XBJkArhFDEK0kpFn3j6
XTAE9t8zRLAd9De46R2tBaWQZi84BZ1QxTqensxqhtupVHcYcOQ=
=rAi0
-----END PGP SIGNATURE-----

--ygqx2izorne4ivrt--
