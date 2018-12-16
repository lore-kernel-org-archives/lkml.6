Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426F0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 06:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072A02084D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 06:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BT18D4vL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeLPG0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 01:26:54 -0500
Received: from ozlabs.org ([203.11.71.1]:36899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeLPG0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 01:26:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43HZ7b6lN6z9s3C;
        Sun, 16 Dec 2018 17:26:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544941612;
        bh=3mVe5a563lxLZ1GClzBJYv5Asj0vtpKvPLiYENykMM8=;
        h=Date:From:To:Cc:Subject:From;
        b=BT18D4vLVa4Zo0kQJdVDpksdluRkfo84n4wiiiKmaSA8gHBTPASyuMz+8vvQJUVUX
         YuOkS/OIfaYmxpe5ih1Xf5k2MAX6iZPnhnIQwcR9XezDUfTyY1SQDbNZa9kfmMGM3B
         FyaG5MJPmH+qhSw/gFb4kid+X5VuoCsQ2wlIlPlLrbqfUVguxVcsx04XfMOAuBRc62
         JAkbpbpUTCQpLe2HUtdb9OmVFMNn1eJwcquTH4iXlBewDd/o5vkXOqozX8L0TUMHW7
         rByvh26s0niWzSMqeVc/cDgdlkq1cAwMRMbNOAfFRb3oJAGRun8qVVy6kFoJqkkobo
         iqP6quaDJnnkQ==
Date:   Sun, 16 Dec 2018 17:26:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: Signed-off-by missing for commit in the block tree
Message-ID: <20181216172649.5278d8e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d_JbmqEiXaUv=thd_Di6wtA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d_JbmqEiXaUv=thd_Di6wtA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Commit

  6f7ceaa0559b ("block: remove the bioset_integrity_free export")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/d_JbmqEiXaUv=thd_Di6wtA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwV8CkACgkQAVBC80lX
0GyKxggAiRYpVOBum6DDinY/2pUJU7nNXrEF5OkiuSaB13ZAu41J6cTfPc2u4/xY
wSmHWnuLvRr/TP/HkWrPho1e4FZNnBwdKrkG7J+/pS9XWdj2XJeb4RTmmFtEyaXH
oRoqpa2xWwrrn8EVLxh9//F2PQ7CbeRXtoDGcu75HCIImMMnvjHiyNM9cJvrnR0U
6GxVmVGcE/ccqqU/d/bdSbBt//NyM7Cc9uQKMFBUfb3+lhGdkyq0PaPRyhkk/XPy
UCIsyI5WOQe2P90el+0g+B2cpWXkprM5G97SpapMneYDqLcTES1fKB+RuDUPgMUD
di/NHEJphgrkd0n0HgwOjg5FsSgJfA==
=JcOC
-----END PGP SIGNATURE-----

--Sig_/d_JbmqEiXaUv=thd_Di6wtA--
