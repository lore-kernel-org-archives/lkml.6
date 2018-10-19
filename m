Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF466ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B337620645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fF3T4eE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B337620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJSPfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:35:30 -0400
Received: from ozlabs.org ([203.11.71.1]:37679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSPf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:35:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42byHv5f3bz9sCf;
        Fri, 19 Oct 2018 18:30:34 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539934235;
        bh=iAQsVVMt05FB27yaSq+5xYlkhJyUsS4O2xI4LNEh4ZE=;
        h=Date:From:To:Cc:Subject:From;
        b=fF3T4eE3umCOlYhf/MVasiSPFavHY84gv+HaTRnP6/ykivfQL4XUuMb983SS/8mSu
         8W1KJB77PTW79RCe0ppkSSMZ2YxeKd9o4+GpBB1q7R6Fx2wqrMrbez/zLd3EM2a4Pa
         Aq98LOPP2rqPJ1/90T/oODSGsCHQ30ufcDRmssJHPMEE3mwUPsgDlPynKtQweesNG6
         QroKtzzJk5mXxItX8JBg3D64kcBu67tK5K4/qDn+X19LacIxdfS80aragJqgcCS5dm
         Jf9Dc6YPeSMSiJqg+TUEL9kKL5+vvvJhVft7KMnEFjJQaiHdpuHQXkqh8ojO9uLLP/
         AFOo2eMEOsUmw==
Date:   Fri, 19 Oct 2018 18:30:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: Signed-off-by missing for commits in the net-next tree
Message-ID: <20181019183033.4fc5b93b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eNdFC5miAgY4ao7/5OsbdG0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eNdFC5miAgY4ao7/5OsbdG0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  2a4c42980250 ("net/mlx5: Remove counter from idr after removing it from l=
ist")
  fd3307130344 ("net/mlx5: Take fs_counters dellist before addlist")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/eNdFC5miAgY4ao7/5OsbdG0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvJiBkACgkQAVBC80lX
0GxrGgf+KxxtNI1r0JqcSV79x+dGvOfLzyuFyRLHb1ebY6EZo+idarlc4Py60TAa
LQQRlJQGCc5MeLCVWUfuegtpG56O/sWsnXnk8297rP1t7unyhnxAWs7wIzu1w8Oa
rHmlU6+2WgEVBZ6Uthv3SzSs9h+htbQGBSL8QbmmcmD2pKp3IJ9C5NR7mDNk/SIt
Ehgfb1Iv875qGrDNGPZjOx9uLf+7axmDIam+4ll3/FhKHvMiptwTProCQBxkV3rD
1T7odgvH+x82u2PFKrZpgN3dtx+UhUQvTOhTOP47aWwaVGdh1r0nsDCZI3sV/733
rNmVrSrKLm3Sk7Nisq62X6sw0KN28Q==
=JgKI
-----END PGP SIGNATURE-----

--Sig_/eNdFC5miAgY4ao7/5OsbdG0--
