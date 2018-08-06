Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0282EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC37C21A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oB48XXXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC37C21A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbeHFXk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:40:26 -0400
Received: from ozlabs.org ([203.11.71.1]:34295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732383AbeHFXkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:40:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41krPx4RVdz9s3x;
        Tue,  7 Aug 2018 07:29:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533590965;
        bh=YYL02simCePvnxBpgfT0sMAMyiYEKf9T++GlwaPektM=;
        h=Date:From:To:Cc:Subject:From;
        b=oB48XXXJoVHBJPA0MObklkwqv8XBKK5i0yZV6L93R0apHdmKWe8Ry+/ysemsMupvL
         EV/XHjsr5byElGGCvpIrdRUtNA62LxLqP5Z1mK5HfWGY5e65vPPsOEkq6Tfh1kOjVs
         hQFzgZ0D61sLPoz4+HlxI8xzQ7QySEd2yVNr/PfFAGS3Z7eF/RkaMgzo3g884sSxd2
         5pcOOydfuLxIZzaTbSkN1yxTA24qdUEokdnQdqT0gelDHgck7jl1HUm5R4OgZD4RPw
         XXfV0nVqnmdvI5XOgYHCCaM5RHXllwqK1bPdaXxHFiWWO125F+4Km6lcVjmtf3BG7g
         eWc9k032dGNLw==
Date:   Tue, 7 Aug 2018 07:29:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rockchip tree
Message-ID: <20180807072902.62d6b279@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tQV/fNnu=Mcsis61IyIitaq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tQV/fNnu=Mcsis61IyIitaq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

Commit

  508fc689cfe5 ("clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks i=
n rk3399")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/tQV/fNnu=Mcsis61IyIitaq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltovawACgkQAVBC80lX
0GxXvQgAnn3sfNVdb1ypRybYqoFjl4sQVB0oeTvsyIP4FW1Xg8Yygqh0ekhKskiQ
Cg1ugOljH7DWLBIYJyalcaRnLq+8fhAGW2XtQ5aVXhQn1gzNFJOMCVtpM18uyzkr
zVvoFsybIWHV69KAIi0zqfdHQ9HWkWnNV2tIqQC1MnbTXliFmVlRsv/TKJFUtUFA
FKoBpjY57fD6eixtdSN1goKhRk3vBmBa1BSFaKhkWVvrnMKNhQmucj7DYDyvXe2F
4XDr+n7oVZ6njvb7qkS4lqMEa1G2Z0/2scx4GcDoP7WqztD8Io10yYGDFuFljqYA
IlrNSjZ/8sdWTUKhV645HZu9dEBsdQ==
=NtdB
-----END PGP SIGNATURE-----

--Sig_/tQV/fNnu=Mcsis61IyIitaq--
