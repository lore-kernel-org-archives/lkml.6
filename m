Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38B72073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbfACX6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:58:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:10136 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfACX6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:58:14 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 15:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="asc'?scan'208";a="307317554"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2019 15:58:11 -0800
Message-ID: <2320c3ac2267d17ee9fc9ff3e3df60b7ca405590.camel@intel.com>
Subject: Re: [PATCH 3/8] i40e: increase indentation
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Jan 2019 15:58:10 -0800
In-Reply-To: <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
         <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oOAF8TjtRf0aCJUZCgtF"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oOAF8TjtRf0aCJUZCgtF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-12-30 at 16:53 +0100, Julia Lawall wrote:
> Convert spaces to tabs to get correct alignment.
>=20
> Found with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Dave, since this is apart of a series, please feel free to commit this
patch with the series.

--=-oOAF8TjtRf0aCJUZCgtF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlwuoZIACgkQ5W/vlVpL
7c4q4Q/9HV1bScv5PDC+lpElx2jqV1XUfal/HCgE6Ygfkq9iFdXQhVaOmo00jHJm
hX+dhCMU9sulZBtXK93z65pvhPHcurBYdfpoddp5i5meUiqO4mgSqpLC1T1dM5z+
Zg/v5/Yhqyrt3KyoUa1bC9HcIzvKcTrSXsdtIa9eDimhAztduZ0iXWfGa/YBCp10
Un36XBEYb71HqcQs0QYYFeaGKoTCBITTr59amLWvZQWNn2x0kWcGAp6TDL6GElrQ
vZwpiw1vdD2JmGYUh8N1JDK4jHnX3xJhcD+JYgW99uvkMAmPpOZ/U8x1Z+hfMWWp
4pxY6BmwlwGdKcF5A45P9gRI8H6YAslFXW9lQ5QQCreGPAhHsT1m0g38YzeBt18R
v8D3B86PYebk5LjU1kXT3VlpQo2EfYiQ71oAWgF6s9ryV/L4JRw68sCwH2xi7wua
E6OoGgfpqOHmx/KmzCgIiW2aGkPj5l0BxmSpgEVfiTjJCBJSDItiVxUj3kAYfokW
5Ju6vVtWElv6TWzeMEulGDyX2VvFwIOzVQdCG8Wqy7jtRqU50iasQ+VfwzIytIqJ
2RNh6umRHryCLIQIngPxhX9KgpUa6hII9Huq3PVcQJMfkWMtk0UAxypP1fItSoQr
z/TCtc+BwVFt/aJnujvO/qFOsV8WR688wZuLcqU2yKLbRaDkP94=
=GIKR
-----END PGP SIGNATURE-----

--=-oOAF8TjtRf0aCJUZCgtF--

