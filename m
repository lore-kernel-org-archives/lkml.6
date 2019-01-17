Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D50C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB5520855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U1AkQei6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfAQUdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:33:14 -0500
Received: from ozlabs.org ([203.11.71.1]:36589 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbfAQUdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:33:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gbPM5zQtz9sCs;
        Fri, 18 Jan 2019 07:33:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547757192;
        bh=19xO1nZkpS4GNISsizOWFq8b2gRKHDOeEi1KejuEK3s=;
        h=Date:From:To:Cc:Subject:From;
        b=U1AkQei6Bv1Pwrp5jSsPEJJZ3d+rSKWwOeNe+QIA744TcnNnd0FvGN6flMAId4Cng
         Ha2IUB1eGydzwoCgLOMgX25pnFUnPnRZxbAmVUNpoPVjJ87TlfDjl9mBXksUPKgNCL
         t4UOJQiPimKv43M4VVCBGp8YZbos49q0slrXijTthL6BpbWZ0xDnwNFf5tYlyNHSVf
         kHJ198veuEJTnyBLVKz2KRcsMzkZ0Me4dJv6gI3C/GCd31RyMgc7jALCQARBohKj5K
         u7PCZQhw+TV1RUNjATees1rlzi3Sxg/I0DdSpTxDMb8C0cGKKUvwBV3kf3TaEfbgM/
         ytQuzT02j2alQ==
Date:   Fri, 18 Jan 2019 07:32:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: linux-next: Fixes tag needs some work in the arc-current tree
Message-ID: <20190118073257.5809b05f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xjKl8K0_nKccmslA0B20++f"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xjKl8K0_nKccmslA0B20++f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

Commit

  8e542d2a28c9 ("ARC: adjust memblock_reserve of kernel memory")

Fixes tag

  Fixes: 9ed68785f7f ("ARC: mm: Decouple RAM base address from kernel link =
addr")

has these problems:

  - SHA1 should be at least 12 digits long

--=20
Cheers,
Stephen Rothwell

--Sig_/xjKl8K0_nKccmslA0B20++f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxA5nkACgkQAVBC80lX
0GzBqQf7BF7q83reSR3NF0E7DTDWke/VQBs+UDjYBGDDf3zjX/cNuEZ8ng9yrnqa
9CiRC/WvO/nwLW6UAATbaXTmOaeCrIeAaJjZXFNoCCPqdvP5coRMk4YTrVS7wjdu
VqIl7FrKEv+Ml9GDoqfnY06IAZUbwX7xVrfuzVUmA1onF7rmImvvHtuh9NaVDi2q
0r19IpW90aqznsc91V9Xu8REZPH/VBjkicdtr72U25x9IIb7p2c+vBTYojRngx9r
98TrgCdV+qOiwzk5OyAb195hkT5UFIoFAK6eCv9KygGqBsUIKl4dlPc09pKvhrsf
2rTDR7gg6JQ1QbqzAUVHpUiFp84xjQ==
=0wuO
-----END PGP SIGNATURE-----

--Sig_/xjKl8K0_nKccmslA0B20++f--
