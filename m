Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F2C5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D054D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D054D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rwth-aachen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJQCSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:18:47 -0400
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:9531 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbeJQCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:18:47 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ALAACXHsZb/54agoZjGgEBAQEBAgEBA?=
 =?us-ascii?q?QEHAgEBAQGBUwMBAQEBCwGCA4INCpgwgg2NYRGJFYF6CAQBLIRAAoRnITYLDQE?=
 =?us-ascii?q?DAQECAQECbSiFOQEBAQQnUhALFQMJJQ8BRwYOBYMhggEEp0ozihAPCQGCY4hfg?=
 =?us-ascii?q?heDbzWKWAKOfI8uBwKBCo9oCYkfhnaWBgICAgIJAhSBSQExgVVxgzuCIwMXEY4?=
 =?us-ascii?q?KbYEEJIkuAYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2ALAACXHsZb/54agoZjGgEBAQEBAgEBAQEHAgEBAQGBUwM?=
 =?us-ascii?q?BAQEBCwGCA4INCpgwgg2NYRGJFYF6CAQBLIRAAoRnITYLDQEDAQECAQECbSiFO?=
 =?us-ascii?q?QEBAQQnUhALFQMJJQ8BRwYOBYMhggEEp0ozihAPCQGCY4hfgheDbzWKWAKOfI8?=
 =?us-ascii?q?uBwKBCo9oCYkfhnaWBgICAgIJAhSBSQExgVVxgzuCIwMXEY4KbYEEJIkuAYEeA?=
 =?us-ascii?q?QE?=
X-IronPort-AV: E=Sophos;i="5.54,389,1534802400"; 
   d="asc'?scan'208";a="58705701"
Received: from rwthex-w2-a.rwth-ad.de ([134.130.26.158])
  by mail-in-1.itc.rwth-aachen.de with ESMTP; 16 Oct 2018 20:27:02 +0200
Received: from pebbles.localnet (77.181.213.57) by rwthex-w2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1531.3; Tue, 16
 Oct 2018 20:27:02 +0200
From:   Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To:     Colin King <colin.king@canonical.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] iio: adc: ina2xx: add in early -EINVAL returns in case statements
Date:   Tue, 16 Oct 2018 20:26:57 +0200
Message-ID: <3078823.PklSZE2rHu@pebbles>
In-Reply-To: <20181016161418.29213-1-colin.king@canonical.com>
References: <20181016161418.29213-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2946009.hxjI0KkqV5";
        micalg=pgp-sha1; protocol="application/pgp-signature"
X-Originating-IP: [77.181.213.57]
X-ClientProxiedBy: rwthex-s1-a.rwth-ad.de (2a00:8a60:1:e500::26:152) To
 rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2946009.hxjI0KkqV5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 16. Oktober 2018 18:14:18 CEST Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Static analysis with CoverityScan is throwing warnings that specific
> case statements are missing breaks.  Rather than adding breaks, add
> return -EINVAL to the specific case statements to clarify the
> error return paths. Fix also saves 50 bytes.
>=20
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   21418	   4936	    128	  26482	   6772	drivers/iio/adc/ina2xx-adc.o
>=20
> After:
>   dec	    hex	filename
>   21370	   4936	    128	  26434	   6742	drivers/iio/adc/ina2xx-adc.o
>=20
> (gcc 8.2, x86-64)
>=20
> Detected by CoverityScan, CID#1462408 ("Missing break in switch")
>=20
> ---
>=20
> V2: use returns instead of break statements to keep with the
> current style used in the switch statement.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>

> ---
>  drivers/iio/adc/ina2xx-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index d1239624187d..bdd7cba6f6b0 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -250,6 +250,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  			*val2 =3D chip->shunt_resistor_uohm;
>  			return IIO_VAL_FRACTIONAL;
>  		}
> +		return -EINVAL;
>=20
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		switch (chan->address) {
> @@ -262,6 +263,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  			*val =3D chip->range_vbus =3D=3D 32 ? 1 : 2;
>  			return IIO_VAL_INT;
>  		}
> +		return -EINVAL;
>  	}
>=20
>  	return -EINVAL;


=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart2946009.hxjI0KkqV5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCW8YtcQAKCRBvf0o9jP6q
U3v9AJ44Qty9cHY5G9OUBkpyD/51jKQ4xgCeLeC0V5AxngnaVSBE21yehWchN/8=
=cW1Q
-----END PGP SIGNATURE-----

--nextPart2946009.hxjI0KkqV5--
