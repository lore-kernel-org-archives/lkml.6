Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933832AbeB1RQ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:16:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:55316 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932363AbeB1RQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:16:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="asc'?scan'208";a="34362288"
Message-ID: <1519838202.7902.2.camel@intel.com>
Subject: Re: [PATCH] e1000e: Fix link status in case of error.
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To: Benjamin Poirier <bpoirier@suse.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2018 09:16:42 -0800
In-Reply-To: <20180228052006.12074-1-bpoirier@suse.com>
References: <20180228052006.12074-1-bpoirier@suse.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dYk7EE0c69HXZkRp/BCL"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dYk7EE0c69HXZkRp/BCL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-02-28 at 14:20 +0900, Benjamin Poirier wrote:
> Before commit 19110cfbb34d ("e1000e: Separate signaling for link
> check/link
> up"), errors which happen after "get_link_status =3D false" in the
> copper
> check_for_link callbacks would be ignored and the link considered up.
> After
> that commit, any error implies that the link is down. Since all
> combinations of link up/down and error/no error are possible, do the
> same
> thing as e1000e_phy_has_link_generic() and return the link status in
> a
> separate variable.
>=20
> Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link
> up")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

A minor nitpick, almost every patch you send out, has your patch
title/subject ending in a period which is not needed or wanted.  Patch
titles/subjects should not be complete sentences, so they do not need
punctuation at the end.
--=-dYk7EE0c69HXZkRp/BCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlqW4/oACgkQ5W/vlVpL
7c7UvhAAgKYScTugDY9MeGxIqbFFMgVt5r00sUlKA9rbxhOBw+9GH/Jkex6Njagx
sg99+ge30xdsQEec7pW9pnzFmf4Upm0PAjNB1rRLEdBah73aLKJZS4W1S8KtTYlB
cjt1c+Dq2EultiUtx6u4NwG72pZliShrCGD0jVYz3cYJP2DcOSgxUjqwCHotHTMG
Qp/2a2ZPdJ9Kvu6dvJeT+5HbOvAsBl2PxNG5tZaawtNxVwOQoVGTtktlLIIyTB1t
ftDnrY0nFFJTJnEus8ZNDqVb7Ca8AGLNcbd9ckYEq+XtVB3sL1dBgv5tQ+akqpYc
DmTOsmIgzSB2PRU7N8T1Mntc6FaRSUNW1+0l6IykfQEsdtO0kcaJ2gy0L4r9kViN
nCega+mQXufWg3di84cp2qlIUTLjCgoGdJ4OWKmnjx0Qk4OL3agbE6T5J4V8NtFc
srD6AAf+PEpa2cC6lMAh/c0k0hocE82hKFovqsnqlmbGHJ6MS2G7UX5ZhhM/FWJI
VrUxqUO3bjBGEUHa3Pv9QiLJRo2wrggqXVATFPJObBB8QUXD5SJMF/7vS4jJh57G
9NsmWz8h8lt+OIrjgRTh6SpBQ80PloXSb+5T7YEcuN0L7d1f0DznqeJjZpx44c6o
S/cS9EkKIM5x/cInAIH7nSEADoSySaBqw83h0S1dPT7WHQ8iakA=
=aD1y
-----END PGP SIGNATURE-----

--=-dYk7EE0c69HXZkRp/BCL--
