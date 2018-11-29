Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90745C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF9D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF9D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeK2T6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:58:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:50117 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbeK2T6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:58:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 00:53:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="asc'?scan'208";a="93868075"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.8])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2018 00:53:29 -0800
Date:   Thu, 29 Nov 2018 16:43:43 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: fix spelling mistake "Interupts" ->
 "Interrupts"
Message-ID: <20181129084343.GD12743@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20181125232524.14672-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DVXvgjZtTc9TWCEb"
Content-Disposition: inline
In-Reply-To: <20181125232524.14672-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DVXvgjZtTc9TWCEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.11.25 23:25:24 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in an error message, fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/gvt/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/interrupt.c b/drivers/gpu/drm/i915/=
gvt/interrupt.c
> index 5daa23ae566b..6b9d1354ff29 100644
> --- a/drivers/gpu/drm/i915/gvt/interrupt.c
> +++ b/drivers/gpu/drm/i915/gvt/interrupt.c
> @@ -126,7 +126,7 @@ static const char * const irq_name[INTEL_GVT_EVENT_MA=
X] =3D {
>  	[FDI_RX_INTERRUPTS_TRANSCODER_C] =3D "FDI RX Interrupts Combined C",
>  	[AUDIO_CP_CHANGE_TRANSCODER_C] =3D "Audio CP Change Transcoder C",
>  	[AUDIO_CP_REQUEST_TRANSCODER_C] =3D "Audio CP Request Transcoder C",
> -	[ERR_AND_DBG] =3D "South Error and Debug Interupts Combined",
> +	[ERR_AND_DBG] =3D "South Error and Debug Interrupts Combined",
>  	[GMBUS] =3D "Gmbus",
>  	[SDVO_B_HOTPLUG] =3D "SDVO B hotplug",
>  	[CRT_HOTPLUG] =3D "CRT Hotplug",
> --=20
> 2.19.1
>=20

Applied this. Thanks!

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--DVXvgjZtTc9TWCEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCW/+mvwAKCRCxBBozTXgY
JzHFAJ0Zcxz4D8oFO1tsTgZvokHwPgnyjACfeKctWqVMlvRAzp9DtyegAGTRiPw=
=tOOg
-----END PGP SIGNATURE-----

--DVXvgjZtTc9TWCEb--
