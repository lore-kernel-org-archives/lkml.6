Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E63C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1F2208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VwjYaNPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1F2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933412AbeGIVon (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:44:43 -0400
Received: from ozlabs.org ([203.11.71.1]:54157 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933118AbeGIVol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:44:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Pf4R4NX8z9rxs;
        Tue, 10 Jul 2018 07:44:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531172679;
        bh=MK11m41/NXQqpw375hYexBiq4UdBjSHVklWnaAZJjyA=;
        h=Date:From:To:Cc:Subject:From;
        b=VwjYaNPzWCsy6FOiEnWENcUHjvP6Hh5jUtJJrez7IKMefUaBcGuTltijhs2Urtc68
         br2IcMtkKyTqtmGakdk+Y9frvK8wgJFmL2C2sy/M6b3+mHlE0/fILT2qJHgX22i3HY
         CgPj/jgWg1xZnIDcQbKXxMDIzTPx4w/gXkQ+FsYZRLjBrojJgtZ6/UzGWYdstMtVGf
         ryys8VkyPjhXa3UMsU3bvDF+TCVzB+lwPIMXCvayPMqnztYEbhmSZNefuDYdRqErWo
         /u8E8SqC2i2G79ELdYT+TJR/u7XPR3kea29xFwEpbGR/myWOwGljGatrr9qv4B7snK
         P3Fcq0b8tyb9Q==
Date:   Tue, 10 Jul 2018 07:44:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Simon Horman <horms@verge.net.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the renesas tree
Message-ID: <20180710074433.2975b9f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xwXOZUZyDGcTbp2aWrtASX/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xwXOZUZyDGcTbp2aWrtASX/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Commit

  19145e19bb08 ("ARM: shmobile: defconfig: Drop NET_VENDOR_<FOO>=3Dn")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/xwXOZUZyDGcTbp2aWrtASX/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltD10EACgkQAVBC80lX
0GzdhQgAnSwCZ0sw/5ZwG3iett8JMuRwT72of2x9HlV8VuR1E1S43L9Lx2QdLmRx
PR47c13NioRs61kJX+0IJmvNVeeLbLrjoWREqzj+t+uwvUuzBmCiJrqTte5KxA65
a3i6PKjtISt18GhCU8PyTAELos+YbDbs0ngWZsP4zblbWXVnGVhbSSbC2XUBwGui
Zj6t5itS1706zDe/qDlKYVX8iGcR37sIdnpv6kU/D+XJJYxLCRcM/YU0gDbyfDeh
8PRL2wAzBGHwKcOWxW5X6ugvN7jQk9Z631/UukLdsu3w++OywiEK4vgP6vzG3yKg
n6v58Vxw2tCJhgInIltvrfUSUwDruQ==
=wMaH
-----END PGP SIGNATURE-----

--Sig_/xwXOZUZyDGcTbp2aWrtASX/--
