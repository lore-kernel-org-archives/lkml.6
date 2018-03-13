Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeCMCma (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 22:42:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:20450 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeCMCm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 22:42:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="asc'?scan'208";a="36780208"
Date: Tue, 13 Mar 2018 10:34:42 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: Colin King <colin.king@canonical.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][drm-next] drm/i915/gvt: fix spelling mistake:
 "destoried" -> "destroyed"
Message-ID: <20180313023442.g7i2cyudsvqf7l6k@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180312114358.24456-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zkgfnu4cdiknmifa"
Content-Disposition: inline
In-Reply-To: <20180312114358.24456-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkgfnu4cdiknmifa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.03.12 12:43:58 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in gvt_err error message text.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks Colin, will pick up.

>  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gt=
t.c
> index 0a100a288e6d..8eb76becd676 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -2046,7 +2046,7 @@ static void intel_vgpu_destroy_all_ppgtt_mm(struct =
intel_vgpu *vgpu)
>  	}
> =20
>  	if (GEM_WARN_ON(!list_empty(&vgpu->gtt.ppgtt_mm_list_head)))
> -		gvt_err("vgpu ppgtt mm is not fully destoried\n");
> +		gvt_err("vgpu ppgtt mm is not fully destroyed\n");
> =20
>  	if (GEM_WARN_ON(!radix_tree_empty(&vgpu->gtt.spt_tree))) {
>  		gvt_err("Why we still has spt not freed?\n");
> --=20
> 2.15.1
>=20

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--zkgfnu4cdiknmifa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCWqc4wgAKCRCxBBozTXgY
J8MCAJ4rhkHtaLw/o3jDxpLeMnewA7qXowCfbrXOUcjnuVC5LfsV4uu6/UEVqac=
=Wm9f
-----END PGP SIGNATURE-----

--zkgfnu4cdiknmifa--
