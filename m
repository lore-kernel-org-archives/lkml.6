Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24193C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCEB2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCEB2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rempel-privat.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeLGSEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:04:46 -0500
Received: from mout.gmx.net ([212.227.17.20]:51937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbeLGSEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:04:46 -0500
Received: from [192.168.1.241] ([31.18.251.131]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh6lB-1grejD2ELJ-00MK0u; Fri, 07
 Dec 2018 19:04:42 +0100
Subject: Re: [PATCH][misc-next] misc: cardreader: fix spelling mistake
 "invailid" -> "invalid"
To:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181206091936.11871-1-colin.king@canonical.com>
From:   Oleksij Rempel <linux@rempel-privat.de>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@rempel-privat.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6ea8c539-1b81-f19b-608a-ce9ead1d6fb5@rempel-privat.de>
Date:   Fri, 7 Dec 2018 19:04:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206091936.11871-1-colin.king@canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zIYITDqYwnnCBmikaZfeWZ1QHyl07uTFU"
X-Provags-ID: V03:K1:1IYnDnaj90yncY/cM36ksqv/Qh1Uxj4rETbN32BZuPpC0iJKlpR
 V4QFxlOUQWbixWZip5Q5HJkSh/9S4U+ax/FkQ2NHMEkimilJe/uKafXxvHstwGyzVMlnktP
 tFaroQZnrt4IJ8dzaMX56W/DzquLL0RjUfdeMds6h0Yhgx+SiqJvx88N0wmUYzRCil2kl6X
 4qx5skKlYaDWTIBJreyCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PTT4M1gHfzE=:fmz+WG+RY8Q+8Mjj+krhnt
 azFN1Iitowt2YGvOytGfdp1sG4cNSKyL9KGf3GINQgYvywyC9f864CeABLRDVX4+QSxJkPfbt
 vsVixpqoVnp9vQAplEVWmRT1Sz0c1uC+RkxMFWe2wIxdx/6VcAYkvRHOrZmZzkwrt5SFV8DLo
 94svtHhCNR9OeZks65K+92IMVZ0mJiaDmSYKD/n/gWLLSUvS8wYgZ+TZlbpHdBCirlUXw4/Ob
 Nsy5GaehAah18EfT6SKr9ICYUBpNm55daozQeT+Y5fLRdPmc9lD9WODv0NT9l229q8HPT8CXJ
 pZbnYLOvIV422rHQd8DwrFdj4BT1IVDsMoFVe7Q6qQQnaqomUrcptMM6JczShZ/OeYiOMicc6
 SDkGT3bPddm9BeqmeCRQW2m+n7FM0O/nYe8Wt4XFElmvDTQgaJYF9VzGexJ726V6OBxdZM1G8
 MhiJTtG84MAWgd8KOfudv/qnXxv/P+4/HVZpAsrDRz7Z2GWnsgAE6xOtMNAylP4vTFt36iAPz
 fC7WR0MZey/l54iCj5BpJ1XnCKwaF6j/dvQGxFRIMGSeIEsfO8+w7w6nsl/C3IpCD7znVrhYZ
 Wmiy5iyt/wbkKxaq777nXJTC71rDQeT3Hb2Kl27LGpkjq1Jm4YoC6yhaj6IiC93MSg0Z+W7mZ
 xW2HOwWMrsFEI1D2knQTzYvOk1Y1mSe48TyU8hxwMnwB4QZn3+jef5DBi3tzRUAsdRs7LSHQ6
 WvW3uGSctY5My0BteL1C1FN84EgKbC3qK7VbLmLqoBwppqqH0bL4ub6TJAmSvr86PwDgEUNQa
 RHMMZEhbiimrirXJycgJuuTAeukoezaSmQm9rz5PD2kjOqIVjlRCjYJ53WdDB+jTTXmKMPsku
 s9O7gFjaBTMbTybZEoHYPlDygFNo0kDSA7N+cz3PcPXvPvo8XPay+xuP9g61dp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zIYITDqYwnnCBmikaZfeWZ1QHyl07uTFU
Content-Type: multipart/mixed; boundary="cTP1uIVH3BeszxpHWKz2jT13hojFzjLwR";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Colin King <colin.king@canonical.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <6ea8c539-1b81-f19b-608a-ce9ead1d6fb5@rempel-privat.de>
Subject: Re: [PATCH][misc-next] misc: cardreader: fix spelling mistake
 "invailid" -> "invalid"
References: <20181206091936.11871-1-colin.king@canonical.com>
In-Reply-To: <20181206091936.11871-1-colin.king@canonical.com>

--cTP1uIVH3BeszxpHWKz2jT13hojFzjLwR
Content-Type: text/plain; charset=utf-8
Content-Language: ru
Content-Transfer-Encoding: quoted-printable

Am 06.12.18 um 10:19 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are spelling mistakes in a couple of dev_dbg messages, fix these.=

>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Oleksij Rempel <linux@rempel-privat.de>

thanks!

> ---
>  drivers/misc/cardreader/alcor_pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardrea=
der/alcor_pci.c
> index 6872b8e29b4d..bcb10fa4bc3a 100644
> --- a/drivers/misc/cardreader/alcor_pci.c
> +++ b/drivers/misc/cardreader/alcor_pci.c
> @@ -105,7 +105,7 @@ static int alcor_pci_find_cap_offset(struct alcor_p=
ci_priv *priv,
>  	while (1) {
>  		pci_read_config_dword(pci, where, &val32);
>  		if (val32 =3D=3D 0xffffffff) {
> -			dev_dbg(priv->dev, "find_cap_offset invailid value %x.\n",
> +			dev_dbg(priv->dev, "find_cap_offset invalid value %x.\n",
>  				val32);
>  			return 0;
>  		}
> @@ -116,7 +116,7 @@ static int alcor_pci_find_cap_offset(struct alcor_p=
ci_priv *priv,
>  		}
> =20
>  		if ((val32 & 0xff00) =3D=3D 0x00) {
> -			dev_dbg(priv->dev, "pci_find_cap_offset invailid value %x.\n",
> +			dev_dbg(priv->dev, "pci_find_cap_offset invalid value %x.\n",
>  				val32);
>  			break;
>  		}
>=20


--=20
Regards,
Oleksij


--cTP1uIVH3BeszxpHWKz2jT13hojFzjLwR--

--zIYITDqYwnnCBmikaZfeWZ1QHyl07uTFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlwKtjgACgkQdQOiSHVI
77QXvQf/fFdltk96GQCgEQ7tqwC01EsNV7/sQBAVjziMYGONzpEzoWP/9vusHRdD
r520x4oubWbog8tFtzj8kj4E78+X3CbA504RlAzd5pc53voZdCpx0d3nGDxVDiAt
hgJtjBRpsx4A3mgK27R0CFAaxd9iCvG+JjzXmNbLyDJvaK57Xc1bXgCd9l/Etjxf
M1C3bwMn79a8SxgLSDfXoyHflHVsYam3qKaZdmdRoSzTo0C3/PlsofkUcQA7Dx2M
UnAYRHsPYFrId506VgiW91SHbS5G6pzWOx2YyX3uBhZRN2FkXyJ27bwnBW8DdpiP
GTABtMpQ8Eap4IMalb650noU7LMjBA==
=NA+o
-----END PGP SIGNATURE-----

--zIYITDqYwnnCBmikaZfeWZ1QHyl07uTFU--
