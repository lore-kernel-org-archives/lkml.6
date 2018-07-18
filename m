Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A45B2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qHIhOOx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A45B2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbeGRW3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:29:32 -0400
Received: from ozlabs.org ([203.11.71.1]:50409 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbeGRW3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:29:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41W9m31pb0z9s3x;
        Thu, 19 Jul 2018 07:49:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531950579;
        bh=6bXLUxMXe12lyBJYj1QA6sml4TxmrJbnLtbyFXyMUtI=;
        h=Date:From:To:Cc:Subject:From;
        b=qHIhOOx7K5UGRJSLlvvTpMDIH3MIy6Yb1gpMQWmHQd4TAxj0pW7thb2CtAtYETaQr
         K1MxoM6PN6QlOZZnNp2ijO97etbkYM7a9CVYFp89oA3j65MO39m+kTkzG0V8fHUecV
         tw9fb6SHpPdumVbG76Exj+1wMhgSdRThS3X5NzbZFFG0MwIgypXZqbennYCyeldJUd
         4xEfzf+J4l4+ZIEdvUghzJea3MWjUNOP8xzdB6r3pBbqh1XAgIcuS1fuqWGCuTWDr5
         vo8p5FP2oKwXH0o/X1HuA8Lvv2pZ2b3yy/d+ATx3D9a7zGRqyu/mgIaSNheFkT0s33
         LkvGiTy8xvm8w==
Date:   Thu, 19 Jul 2018 07:49:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the pci-current
 tree
Message-ID: <20180719074927.68da9f86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tSLlOVFVYn92hsN+RC/E2ss"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tSLlOVFVYn92hsN+RC/E2ss
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Commits

  27a6c9ebf29b ("PCI: v3-semi: Fix I/O space page leak")
  db2aff16ea70 ("PCI: mediatek: Fix I/O space page leak")
  52022fc6f6ad ("PCI: faraday: Fix I/O space page leak")
  a9c0419ec92f ("PCI: aardvark: Fix I/O space page leak")
  45cb32b4e8ea ("PCI: designware: Fix I/O space page leak")
  89c0f3551827 ("PCI: versatile: Fix I/O space page leak")
  596c66bf9663 ("PCI: xgene: Fix I/O space page leak")
  ede26a1e8c35 ("PCI: OF: Fix I/O space page leak")

are missing a Signed-off-by from their committer.  Presumably they were
all rebased?

--=20
Cheers,
Stephen Rothwell

--Sig_/tSLlOVFVYn92hsN+RC/E2ss
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltPtecACgkQAVBC80lX
0GwBnwf+OfA4zira55AIYB4RC8QBQauc6YJ81nG3n4qMFBo6SjLi8hiLz/1RcKqv
g+GCu5a7EM8LI3QSyL8MMR1nHt7ukDqgO2svFIwG3R6+Vej9sDVf4A4RBFXIf8NN
rMJQl5CmiDsq28PmAIlaXPuH6S4G+1ol2bmnHy4b6qwTZZkHS61o5a83/TZvoJAU
4pzY4m1wigXWGz1MBVgagRGT4+NSPa9PRM03Fd+OOxw6H6hAUG9tlkPbDAjTUiHa
XJDji5QX4x5O0NSXpYvaC+wbQG6+JQuzvxiFhDGhUTJi5YH+u4rBLG8zgjCkcBmE
wHwaMv+rMW9gYQb47Joryt90jgr+aA==
=NYbC
-----END PGP SIGNATURE-----

--Sig_/tSLlOVFVYn92hsN+RC/E2ss--
