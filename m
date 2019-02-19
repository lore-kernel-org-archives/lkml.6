Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245CC21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ksuAw01F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfBSUnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:43:41 -0500
Received: from ozlabs.org ([203.11.71.1]:39761 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfBSUnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:43:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443t4B5P8Dz9s21;
        Wed, 20 Feb 2019 07:43:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550609018;
        bh=ztG9tfojxqBUQH1btwe7E/LjgJ6hYF8gD0EQpnVzmJQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ksuAw01FRPN1iAOwKA7c9YYFozonMPwG723YMDw2SurQ6HXMQCSsUIJ4RNveak9Jr
         6VwcMQwTsvapKUMGmoG0Eiu93zt4zIpKXDNy+F1SCO4lxY8I7It3xj6dIH7GeBEagV
         F+61lmXn3E0sRj+KIgZBBqzPNl+yomcB4HTi3+SlOwbyFC5psx4rLY4g2WO9mjcGfb
         oeaeGPSdv7sGSGds77sQGNaHa84zPW2Q061mindhcba18maa4sYNieCxWdBnBcR2Ak
         9Yt2xvkRxYAv+UlhTmCOBETZ/It7nBlvcP0/4AvTo+Y/pJmsF99K4SDxYK7exYyXjg
         nRvXdZ6SMg5cg==
Date:   Wed, 20 Feb 2019 07:43:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: linux-next: Fixes tags need some work in the staging tree
Message-ID: <20190220074336.4c09597a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sq4h2.LWyEFRXrGPYfoNY=Q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sq4h2.LWyEFRXrGPYfoNY=Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

In commit

  8b20408a5662 ("staging: mt7621-pci: reverse condition to check for enable=
d port")

Fixes tag

  Fixes: 802a2f7b2fe3: staging: mt7621-pci: factor out 'mt7621_pcie_enable_=
port' function

has these problem(s):

  - colon after the SHA1 is unexpected
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

In commit

  766becee70f6 ("staging: mt7621-pci-phy: use 'module_init' instead of 'arc=
h_initcall'")

Fixes tag

  Fixes: 00981d31d6df: staging: mt7621-pci-phy: add new driver for phy part=
 of mt7621-pci

has these problem(s):

  - colon after the SHA1 is unexpected
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

In commit

  ca87a3bf731d ("staging: mt7621-dts: fix pci phy register addresses")

Fixes tag

  Fixes: 06184ba5a33a: staging: mt7621-dts: add pci-phy related bindings to=
 board's device tree

has these problem(s):

  - colon after the SHA1 is unexpected
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

--=20
Cheers,
Stephen Rothwell

--Sig_/sq4h2.LWyEFRXrGPYfoNY=Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsangACgkQAVBC80lX
0GxqHwf8DsHGbYxV/To9Jx89GXeRKT8DOlQ+FUfWVtbIffCckYAPT+qhCda0u0Rs
TJ68goPq6mNhuRbwHpOBy5eeixnCFASdW6rrUi7EpH4YB9EfgWA7fOHKYJDHDF0N
sVzQ+kFFGyO8PUGAfy7zM7dY53D8i/UMih4MYuTpbUop00jdaiOa33bWXHKywZGF
8uHB0qCVvGLWDWc9lBcZQldi5zocK1yhBd1oXSDeWsVxkD44+zURHVhFdL0MRY/D
zn9ZTVcJ+KKGqiomUZjUICIzPWTpuoFl+2OzR7B7y8V3mapl10Sxlrvcx3DdznLl
/VJtD6TJxszcDP5s72y4TlqikwVO9A==
=viJr
-----END PGP SIGNATURE-----

--Sig_/sq4h2.LWyEFRXrGPYfoNY=Q--
