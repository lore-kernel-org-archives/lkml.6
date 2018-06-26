Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B211AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B06F2250F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F/7gYpbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B06F2250F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933776AbeFZXEM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:04:12 -0400
Received: from ozlabs.org ([203.11.71.1]:55705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933304AbeFZXEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:04:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41FhS93Tjsz9rx7;
        Wed, 27 Jun 2018 09:04:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530054249;
        bh=T6OxSPbFrs+5Ub1AaLsyMI1uKMdQ2Vhmh0fmjJPOHh4=;
        h=Date:From:To:Cc:Subject:From;
        b=F/7gYpbcc5upQaHyucJFLI4QKXfTx9WuaLa/P5uVX3VIikrXuCk6XWwgpqsdBFRN/
         dYJp7k7MV2mQgOZooIxqgzrCUrZRE8DXyY8WvvbhGfKHwaggk4d4SS42IrMm2dA4+I
         agIjTg/7fYDXFFUdCNXTDjC7gZoxUa5FlD1cOjUemW5JRJJCgVrSPzrIpXSg/sczCL
         sDjAEVXmvdHBznZNqc9VN6ZUjDmIWAYm+JphxbZR69AXIbDWPYF5xcjiI7jf3kL37m
         8BRcSAD9mtwfPaoz561Mm58L8L5YkhrohhssM8Si/8RsiQNsBsXMbtXStvoCKF5xOP
         El/nuwBYnqnVw==
Date:   Wed, 27 Jun 2018 09:04:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the rcu tree
Message-ID: <20180627090409.60641869@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0_d1Jbnafi+6jW+m70z/BRu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0_d1Jbnafi+6jW+m70z/BRu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Commit

  aa838e0b70e1 ("MAINTAINERS: Add Daniel Lustig as an LKMM reviewer")

is missing a Signed-off-by from its committer.

Please sort out the "Not-Yet-Signed-off-by: tags on commit

  0cd34e83b2a5 ("rcu: Make expedited GPs handle CPU 0 being offline")

Please remember that the linux-next tree is not a development tree,
it is an integration testing tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/0_d1Jbnafi+6jW+m70z/BRu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsyxmkACgkQAVBC80lX
0GzLmQf/Tl4wGWJlwn5GyvF1FBaSt5DvMyhTDWK064y0wA1ZdBEz2lXoAl3NQuYf
QYdGJg1Y7kWZ0CCyQfbh9NSrGcQhWmOB2uBBoLWqfplvf9rphaFr0D5r0OlJUx+a
4F2C3lN26WV1aj+V6jHyWzW3oDJBbN+M/QTINAK5MPNpnHibhNxDE78Xkc5QeJwj
Lf8mpB+0vR2ZsQxPmblOGUpGgZt1L95ANucpRxhpULrCMWama9uCn5n8S+qtXTCC
Egbqn58GO7Bzd1WbmWwMXFnzLq1TAmMqyGgNqBmD+LBgBuaeFKc4qsL4QljdbJvt
+U8rglEJhO1UCZyueLi3LhZ4MxEszA==
=KZzI
-----END PGP SIGNATURE-----

--Sig_/0_d1Jbnafi+6jW+m70z/BRu--
