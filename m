Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB958C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E8B21783
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m1P57+PB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbeLWWHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:07:54 -0500
Received: from ozlabs.org ([203.11.71.1]:46367 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbeLWWHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 17:07:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43NGh73Hdnz9sDL;
        Mon, 24 Dec 2018 09:07:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545602871;
        bh=QJUEeiIKArb+P13KqA+E8pJx0BYjl6zDiOMDMHaXCQ8=;
        h=Date:From:To:Cc:Subject:From;
        b=m1P57+PB4Rr1TfkVuaFPYZp9GKtC6bkLlPPGac97e8gjmhsLtHze2ynphLKqRMlXO
         FmnWFitE6i+u3LjPDXs2MauMHMXnaD8qd2aiqmdTUKJetNpVrTXr6dCl7KkVwOi9mJ
         8yPCXNz3zHnn+6QloGtJSOA2Pu92iTAAEvBqpMNvUIMyc1ONKjh6QMx+s5nXp2Tgpa
         whTCm2PHKd5IxhiU9mkdFQgryicwrH/KbKFRfDKhC2VhPnhHb1EDEFY8UqzfRlOrCs
         N1cekzw6AZBctPXFh10F1/7mi7fyu6JeIjxnxcjbQ7tlU67KBBG8IBIQ2bE+c9jxra
         qM//DRUaPSONw==
Date:   Mon, 24 Dec 2018 09:07:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Hogan <james.hogan@mips.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <paul.burton@mips.com>
Subject: linux-next: manual merge of the mips-fixes tree with Linus' tree
Message-ID: <20181224090740.3ebbd60c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cFf+xLaLYBCxJ0+6abZ/vV2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cFf+xLaLYBCxJ0+6abZ/vV2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips-fixes tree got a conflict in:

  MAINTAINERS

between commit:

  6584297b78b6 ("MAINTAINERS: Update linux-mips mailing list address")

from Linus' tree and commit:

  9bd2f7eeaed1 ("MAINTAINERS: Add a maintainer for MSCC MIPS SoCs")

from the mips-fixes tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index f3a5c97e3419,50223cba6ddb..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9912,8 -9801,9 +9912,9 @@@ F:	drivers/dma/at_xdmac.
 =20
  MICROSEMI MIPS SOCS
  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+ M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 -L:	linux-mips@linux-mips.org
 +L:	linux-mips@vger.kernel.org
- S:	Maintained
+ S:	Supported
  F:	arch/mips/generic/board-ocelot.c
  F:	arch/mips/configs/generic/board-ocelot.config
  F:	arch/mips/boot/dts/mscc/

--Sig_/cFf+xLaLYBCxJ0+6abZ/vV2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwgBywACgkQAVBC80lX
0GxcwAgAo7vAWiTV6bk+HOEnnCids7Jn3AYPYUXwI0Z6WbDqYRuiYUCmpPoccLnr
Us5z/0GiWjna63TjjXL9EYxFLqKYh+GV7eFgT0VMnw7YjuBbRMUe4JjCln2ioHCB
eTeDiYEkS6NVdpEI1a9wuEBFI19JAnfQyKWUXPIBqtLcxrmk6CR8nY+AJx80Iam0
IvtgZrV/1ekpiWQlchYmwAKc6FNzV/ae8uXk3VEGSXmw/VugaQYXPHBB9QrNYe/4
1mpGfUOJTMxtZ6Vt9xBNEIm24kcAxKF8Go3/xOQBf3t6vMyW0EQmDJNkH0gEDE7O
FJoAxYGOhj6e+OiVXsoXO7DUidnHtQ==
=e5KX
-----END PGP SIGNATURE-----

--Sig_/cFf+xLaLYBCxJ0+6abZ/vV2--
