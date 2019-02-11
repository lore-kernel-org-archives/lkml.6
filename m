Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E7B217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PbO6yIqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfBKXK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:10:59 -0500
Received: from ozlabs.org ([203.11.71.1]:48645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfBKXK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:10:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43z1jr4c6hz9s3l;
        Tue, 12 Feb 2019 10:10:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549926656;
        bh=sSgYpe6D/3wJMXzgEPROyBDCFKTV5XaPYl1oU9d8/hc=;
        h=Date:From:To:Cc:Subject:From;
        b=PbO6yIqzjDp/r5g8z3RBYrC/sGakjIQLPzRzK5xbCraZqnf7K2bpkO1wuQVcVgc+v
         Pfhqi1ksNqGvsoOE4eWshaYL+XchmL9RgOhIaabZ9BAbPfcoKVYkRlHfh8aZpqTqyS
         fBEgwRPZZNnVxD6HmxbaRIwddYnmr8ngqB5Z3sXkn7j90yfGMYY/pTWKKuyybS2i3X
         lyVeGkTwSlUyXPK2gyKpu0szy56S7gYdlCmpwViOV7qsX+t6Z9aPtTKAkmHNvZEFG+
         LeWZDP0m5XlDd2UcLzchMe5VTFSMnHxxwLxgJo4ewK4Vygs26NCgkJpiJn2eCQ9ztc
         8axnF/onTUObA==
Date:   Tue, 12 Feb 2019 10:10:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20190212101055.36a8b74b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PaH8zGiG.p1hbhoE8jha7qn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PaH8zGiG.p1hbhoE8jha7qn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Commit

  51c80555dea3 ("PCI/ASPM: Use LTR if already enabled by platform")

is missing a Signed-off-by from its author and commiter.

--=20
Cheers,
Stephen Rothwell

--Sig_/PaH8zGiG.p1hbhoE8jha7qn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxiAP8ACgkQAVBC80lX
0Gy9Kwf/SwJTnpiW+KlsVjEuHE/Qt2nR/vAu4mgFArMfsM2hLTNLADcHK1ex+7lm
gwx8kJh74FSwEkvLovCfg44loq7+jSLzZUPtrivi3+cylbUEeAY9jUYhW9MssQM/
pRuBOOOuvSlB9JfbcLZ9kKlpjKLYLd4+w6J5bnUcqp9jbAIw2MA3CoEa8vQwZ6Gs
yYCT92Mfl5tjsjtKUikUJZ9qMtbwgfRy0rEDgqwor3KlpCzqLOlRFJ1Id3+utMCb
sfJRqg7mYDJ+bLQxBs4yu333YC1MxD4PGO1B1VtL2d/xVSerzL0NzJq2s9qGzrS5
Lr5QX/hT9KwG62nCbHrdOXHJzddhxg==
=O0kv
-----END PGP SIGNATURE-----

--Sig_/PaH8zGiG.p1hbhoE8jha7qn--
