Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59BFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6353D2192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ou7nf/Fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfBQN5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:57:21 -0500
Received: from ozlabs.org ([203.11.71.1]:51707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfBQN5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:57:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442T8G2zHtz9s7h;
        Mon, 18 Feb 2019 00:57:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550411838;
        bh=WySIdWx0AzTVFxRLLf58Wd5usWZKcPPgG6KnP9aq8Fw=;
        h=Date:From:To:Cc:Subject:From;
        b=ou7nf/Fw3XEII8D7mq8GFoPL3CqTpgk6DlAQMcdDJfNXNuXztJbx/IbM9dk3Bh0TJ
         FF+bGC4/YEChNCQ58NK4LZtc+UNnTiabr+iA4rGH42nAQoHIRg2hYafgn1FxRNMQGc
         XoZUMnvs46PrBOepJuBgj6IsJjZD7pk1Ny79iwJK7jwjWQh58+EpNdQbxoS7uC/UIi
         cwsI5LEtE4oZOmazGZj1YFyOXYBjRf4+k5PrQr9tpSGPNnBOD+vtdvYgoMcq48FYIT
         tG9nBJKjnAnw4EwH2zXJK59cJu33qy77vtUG/i46bgKzI8h7jbER5dvotRFKcYmqhw
         90odf1WMfe6Zg==
Date:   Mon, 18 Feb 2019 00:57:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the xen-tip tree
Message-ID: <20190218005717.175ba89f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u2uu1OvJX=AMbFcvWehUyAo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u2uu1OvJX=AMbFcvWehUyAo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  28df69acbd27 ("xen-scsiback: mark expected switch fall-through")
  7bb17e0ca4a5 ("xen: mark expected switch fall-through")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/u2uu1OvJX=AMbFcvWehUyAo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxpaD0ACgkQAVBC80lX
0GyUPgf/V4oAVkGq1tLAQdyUT/BLYb3Bcv16Qh/NzBL/Z4STDCZeNTOdXedRqhb1
IB0/QEW9jSPrLAZQ64cIGXD1nd6c6A2AT1mbuMUVVTSq8fqfiuLZWfBVUb/cyN0D
eqw150jMr86KJhjY//TtY4uuch3BAU82gZvnXS4O4OrLV4uZgU04z7QV+QAwtCgk
XEg2DQCn/gHXkGLkNTr665BQKWSRzVJ/VEvBMPD4eabxxR6nVUs8qtcqt6B6TXr5
5l6zbMQWfUznVMTm2Ro1n5pvdBH2uVp1GUpvf/jCqLAuE/F+kk63p9Z+0yPRQqLx
JlmEMOiubYLRF0GRZnihVPrOXx8dOA==
=2EOl
-----END PGP SIGNATURE-----

--Sig_/u2uu1OvJX=AMbFcvWehUyAo--
