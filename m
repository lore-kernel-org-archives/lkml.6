Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB133C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42AD20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HYB1ynGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfAQVQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:16:06 -0500
Received: from ozlabs.org ([203.11.71.1]:34581 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfAQVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:16:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gcLp2CJ4z9s9G;
        Fri, 18 Jan 2019 08:16:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547759763;
        bh=QB8HmW8jkY8FacfGGZW9oBndrV+hEU9R9odC97b3JKk=;
        h=Date:From:To:Cc:Subject:From;
        b=HYB1ynGwGo4krk/aI7NFE8TtAAGS4AY4Ky4VgXU79idcYInQWh4wg0O7tnKKIT1TP
         pzSYSkJr2dCIdRkv43M4um9pCVpQBQfgv8nhCCJsGuK+8bQ9VDoODBrcEdTv7FEG4b
         Up9s1BAG0bUsjZA6fr+rGtPqo1RjgjMuU7rvkbT4FOKIRlbyEPh4k+Wh+kiWGJsXgk
         3ExEv5rRPEbFnqPjyY+ZnWkf7LwN1CMLmh7NSDNk8Rg12FStbVxOxTrN2uGUxvcqEi
         a81GoZALnAe8TMjeLQ7XRa+Je/uJwchL615FFnGKdGOpK4ntgF+HgKAmzEKC3p2bmz
         7FCuINTvop5Bw==
Date:   Fri, 18 Jan 2019 08:16:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anand Moon <linux.amoon@gmail.com>
Subject: linux-next: Fixes tag needs some work in the amlogic tree
Message-ID: <20190118081601.7d60679d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TzLGpye+9mTmxywcGg11Lja"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TzLGpye+9mTmxywcGg11Lja
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2839b54d4cae ("ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning=
")

Fixes tag

  Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)

has these problems:

  - SHA1 should be at least 12 digits long

Commit

  f01d1f474076 ("ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator pow=
er failed warning")

Fixes tag

  Fixes: 5a0803bd5ae ("ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes")

has these problems:

  - SHA1 should be at least 12 digits long

--=20
Cheers,
Stephen Rothwell

--Sig_/TzLGpye+9mTmxywcGg11Lja
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxA8JEACgkQAVBC80lX
0GzeBwf9GZ65sEI+qh9w5sIb2Ms8jvyHqkdpbgQwkv7k5ryycCJ4zycRGZCbViCN
Sfk/xGfWObpEXUI8f8A/ahEbqpEMkyUWWct5Cz4EeLPPsN64HJ/QyadPoopshmjs
aFddrrNt9zac2XrfeDIbJI9JOyUmEYzVrQfpfol9W+lPJ1/A4CUi2Slke2PjZn5z
B+jXDG+4bhdHeDT6LYFb4jxjuvV/6fodCtNDpiUYm1Jf3v9qbZnpj8m9DffZkV9H
wdd9rjl6CEoYBjpzhYzOLdyMBIoaxm+s1f1SgbEaD8YJOlBnaLcizc2sKKAOjSBd
7iEpeeZzprvGI0IImo2B2lz0TFVZtw==
=ZRnt
-----END PGP SIGNATURE-----

--Sig_/TzLGpye+9mTmxywcGg11Lja--
