Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB46EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nVkoRt5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfAQUuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:50:05 -0500
Received: from ozlabs.org ([203.11.71.1]:38321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfAQUuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:50:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gbmn3g1lz9sDX;
        Fri, 18 Jan 2019 07:50:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547758202;
        bh=er0Q9zRFkRTuo5yGEjTDwkgRYp6+nHRFd+0OGpiEey0=;
        h=Date:From:To:Cc:Subject:From;
        b=nVkoRt5QJnnF816Vztrn0c987EWMqnEdGrwDhioxgU4R8Np6uqb5KJY3rweJ1rew/
         mpD3mFl3jfLRUWyPZyzG/XMEopZvBf9p7ZJjcKszVvlTWKcKyPobCVqZ3MFXOIwFoF
         FUb4d/ysrJSAmY8Ob+rJDRcw8w8A6yJegowv2TbYQjxv+dSc1rGSAHIGzW8E1xE21/
         WoRH+nFbFrdm08IGeTuSK+pPhRISRqUN6X7oG1ZNh9Guy7L3Zip+XvsTCh9+H2ltgi
         DwzF2R94hir+hjXpmXMZqsNkAowm+bxTracqRoYVAGkzOkn/M+OKmLZNnhWTQYSIsd
         aEqEfpB+u1fOA==
Date:   Fri, 18 Jan 2019 07:50:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>
Subject: linux-next: Fixes tag needs some work in the imx-drm tree
Message-ID: <20190118075001.6ce1d088@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3UE/NSD7f7zVGAmH2yIIzUU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3UE/NSD7f7zVGAmH2yIIzUU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

Commit

  bb867d219fda ("gpu: ipu-v3: Fix CSI offsets for imx53")

Fixes tag

  Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

has these problems:

  - SHA1 should be at least 12 digits long

Commit

  2c0408dd0d89 ("gpu: ipu-v3: Fix i.MX51 CSI control registers offset")

Fixes tag

  Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

has these problems:

  - SHA1 should be at least 12 digits long

--=20
Cheers,
Stephen Rothwell

--Sig_/3UE/NSD7f7zVGAmH2yIIzUU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxA6nkACgkQAVBC80lX
0GxhLgf9FbeiI4wacaLPqUs3dBEH6G7Qc/YN31GkVSy48SsLNVXHTbBYoMCTygmp
vLMqwjyOroNveI7z+0C9MaisdCsqmj3pfsyvLjqLomQr9G8q4obkcMY2FjlxMWBS
/c7AZPWHsFrHM3LFpPk+5s/DBiLATltzmb2uO4rFgFF6eD03ye+PN30+qmz2bogl
BESqVisfohgcwgLIwoS5N+FAfADHwHDuiDBZ3fqf0J7w4UjLmAx6yP93j00AJBOb
c4bQDyg+rUF94CfMSLz+hrwMjnjM8ItZ6Brtt/jMtgnqOPWxvMxmsn2WHRBNHhB8
ospZgvuBH//pJ+lT/NaNCI4pnEXY0A==
=+QMu
-----END PGP SIGNATURE-----

--Sig_/3UE/NSD7f7zVGAmH2yIIzUU--
