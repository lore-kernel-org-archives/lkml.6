Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F262C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44B121850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RNenqnSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfBZUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:42:51 -0500
Received: from ozlabs.org ([203.11.71.1]:35697 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfBZUmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:42:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4489k011w6z9s7T;
        Wed, 27 Feb 2019 07:42:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551213768;
        bh=84iqr78YSxZxKTkRqxaJktn2kV1CB1LP90BVJQDBfYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RNenqnSG2cCFY+Tb1yr0M9DaKOIpC08SU09+Ss8EhAEBdoHjAxTiTV7lMqklcsiEq
         9/qYxrS54JR7pNoXRcUPHj1x0bJpK9/zlVRbJKPZB2QaxBu02RfEdt43pyeon3BZlJ
         73r8Bp7LCpwex7f7kgq2XirSWEhP7dLWjaAk5zXAWfmn2//1gbPdDwom8DmH3trZIm
         Rua2v9BzKluZQwOIbXZpRZb9P7Acp9Mnt4Yv0gzS8iB7zG1FkXTiUVWxfHg/hnsSmw
         G5g50DtaCrOK2vO5JZ1fGfeOtwXbe/YavtdrEqfKFgQyl0dh1TF4AuVavfC6mi/nFL
         58r3Lcu4oKFNw==
Date:   Wed, 27 Feb 2019 07:42:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20190227074239.2574e3b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q9RCVH6I7eZUC8axiqv.Siu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q9RCVH6I7eZUC8axiqv.Siu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8af6c521cc23 ("ASoC: rsnd: gen: fix SSI9 4/5/6/7 busif related register a=
ddress")

Fixes tag

  Fixes: commit 8c9d75033340 ("ASoC: rsnd: ssiu: Support BUSIF other than B=
USIF0")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/q9RCVH6I7eZUC8axiqv.Siu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx1pL8ACgkQAVBC80lX
0Gye0Af+N9Ach8AB9NV5xwu2HvjVlY1axVmRz5zz542V5w+hzt1RNmZpHBRoYjSU
A+QW8hqAPAORNLBUGLrdqQcyBGRt9wLsezT7sblENGqTRJxHycekIS23v1xG2POS
CTiRrPd2H2vte5x/jgi1aUJ9kZY01eFtVV5MG6WqXQmFEDvvcdg11rh5II2vMECs
1v5uOuhFlQUBHf/b/NZlZdHI5EcKAc1mja8v3ECjGMsCsGF8zm4N+1m+y2nXLXNK
8QKnfxGLwMTP72avL5Oet4VjGOsVXET7DndQQHWxoW2Ao/3jMTP0xwP4gkBu0+zE
CSwZugWQrS4Aap66Kt0DfEaHo8vdQw==
=L99B
-----END PGP SIGNATURE-----

--Sig_/q9RCVH6I7eZUC8axiqv.Siu--
