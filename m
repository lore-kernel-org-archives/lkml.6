Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B52EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF65420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF65420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeLEUBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:01:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50902 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:01:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 47493263BF0
Received: by earth.universe (Postfix, from userid 1000)
        id 2BC303C08D6; Wed,  5 Dec 2018 21:00:59 +0100 (CET)
Date:   Wed, 5 Dec 2018 21:00:59 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cpcap-charger: clean an indentation
 issue, remove tab
Message-ID: <20181205200059.mk2canwpe3koeuhy@earth.universe>
References: <20181031184841.5673-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="roq5qfpepfms3zai"
Content-Disposition: inline
In-Reply-To: <20181031184841.5673-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--roq5qfpepfms3zai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2018 at 06:48:41PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to clean up indentation issue, remove an extraneous tab
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cpcap-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index e4905bef2663..c843eaff8ad0 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -544,7 +544,7 @@ static void cpcap_charger_init_optional_gpios(struct =
cpcap_charger_ddata *ddata)
>  		if (IS_ERR(ddata->gpio[i])) {
>  			dev_info(ddata->dev, "no mode change GPIO%i: %li\n",
>  				 i, PTR_ERR(ddata->gpio[i]));
> -				 ddata->gpio[i] =3D NULL;
> +			ddata->gpio[i] =3D NULL;
>  		}
>  	}
>  }
> --=20
> 2.19.1
>=20

--roq5qfpepfms3zai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwILncACgkQ2O7X88g7
+pq+IBAAmmyk/9B4GoMD3xObZOc/MUp7vs2QFfpxyC47SDuKUQvLyPjOnS4tinwx
el/xSPB1WNzDhfbIB+OUluFdXIJ5E5mt+fQ1BpXQHiEbN9dAOtg/SUD4MmEENT8I
58y9ueFC8fS3G9gcjsBN8fDbmgY4Je2XtSfL0uuhAuNHoMFsxLCfecdHpRog5PF7
mcQUZp5QI7nzIn/x5W2R0eUakGFV2sNxqHAz7m63v0PXsVQ5huXz1PPgFvyghtbn
+xNi/HmBr65bJI2TPXiprw6yWjg2Se575AgAl5WOzkWUR+DLFq87UhyUn+TZ7AIN
qJePO4peAqxgHbJICUJmlx5E3G5LrFK3w/YWq25LpP3Fgqg4+L0bYJCWe2ywo/vw
ULCBckfXYmJI6fwiVdl0lxeZOSINcMD+T2oJx5it8SoZZVRF+AYYKQM4xEWPbNHD
YAHG2Cia86OCBn4waJUbDdbMv2rE5Yc56vhAPJBtLZX8cza+utDcKsYm7lhbcFYB
HfpQY1tzA/OYjHQ3yJXuJJbdy3i7012hRnDk+APoVnWcLRAUR242Jq6WXMM6Gac6
HYfHz0hb7AqEp+BpJ98VrvW34chgS+Qwceb4Wr75llp9OvdgTgtd1UKjgUCazbBB
02iW9zFr3VnBZnwVLTkD3fNI+qKFMpuMzOgK6Bl7zQ1TgZY7tjc=
=5edf
-----END PGP SIGNATURE-----

--roq5qfpepfms3zai--
