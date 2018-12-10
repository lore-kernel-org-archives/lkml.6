Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B373C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193BF20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="th/LLdUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193BF20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLJJdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:33:49 -0500
Received: from ozlabs.org ([203.11.71.1]:55561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeLJJds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:33:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CyZ21GHgz9s2P;
        Mon, 10 Dec 2018 20:33:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544434426;
        bh=MQFv+SRVj0l/e6ltDmC3CgLJusmFHsAIZX4WU0egORA=;
        h=Date:From:To:Cc:Subject:From;
        b=th/LLdUL25ry3WWkyLH0MvhrPEIvjyGA9lz7vusuYHGZ2QNZfzf3jLBPc4HHYIT52
         43XkJtGv1MPIkEwFdbpwrv4p/Kgcbi8uniN7JplkaRGIWW3Ww7/o0Hg2tXlt+z2k8Z
         7Nhdv8CpRoRJG0dIG6R1CUkfAoIhrNrvT1Cr46brhaN7QBszt3ulLT3flVPjZwl5yC
         i5/owc4nI/jBBAMGo0MkGWfg1p0sViM8xOnxybAka2xQq982KKAVeuoVB6KbqR4BoF
         DO+xpn5nlcCKI8Jl0V195NAm6//7D3flWVxQPOYXLORjkwfBZTuXZcGhsVE8umeWKo
         HdHbAkGInZWyA==
Date:   Mon, 10 Dec 2018 20:33:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the phy-next tree
Message-ID: <20181210203344.3b3b8ee4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/biFYhWK3yGMLsXxlpH/ziPt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/biFYhWK3yGMLsXxlpH/ziPt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  42632988767e ("phy: ti: fix semicolon.cocci warnings")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/biFYhWK3yGMLsXxlpH/ziPt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwOMvgACgkQAVBC80lX
0GzFYQgAkM0fz3/uqy2WcPEgXWPQNef0NOhm8EiDbUZNrvCl0vv6yZgpC55Qy74V
fItha5bvKfZQiUYJi9XqYUzfnebZjkF7Izlte2hamfmDuoCwKG7xvTnHaKD4ri+U
lcf2Dr7wZI5DUMEaZUh3Jy1B3jdec9OU1WKs4tEppywgGFWCjx2EXOmJzY03R3pI
Alp1MJmomO06PR3uAorapTQl88PFO9VzM/6qwf+rJvUuwL/B2O5+Pga6RJyoZ3+e
NmGGALBT8SE0hVHmhGjcz+IwhKU92+IO40NubkXYHnhMo5yT6FHUUIWbw7R9y/YO
+3mDlwDIuJTOL/iESUFgOy9e0gVD7A==
=k/ly
-----END PGP SIGNATURE-----

--Sig_/biFYhWK3yGMLsXxlpH/ziPt--
