Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA97BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF6C21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZkZzQ66C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfAWUnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:43:32 -0500
Received: from ozlabs.org ([203.11.71.1]:56785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfAWUnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:43:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lHLT6P35z9s55;
        Thu, 24 Jan 2019 07:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548276210;
        bh=W++zRMEewXyhP4Y2wG46Lq03dVxetorEJw3bweGGF1o=;
        h=Date:From:To:Cc:Subject:From;
        b=ZkZzQ66C7scUEKC0Qe8VTwD8JGPeb28o29GzV2sYnsFLtzec6+URaf7XcMMR2kyxI
         P1gDj2PwUYUmdUCVEG6fzLCdR0G3rPuS0Lp6/zl7NAh9RsOMKaZwvMfwempZGj8mXG
         5+4sPL1wZ1RyJhnjMa1sE4ithAOh4u87R+wlswhrW6mDfHlf3sKBhCwJwPYEVIQdIw
         4Wl1oTrs2DO+koXj3XIuHfByJUUcPMZBn84RRMtgt2+7T+stm46D1puvzM9tWl3ySl
         K4Vg6O/NnLLeMcdA1UBsJ8FA18UH8VB4+72KaXLeyr4Rt2xVuncTPERuGu3Jw7cRnM
         mYlzBFnV6bPaw==
Date:   Thu, 24 Jan 2019 07:43:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the
 dma-mapping-fixes tree
Message-ID: <20190124074316.5730569d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/62VH0y98=ihLOpL7220dIxi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/62VH0y98=ihLOpL7220dIxi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

Commit

  e31614683919 ("Revert "arm64/xen: fix xen-swiotlb cache flushing"")

is missing a Signed-off-by from its author and committer.

Reverts are commits too.  Also, it can be useful to have an explanation
for the revert in the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/62VH0y98=ihLOpL7220dIxi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxI0eQACgkQAVBC80lX
0GyHiQf6Akao8O5G5WAs2YgmwIrq8ib7um/hVLImOFmOWN0KBsrLErIpiaB9/Fgw
KNBzRHaikidB/pSb4xIwtmuZSx7j0YX+4Aofb8LFjhrCFRerYVSN3kY5/w9m9/cE
32MosBsMWENc1MiTHn6wWOPzbrZJVf7CeVF6tiiNC+UgBA6qcGG7dcMCz28E9e0y
X0xzxxigH1n9O1LuzljZRknedbxRlw7k4X4S8/aN6mZ0uzaw+XkCPow9NGXzlaDv
Grt4jX+ScViszIHKNIdidVNedjQath1haAp4dYc/M6Y4VKcPFh9oeNyiT18TVEkw
WeY3Aahx8FufWYkqwMDOA47Mpbz+qg==
=csny
-----END PGP SIGNATURE-----

--Sig_/62VH0y98=ihLOpL7220dIxi--
