Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeA3SyQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:54:16 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36719 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeA3SyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:54:14 -0500
X-Google-Smtp-Source: AH8x227co2Jf1I2sDCZsvUeZGD5V0uFRRezgsRIUOLmBJAelP30GnDbgDtW2TDM1h+BSyAQJw3CMBg==
Date: Tue, 30 Jan 2018 19:54:11 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Liu Xiang <liu.xiang6@zte.com.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org,
        afd@ti.com
Subject: Re: [PATCH] power: supply: bq27xxx: Update comments
Message-ID: <20180130185411.rsu7o56xw26n6xmq@pali>
References: <1517063261-23296-1-git-send-email-liu.xiang6@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dflhfnjqup2r7sfm"
Content-Disposition: inline
In-Reply-To: <1517063261-23296-1-git-send-email-liu.xiang6@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dflhfnjqup2r7sfm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 27 January 2018 22:27:41 Liu Xiang wrote:
> The URL of bq27441-g1 is missing and bq27520-g4 is duplicated.
>=20
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 2de378a..c0e7c5b 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -26,7 +26,6 @@
>   * http://www.ti.com/product/bq27510-g1
>   * http://www.ti.com/product/bq27510-g2
>   * http://www.ti.com/product/bq27510-g3
> - * http://www.ti.com/product/bq27520-g4
>   * http://www.ti.com/product/bq27520-g1
>   * http://www.ti.com/product/bq27520-g2
>   * http://www.ti.com/product/bq27520-g3
> @@ -40,8 +39,9 @@
>   * http://www.ti.com/product/bq27545-g1
>   * http://www.ti.com/product/bq27421-g1
>   * http://www.ti.com/product/bq27425-g1
> - * http://www.ti.com/product/bq27411-g1
> + * http://www.ti.com/product/bq27441-g1
>   * http://www.ti.com/product/bq27621-g1
> + * http://www.ti.com/product/bq27411-g1
>   */
> =20
>  #include <linux/device.h>

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--dflhfnjqup2r7sfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnC/UAAKCRCL8Mk9A+RD
Us/CAJ9GFx8+Pl6HKg3ni9OluLEDJ/+wdQCghqko+I/oNxYqTtkJ/8qR8TjP/sw=
=S1Ih
-----END PGP SIGNATURE-----

--dflhfnjqup2r7sfm--
