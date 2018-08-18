Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC76C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9772178A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DgorOcUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9772178A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeHRRic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:38:32 -0400
Received: from ozlabs.org ([203.11.71.1]:34315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbeHRRic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:38:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41t2Y804Nhz9s5c;
        Sun, 19 Aug 2018 00:30:34 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534602636;
        bh=+sMZWhnVtjCuxcISEp0BIcgOicOCOjd0JgmafbB3H/s=;
        h=Date:From:To:Cc:Subject:From;
        b=DgorOcUVXwSnA8Dq2F2oLXQu5A0POBSupu+0IPXFdRNnjAo4SEPrwUotfC35vuGyR
         +/DDNTb9rIjJNfCZdSn9dylFTMCe6vay97fD/BKVkNHj6akDSSMcW/70I3YKwIjEGs
         UtgiR8kSBB62X84QemDUVUGi80Rag6gJcT4XgCi7WdAMB9NhoaQy2wKrEBt9VebJUO
         sli+sQZpbCszdotJvPWOPx9LGi5Zx6jqe8i7hPrtjs94YzKgpcdeNbTcm6TLtM6sXM
         TMIDk8XK1oRjDeaD0RsXTcDm7aJlOKCEzh1C97xiLK5ehqIvdPfF1IpiF7NOevHqN4
         OrC0FGPXe8gsQ==
Date:   Sun, 19 Aug 2018 00:30:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the h8300 tree
Message-ID: <20180819003005.4a5792e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rk1Bc1SDX+YPW=XGOYqR1jW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rk1Bc1SDX+YPW=XGOYqR1jW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yoshinori,

Commits

  785b0958b55d ("h8300: gcc-8.1 fix")
  8eabc2d5fae0 ("h8300: Add missing output register.")

are missing a Signed-off-by from their authors and committers.

Commit

  85f866b60ba7 ("h8300: switch to NO_BOOTMEM")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/rk1Bc1SDX+YPW=XGOYqR1jW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt4LW0ACgkQAVBC80lX
0GyDeQf/ZHq+ob4etjtxdNERwIPDBMXFZ0I8isS+yHZThmdjD4d9Cg16rwfQFtKf
BTsH2uQ92Dvr1stoNpCupwwqgLvkuqoeLgvmPGTf+nocgbz6Dkmkyt6fIH8jYJlI
ZhVtwc3cZdMNaaO+ic77VaD/pqsNTb1ZoRC1lMdRphFbc4azj8DGsAvaxvhpSuUc
GYVcR4JqOyqooei2dyAFP1g0jOMMhKP857yApZIJHwCSvWR+IINQRtk3nwBFGpK7
2VTOiG7tlGlmYf59XcDeRTriUgG/J7n7FBlGV38Jlfw1MprFeel9aI2WRrmgRYa5
AqsRpZPPQHLx6pvfDg0XyXEjLA9UQQ==
=UTrm
-----END PGP SIGNATURE-----

--Sig_/rk1Bc1SDX+YPW=XGOYqR1jW--
