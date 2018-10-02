Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C8C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3BD20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W25Gc4xK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3BD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeJCEHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:07:04 -0400
Received: from ozlabs.org ([203.11.71.1]:53929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeJCEHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:07:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PsXj2b2Fz9s7T;
        Wed,  3 Oct 2018 07:21:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538515302;
        bh=Jk4AClUuOZYoTbtQtb8rFNiAuQPdySplcbi7BB5a9To=;
        h=Date:From:To:Cc:Subject:From;
        b=W25Gc4xKqz6AbDth2a6+DvKVLQ7LzFfVFKoheKs2FzyD5dV6OuMP2YY82eAQ0/HB5
         l/RSUGDt+L7+StxNks4J/iq6XbptOx1FFg0mN6f5dU9v+gydA21WPfWZzyi6dShGd1
         ey4Jn9XrGTLWXRpNTE/3Z2OvqD6JYlIt9bczdiKyfgDZVSGY+4en02BvO0fu0zchd+
         XwJTFgDhASxtko++nZczVOqc1/sh/Wbm9VzgTI65DI8MIBS3jY21n1c6cGkQZBF3iV
         pmnN3APTJbHfu6UIA/cwUkuazuWFn7lgHR4sR6usMiGwfLWuHeQnNRNuQ/QIeY8J8T
         RuXiKRacYdziA==
Date:   Wed, 3 Oct 2018 07:21:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: linux-next: Signed-off-by missing for commits in the arm-soc tree
Message-ID: <20181003072140.7c18d772@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R05i2mNEGINKxz7p1lx0qkT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R05i2mNEGINKxz7p1lx0qkT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  6eeb4180d4b9 ("ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees=
")
  80c21c8c8b8d ("arm64: dts: allwinner: h5: Add device tree for Bananapi M2=
 Plus H5")
  aa8fee415f46 ("ARM: dts: sun8i: h3: Split out non-SoC-specific parts of B=
ananapi M2 Plus")
  db9fd9d13e30 ("ARM: dts: sun8i: h3: bpi-m2-plus: Fix address for external=
 RGMII Ethernet PHY")
  6c700289a3e8 ("ARM: dts: sun8i: h3-h5: ir register size should be the who=
le memory block")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/R05i2mNEGINKxz7p1lx0qkT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluz4WQACgkQAVBC80lX
0GxCTAgAozD5f4v6SR6WyCl1blW3dv0OqFGVM0454VPbZpb5a88fuvavZFL7LJ4c
Ya4xOM/a3oAZD7JpO9J5qX0oZ1lAQ1yz/VPVZna6EuQSDl6BPeqW0unJlVTidtuu
+C6ze2HtrYdEOCwZvQrsUe6CUVRcYqOSRdnwnaivzPI2kD95UTOgW24344Rd7xu8
+CHIsEChOAhMGUjenEC7bSmbKISD5T5s7duysWw5tcnZ1wq/lF3xHtkSSbHNwX8V
y6S1hI0Pl9B4LbrMvD03W9vGNfCh+A4RBOtZrsH7cDgEBQGcEXNCGpo9hbJ8RBf+
7iQEUmf1V1WQBj2ScSkwqwkIW8NnhQ==
=Sj+p
-----END PGP SIGNATURE-----

--Sig_/R05i2mNEGINKxz7p1lx0qkT--
