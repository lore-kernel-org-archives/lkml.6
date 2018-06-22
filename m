Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068AC24605
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068AC24605
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934486AbeFVQpT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:45:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:20709 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934288AbeFVQpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:45:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 09:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="asc'?scan'208";a="234767212"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 09:45:14 -0700
Message-ID: <c068cfac6f85eb8e68f7d5a1b3f301c9cbfbb51b.camel@intel.com>
Subject: Re: [PATCH 2/4] Documentation: e1000: Use correct heading adornment
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 09:45:13 -0700
In-Reply-To: <20180622003708.31848-3-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
         <20180622003708.31848-3-me@tobin.cc>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wHn9iSjWbXmBcOiz2jDy"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wHn9iSjWbXmBcOiz2jDy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 10:37 +1000, Tobin C. Harding wrote:
> Recently documentation file was converted to rst.  The document title
> has the incorrect heading adornment.  From kernel docs:
>=20
>         * Please stick to this order of heading adornments:
>=20
>           1. ``=3D`` with overline for document title::
>=20
>                =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                Document title
>                =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Add  overline heading adornment to document title.
>=20
> Fixes commit (228046e76189 Documentation: e1000: Update kernel
> documentation)
>=20
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
--=-wHn9iSjWbXmBcOiz2jDy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlstJ5kACgkQ5W/vlVpL
7c4OQhAAj5szqiidmtknGj60Knwqi67GoQrfowGLy/wIMXwUqKLHgdyIOaLkIrgh
nYjt0R+FStSKzVpbPf/Nd4XsDbXOfG6xVMUbJ9JVhnPMuk4yb6YsgGlLOlOu/asm
2NNYhuKc6RiNEKBXGZgGNK/pa9or9KrundeTTePuYrehCiRNqqyFbceT84+r7I5j
qb3rB8HngzjcEv4icyanb43uidMIPACNz+sjUXFFEJqtDHWRegguHbA6+bwNZXMk
XUhSNgq4U8P7VbPDCm6Wx7RRyJ+PgLylHMcPtAqGL7Gbt/j9bfrYpafDJk1auukH
LFjDOdUV8U855obE98V+nef1DD1IKBmmyuxNnTgZyrVO8fHcgrj3bIe4BATh5pz+
9QkESxwrEYDVWOcAzG39bLCv70feXCdXxXC89IxUuQboj7ks57xeAKU4ilh1eI+q
yqTAgJgQYJp7LOt/f12TvunrSEWlQLiZffbmxq5fftQNwBUdT4EwmCePGGMr+Ylc
IW83VK12zrUXt9/M0PeLHmNyDx4zFdvvWEKkFLkAOY3lZ6SU80Y1fMNqePkNNfWu
MaUHZzdL7lN+rWoa9Xx6621OmAIcKZhvF5J0b0cwbLK3J4wglpsJV1itFCp3FgeS
0jJ78NWZsifiaZ4BuUuBWmmqbisxT5Ne68MHxIO0hvp5n21bBT8=
=TOaI
-----END PGP SIGNATURE-----

--=-wHn9iSjWbXmBcOiz2jDy--

