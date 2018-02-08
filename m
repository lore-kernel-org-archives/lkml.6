Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeBHQwj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:52:39 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37743 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:52:37 -0500
X-Google-Smtp-Source: AH8x226WRwJVXpZbOUPawzeHc+awXTztmY4hvn0BusxlFT6lZvhZ+6ii3IRM43zZjzDpDuZ09xf46Q==
Date: Thu, 8 Feb 2018 17:52:33 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: Removed duplicates in DMI
 whitelist
Message-ID: <20180208165233.t5oywk7ikjds6gnk@pali>
References: <20180207221226.11345-1-alexander.n.abrosimov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yfhgoliowzcfaozs"
Content-Disposition: inline
In-Reply-To: <20180207221226.11345-1-alexander.n.abrosimov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yfhgoliowzcfaozs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 08 February 2018 01:12:26 Alexander Abrosimov wrote:
> Fixed a mistake in which several entries were duplicated in the DMI list
> from the below commit
> fe486138 platform/x86: dell-laptop: Add 2-in-1 devices to the DMI whiteli=
st
>=20
> Signed-off-by: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> ---
>  drivers/platform/x86/dell-laptop.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-laptop.c
> index a7b141992cb3..a66a6a6e47b9 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -125,28 +125,10 @@ static const struct dmi_system_id dell_device_table=
[] __initconst =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>  			DMI_MATCH(DMI_CHASSIS_TYPE, "32"), /*Detachable*/
>  		},
>  	},
>  	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_CHASSIS_TYPE, "30"), /*Tablet*/
> -		},
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /*Convertible*/
> -		},
> -	},
> -	{
> -		.matches =3D {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_CHASSIS_TYPE, "32"), /*Detachable*/
> -		},
> -	},
> -	{
>  		.ident =3D "Dell Computer Corporation",
>  		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
>  			DMI_MATCH(DMI_CHASSIS_TYPE, "8"),
>  		},

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yfhgoliowzcfaozs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnyATwAKCRCL8Mk9A+RD
UlHyAJ4s15C7UhMWXpDNyD7fc6a104FzTQCfVXOt9uiHUEX320ytxzBLD2TxAJs=
=IEfl
-----END PGP SIGNATURE-----

--yfhgoliowzcfaozs--
