Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8DAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5042173C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H6X1xtxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBQWZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:25:40 -0500
Received: from ozlabs.org ([203.11.71.1]:44093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfBQWZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:25:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442hQn0XV9z9s5c;
        Mon, 18 Feb 2019 09:25:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550442337;
        bh=FMsOyrLb8Uj1yR1/6pKfsXqvyNv2Y8di++628C7dwYs=;
        h=Date:From:To:Cc:Subject:From;
        b=H6X1xtxwc9G9c2u5BoIb0IqCFFDd/Q6uzZUUgJ+74cN242FGtq9N1IW1fw11KFMY+
         Y+CrsIMyJ305B64jpHL44BjJ2JrPiMIxSnvfw9rVwK1JiAElG6FphFcDovFn4YRZcx
         ifPAzs65ypzE9/wTAGRifySZUA9CE2MDqeXEQFzjomQqXPJQJc98/6VJX5o/Z16pHs
         7UWwtULk5K1w+h4N9S+GtSMJgEtUINWQbCzoA04IglMWrhCfQxjwH/v9gLHiS9nYqB
         1rYGFPoRjft24srcTMyLjhqbVFUtyHmzF0BzR7LBk77Rtg4/Tq6IegWlN1/mpPNfup
         5vrAKLBZk9Iew==
Date:   Mon, 18 Feb 2019 09:25:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190218092536.39375e84@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AqoQsNNfF.q797PdzhkxiTK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AqoQsNNfF.q797PdzhkxiTK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

In commit

  a5a0bbca16cd ("pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins")

Fixes tag

  Fixes: 0fefcb6 ("pinctrl: Add support for Meson8b")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/AqoQsNNfF.q797PdzhkxiTK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxp32AACgkQAVBC80lX
0GwSiAf/d52sVL8m2hkopn783J0sssYeK8taD3vLq0MiOBzO+FrZx2IyBoprFmaD
VZR7fD/nbws5TOMr0G2aH/6EJVV8jpXs33zHOedOmjH/EVv36NUf/VTht9sZZqd/
XA2KeuFHqMExE8SEjBtaFOF6WxsHz3DcCoE/3q2H9K+JQlAUbRRwo1HJyvaHH+Ct
AGhpJJv/lUa010dijRGJBs1IJ4V16ek+wcBcboIj3i986Lc4I6qni78mGoshhsNP
YCeicknpDrN5/dnIFX+3YGs1tNsodq1OdlqNhPeng6FdZ2NVYQrCFO139EsBRq3L
+uhDAIPIryhLIf+raeQW6ogaY63tEw==
=jKSz
-----END PGP SIGNATURE-----

--Sig_/AqoQsNNfF.q797PdzhkxiTK--
