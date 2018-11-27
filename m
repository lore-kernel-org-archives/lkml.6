Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFDFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E06821104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E06821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeK1DZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:25:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:46497 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbeK1DZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:25:44 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 08:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="asc'?scan'208";a="93746030"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by fmsmga008.fm.intel.com with ESMTP; 27 Nov 2018 08:27:17 -0800
Message-ID: <2c43f30e8af44350d2585e48f4fade5e8b93ce0a.camel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     David Miller <davem@davemloft.net>, jelsasser@appneta.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Nov 2018 08:27:33 -0800
In-Reply-To: <20181126.205247.1196368459821644290.davem@davemloft.net>
References: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
         <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
         <F6168EB4-8C74-456F-B571-6492162CFA0F@appneta.com>
         <20181126.205247.1196368459821644290.davem@davemloft.net>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GCYkdZdqfpEkSaGQum8j"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GCYkdZdqfpEkSaGQum8j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-26 at 20:52 -0800, David Miller wrote:
> From: Josh Elsasser <jelsasser@appneta.com>
> Date: Mon, 26 Nov 2018 16:54:11 -0800
>=20
> > Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
> >=20
> > > No need to re-spin the patch, just reply with the additional
> > > "Fixes"
> > > tag and if patchwork does not pick it up, I will add it to the
> > > patch I
> > > have in my tree for validation and review.
> >=20
> > Thanks, let=E2=80=99s try that.
> >=20
> > Fixes: e23f33367882 ("ixgbe: Fix 1G and 10G link stability for
> > X550EM_x SFP+=E2=80=9D)
>=20
> Unfortunately, patchwork isn't smart enough to pick up Fixes: tags
> still.

:-( I will get it added to the patch in my tree then.  Thanks Dave for
the info.

--=-GCYkdZdqfpEkSaGQum8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlv9cHUACgkQ5W/vlVpL
7c4AVxAApo7ftOCzmBoD4+o9s6l9sYb44hJYC3W/dmA1zUoZbdUVq9USUr1KRN4v
PEHaGO4qQ9w9f7jOl4dg24MFXEVf5TnDgtvV959L9zdCY6imA0b7G3aaKGbpERpl
SH6a00R4N4+/uyKcHzTGyTLW1H7dgmo4UwlYd4JamRQdpVI65tKhTBKI/kFpnTbv
kY12crr5MqQB7K1x0WrdY6wVYZPS3elgnLe7mWsGePIVyL8Hs7PE9OuM2rMMt09l
ceE890j0x7e9cqOVZ9jWPIQlW3yz5WXR1DgTytlT/kyCqjsfP/B1YBwf+LjxHsNj
nnEjm+HZ2h3aqrQ4CXKo0CH4vxPWO+gh3nyV33wtGZXDuiXp5xmcZzX1AbWppTkA
uxckHl8bGWuy7iYSuRzS0USjGePqbQnvvPKyFm6V6gIWt5KEk0A/JB96Uo9jdfLU
LoLdA/O5LTRnLN1axh8kqiROrqCIpKSGF1/Es4GJSoZ/MhJZXN80myKRk60wb7SG
nRYr764rJuXWSNNT0dDg8c0gC36cHXAJptFNgk1cVWcqdK3VVuKb5N7U3xPGvRlD
UPztXDvF8mBl01lfZHUeU4Hv7n7u4Uh4pOeeeBSizxoUWkfFwTzaVwOSJ882nNXO
gh4Ps36ILiikC7xmZPu1oUlBKw981613RoMzXzYO0gKW/ZRv3uk=
=BDkI
-----END PGP SIGNATURE-----

--=-GCYkdZdqfpEkSaGQum8j--

