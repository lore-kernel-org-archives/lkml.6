Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F86A20879
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545255704;
	bh=lKZ25CHKlonpCz1tny4nKrDq2cxMqK+iFI1Ov1WDzkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZS7Bux3kb83ZJQh+VdYmMfl/GYmE94AwcTXjrRsYpeKwT7nxWQEhMywee7SYfVeHX
	 C3An4LjLIWqM7TJYEBQljh2VmTYzrZmW2vVhJCzzOhKIxEosz/x0W636i74jsRHVnk
	 P4VE6HHUSt4C5IZUMoQTBV7Ter9QqlIhq2XLXaTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeLSVln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbeLSVlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:41:42 -0500
Received: from earth.universe (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038682080D;
        Wed, 19 Dec 2018 21:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545255701;
        bh=lKZ25CHKlonpCz1tny4nKrDq2cxMqK+iFI1Ov1WDzkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpX3b4+mBUSKQaf+NDMu5/g0CImyVJFU/EXUB+Qe0s/Upw+eURkaphKKTKS0CiyGt
         ZK5I8IKzi+tVzP1NfvHU9xMZzaIeZNW56+JN1j2Ru3k3P3ZWkD5+teoMe7eDFXA3j0
         gXG0dHNN2X+TwRmkePTHns0MF6Xo7/NF1G3hdy80=
Received: by earth.universe (Postfix, from userid 1000)
        id 768973C08E4; Wed, 19 Dec 2018 22:41:38 +0100 (CET)
Date:   Wed, 19 Dec 2018 22:41:38 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/7] drm: omapdrm: Cleanup drm_display_mode print str
Message-ID: <20181219214138.hp4xos7ozlgmnzaz@earth.universe>
References: <cover.1545254191.git.shayenneluzmoura@gmail.com>
 <fcf15d6f35c9e8e3fcc1136e55a0fa3d4fccdf57.1545254191.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="czgalbrsb2hhfpv5"
Content-Disposition: inline
In-Reply-To: <fcf15d6f35c9e8e3fcc1136e55a0fa3d4fccdf57.1545254191.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--czgalbrsb2hhfpv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Tomi is neither in To, nor in Cc of this patch?

On Wed, Dec 19, 2018 at 07:22:04PM -0200, Shayenne Moura wrote:
> This patch adjust the print string of drm_display_mode object
> to remove drm_mode_object dependency in omapdrm files.
>=20
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/gpu/drm/omapdrm/omap_connector.c | 9 ++-------
>  drivers/gpu/drm/omapdrm/omap_crtc.c      | 8 ++------
>  2 files changed, 4 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/o=
mapdrm/omap_connector.c
> index b81302c4bf9e..874d8f3cbff6 100644
> --- a/drivers/gpu/drm/omapdrm/omap_connector.c
> +++ b/drivers/gpu/drm/omapdrm/omap_connector.c
> @@ -305,14 +305,9 @@ static int omap_connector_mode_valid(struct drm_conn=
ector *connector,
>  	drm_mode_destroy(dev, new_mode);
> =20
>  done:
> -	DBG("connector: mode %s: "
> -			"%d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> +	DBG("connector: mode %s: " DRM_MODE_FMT,
>  			(ret =3D=3D MODE_OK) ? "valid" : "invalid",
> -			mode->base.id, mode->name, mode->vrefresh, mode->clock,
> -			mode->hdisplay, mode->hsync_start,
> -			mode->hsync_end, mode->htotal,
> -			mode->vdisplay, mode->vsync_start,
> -			mode->vsync_end, mode->vtotal, mode->type, mode->flags);
> +			DRM_MODE_ARG(mode));
> =20
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdr=
m/omap_crtc.c
> index caffc547ef97..40acf4ce7c9f 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -427,12 +427,8 @@ static void omap_crtc_mode_set_nofb(struct drm_crtc =
*crtc)
>  	struct omap_crtc *omap_crtc =3D to_omap_crtc(crtc);
>  	struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
> =20
> -	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
> -	    omap_crtc->name, mode->base.id, mode->name,
> -	    mode->vrefresh, mode->clock,
> -	    mode->hdisplay, mode->hsync_start, mode->hsync_end, mode->htotal,
> -	    mode->vdisplay, mode->vsync_start, mode->vsync_end, mode->vtotal,
> -	    mode->type, mode->flags);
> +	DBG("%s: set mode: " DRM_MODE_FMT,
> +	    omap_crtc->name, DRM_MODE_ARG(mode));
> =20
>  	drm_display_mode_to_videomode(mode, &omap_crtc->vm);
>  }
> --=20
> 2.17.1
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--czgalbrsb2hhfpv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwauwcACgkQ2O7X88g7
+pqULg/8C4gQ7GUZMIyC25wjrf/BTPzRAxrmLVnFDVxC7HGoXcTDIRluWqjxMuCL
5K+UqDFBstzUZTsD21mowlAabwUNpSpBDCfl9ls7dlCsVjaw5cSm1/ImI//N10Oj
HHa/4NwfU24q4zb7NrIsuXEGhelY8n7jAiUOW8m4xKNmuGDkFAeLx8DaUk3bs7pc
XSpgkh2+cLFdQUuqsbpfyDXP8VcXTLrjo6Nh+pT/+F8z90mvO3PZ1gwhCQ2On8Sb
PkZwE0rY2g+hCrLGH+cunFmJEANTT2rz7v1f2EfqLTdrgS6VnfoWKV3V9eZI2c93
KBeQA4C48pO4oVD7gkF4XarhM7mroW8BTt/gEUJR7UXVR1iRVfhn6bniUlqXhf+Z
zJ/CM5QhlzP3yJ4ECYDZdsYJV1dKgHG+/SZzvpyt+jt6y6mHvgG3t6Zd8WaSBhh8
Dj1UTJ3hqiwfJnP5guEvjxSyaEtryFS7VxXT4ReSqKpjz1YCHwKJlVWiNVk/eZYD
lok4girWmlHRsQXw9alVXljGM3xAq+nmHOzRFqFwtUyr1VcKbjFvNEIarbK2RrKH
nezKkKVRTMsEE5/w3s/EbW20wzEfblQQC7qF2i9+mCVmiEcJiMkox1frRftRdmEN
XNvFHxJeEx7CvlZLHoK4AoNVhQ+M3RPOQHDTiI5sIpfhNXUuk9U=
=usqI
-----END PGP SIGNATURE-----

--czgalbrsb2hhfpv5--
