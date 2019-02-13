Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA29C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3E12190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jKlc9d27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390177AbfBMKgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:36:52 -0500
Received: from ozlabs.org ([203.11.71.1]:45325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfBMKgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:36:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zwtk6ykBz9s5c;
        Wed, 13 Feb 2019 21:36:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550054209;
        bh=qu1j7e+/XfN3r68QnpuKQtvFIrsJBgpxOzTKl/EVpJ4=;
        h=Date:From:To:Cc:Subject:From;
        b=jKlc9d27Tj9sPQtXXLiKUJa6lqIvEnrgYe2HBudq60DrM6tHmLOp3hM0cBluOGy4b
         z+Cnj0Lwdax9LcHr/bd3XpQ2yz5FPLFGnDBSYnkxVS43gwiVzwTB8yaxbDl+luBz3g
         s6BwoL5ZLtn6cY4NzVcxqCEDImwTmkKTM/kEYIZ9sWX2Fw1h1+8ZE02ec8Xkkwr3k/
         8THuy6jguvjNJccpW2zvVOQamcTohVJUCdBOgZBy3BPm5yFXaJ/c/EQmP8QSYnUDPR
         j+FAc1D4N+VQ90nbzslhQnOWRkd7AY627lvekv8WxX8wYFGZr11scZmOUzdmQekLGq
         EpFgmccJs5Qbw==
Date:   Wed, 13 Feb 2019 21:36:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: linux-next: Fixes tags need some work in the drm-fixes tree
Message-ID: <20190213213642.2d980994@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F7mdYu/8dbNmNNZxbk8NiyX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F7mdYu/8dbNmNNZxbk8NiyX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bb867d219fda ("gpu: ipu-v3: Fix CSI offsets for imx53")

Fixes tag

  Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

In commit

  2c0408dd0d89 ("gpu: ipu-v3: Fix i.MX51 CSI control registers offset")

Fixes tag

  Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/F7mdYu/8dbNmNNZxbk8NiyX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxj8zoACgkQAVBC80lX
0GzRVAf7Bs+SIUV1xY2TI78/YhLT38xA+p4+nm8tSDcNnsjAI80+J8PkcRaSUktR
pe8Och0obcwgc5JZL4/JGCSkuD4fNk1ap0mUfaRTjHeDJQQ9ODe0AbDI7HeZvZsE
x+hAT3J+DWlue6/23Oo/fAPGpBq7b7STNv8dedpxWJXnuu6kzMX4zh8bH/BvnwSa
efvPZH3FfaDwzumH4DUhJjqcmfPY3mFjlG+0R8KzT0QjjGn2FjruAo4MBP52BSKm
97Mw+Ne1P0RODX9zxnkzF+aaSNo6AGEAacSTHvihLMyCNoKxVBndTvg5/hIz+bMs
CZUlauU3M5X2+1TMPveBGOw9XRX9TQ==
=9MM2
-----END PGP SIGNATURE-----

--Sig_/F7mdYu/8dbNmNNZxbk8NiyX--
