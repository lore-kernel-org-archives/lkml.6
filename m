Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3008C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940924604
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6940924604
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934567AbeFVQrF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:47:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:47763 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934495AbeFVQq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:46:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 09:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="asc'?scan'208";a="60192481"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2018 09:46:26 -0700
Message-ID: <7dd4d483199724925d4f380a8908e2546b4d12a2.camel@intel.com>
Subject: Re: [PATCH 3/4] Documentation: e100: Fix docs build error
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 09:46:25 -0700
In-Reply-To: <20180622003708.31848-4-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
         <20180622003708.31848-4-me@tobin.cc>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-c3xq0ahnNLQD4DPX5CLA"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c3xq0ahnNLQD4DPX5CLA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 10:37 +1000, Tobin C. Harding wrote:
> Recent patch updated e100 docs to rst format.  Docs build (`make
> htmldocs`) is currently failing due to this file with error:
>=20
>         (SEVERE/4) Unexpected section title.
>=20
> This is because a section of the file is indented 2 spaces.  Build
> error
> can be cleared by aligning the text with column 0.  While we are
> changing
> these lines we can make sure line length does not exceed 72, that
> newlines following headings are uniform, and that full stops are
> followed by two spaces.
>=20
> Align text with column 0, limit line length to 72, ensure two spaces
> follow all full stops, ensure uniform use of newlines after heading.
>=20
> Fixes commit (85d63445f411 Documentation: e100: Update the Intel
> 10/100 driver doc)
>=20
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
--=-c3xq0ahnNLQD4DPX5CLA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlstJ+EACgkQ5W/vlVpL
7c6RHQ/9FBlPwHnbLmmHd8IW5LLYBWgAvyyvIAc4nkyRTjyoT9vj08RbIW2mTG6J
7RFMNKBotpsUB7z0B/GZzssa2ykaznfDmu6jbcswnGrs2KlTSUyMGwxEI/T9lWkS
WXSj478dSbIO/8mfube6isxyL3L+/4ijyVYG5gt10I7qjtw7EASwk2yGt2gbebHA
KoICManFWkP6eD8nNEDzXmOw/p/EH/3J6TNTu2XjWXoyz8Y3f1kOJUbiuPl+ECyO
gucYCDtIFRrDe1HQ5LGkM+nlBuEeoB859gBZb6VfiQu0ZOGXNvD++vU3u/6b1lKq
Tbo+ccqIrDYBMbUJR0gRgu9kCorCUgMSnr7ialkRmKZoUyUBji04bYLXbC01M0p8
7fAWTMFD79MYkMPYKKhOik16W6gtxgbkCSfxLN07vjFCeULeDHnphN4b3dZnff8e
N1Sj0/Zmuk9Rnsfgo9fgzFEK/tjNQEz2EKqsss3iCERF5kDIOGyIuv9M3zQfMLhk
FxSJrsK3HeCka3HMpQPk7L3P5/0SKLc8ZXzvknRDYHjCsIzJM9Kn9Yq9Vc6Zoqa0
y/BwhNm1rOvg3s/Tv7tYKVvvTj1vYUyGBxisy41zhki6dP5N8YHVZe4ldxBxoY1d
sGqoHnQH2rC6zFHX2xMzCzAFZuD5fpU5kWjFPzO+UM4wYS9WWZg=
=4xPf
-----END PGP SIGNATURE-----

--=-c3xq0ahnNLQD4DPX5CLA--

