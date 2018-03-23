Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCWC2H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 22:28:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:21706 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeCWC2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 22:28:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,347,1517904000";
   d="asc'?scan'208";a="27321774"
Date: Fri, 23 Mar 2018 10:19:57 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt/scheduler: Remove unnecessary NULL checks
 in sr_oa_regs
Message-ID: <20180323021957.c633yivqis2ilqpl@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180322182154.GA21590@embeddedgus>
 <152175429362.23562.9645295347693081397@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kzt6qbsahbmynyur"
Content-Disposition: inline
In-Reply-To: <152175429362.23562.9645295347693081397@mail.alporthouse.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kzt6qbsahbmynyur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.03.22 21:31:33 +0000, Chris Wilson wrote:
> Quoting Gustavo A. R. Silva (2018-03-22 18:21:54)
> > The checks are misleading and not required [1].
> >=20
> > [1] https://lkml.org/lkml/2018/3/19/1792
> >=20
> > Addresses-Coverity-ID: 1466017
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
>=20

Looks good to me, I will pick this up, thanks!

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--kzt6qbsahbmynyur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCWrRkTQAKCRCxBBozTXgY
J58DAJ44R2jNf4O7/GvcRpxbz9m1FwhJawCfW/VelLEDo9ncrJWOka5WjeMvT5s=
=rDux
-----END PGP SIGNATURE-----

--kzt6qbsahbmynyur--
