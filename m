Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB2BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C4321726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Paq2L0tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfAVUrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:47:55 -0500
Received: from ozlabs.org ([203.11.71.1]:55909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVUrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:47:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43kgV04Nrcz9s4s;
        Wed, 23 Jan 2019 07:47:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548190072;
        bh=Kn5lsq84lgWNb5Dfv5pMIpjf4kDq19AEQqanRVegXKc=;
        h=Date:From:To:Cc:Subject:From;
        b=Paq2L0tw7ekbpY9EV/oOca+M1cpby8C83D0NMceCgJrTU1I/+r0pvJjtRBKCDPSTn
         ZKZ73Fxcs6pXEeAJ9o09XVQI2lbAp3jMg+dIBz5VtGssJ+4IaG79uuoJNXVggsOoBe
         8Fie0uNV8R2W44dUUcYXsFMKTNR8z1s5JIbilRvprwuIv/bBoO/pd4ZA6gLEdjV7pp
         JyvQoShLykhWE05Nz28673DKby2VDO26MvedJ6ei3bzK3H2H8N4nggK8v6hf8Bpcbc
         3pSkIHPXHJ0YtTsJTOdOxJc25Nrw8RoBUZgcalwpcYU0pqb4eleIAtvDSyouyFcIFF
         FqTTiTKnehV7Q==
Date:   Wed, 23 Jan 2019 07:47:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: linux-next: Fixes tags need some work in the dma-mapping-fixes tree
Message-ID: <20190123074747.7cd44f12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CK4k=jgeOHMH5thyPPH/3Aq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CK4k=jgeOHMH5thyPPH/3Aq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

In commit

  702e8ed37bed ("arm64/xen: fix xen-swiotlb cache flushing")

Fixes tag

  Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  8218a55b6b91 ("sbitmap: Protect swap_lock from hardirq")

Fixes tag

  Fixes: ab53dcfb3e7b ("sbitmap: Protect swap_lock from hardirq")

has these problem(s):

  - Target SHA1 does not exist

This later patch appears to already be in Linus' tree as commit
fe76fc6aaf53 (also with an incorrect Fixes tag :-()
--=20
Cheers,
Stephen Rothwell

--Sig_/CK4k=jgeOHMH5thyPPH/3Aq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxHgXMACgkQAVBC80lX
0GzdVwfzBSAaOs6h6+x8kDJOJjNyrNr+XbSoYpBDSfn+MsNXg05eHk98BCL+J2Nc
EsQb9IatERBPuFXzwFDMbkUjLAGVHJlEDswJoKChkVhAyox+2lvQBavnxio4w7VB
P+LNW/Top5txr82Xgutm0uLB5OfElEi8gUM4E5HL0Til6VqkCUOExQmGB975ZRpA
xyD4WEfVf5K+2MEPe7g3IsZ88ds0U2xVwxfAWur5r8x34cqQ74+dWd78t/d5xtll
SMJ+qyggDCDcWkS72vZhs37D4VM9Dyo1/Zu7Y1eYd8pXPA0unU6E6JIt1cD/hNpW
ZdAWpFg+lN/Vn6RmQPwsfactkl8Y
=90Ai
-----END PGP SIGNATURE-----

--Sig_/CK4k=jgeOHMH5thyPPH/3Aq--
