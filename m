Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC592C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C00A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l6vicCDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C00A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeILAfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:35:40 -0400
Received: from ozlabs.org ([203.11.71.1]:36491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeILAfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:35:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 428w982JnBz9s9h;
        Wed, 12 Sep 2018 05:34:52 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536694492;
        bh=3+GH6PEf7fTk/60ZwQhHpqfjVVke34uemddi07WgGIk=;
        h=Date:From:To:Cc:Subject:From;
        b=l6vicCDcRBQi0QN3itfQRADh70k9yGa6n1VW2bCidGWVvTTlB206Mi1hLf1WuV3Qf
         EvJuFlQVa9UXMtglRShsCsjjxzRL+tIu1TvahMTfkGAlP6KoAS8a68hiJunuUrOQe8
         FCuLlNn4YIlqFPKxf6yJ0fHoGOsXVpj7SCOJpV6+wOR2aJ2O6PqQy8Z65eOY0PbIC8
         eS7aG+POYTIGk3hAAIL1QHttPeaCLJ5d8shPIy17tsTLpA1M0qC9tML/qHLDxki+CY
         UpV/hoQmqgWl0z/sb9nOGkPVbIAJxhgaG0+rH+DGdbe3pXmCV9LCEFIS3scfKBxxns
         KN3xOn521voLw==
Date:   Wed, 12 Sep 2018 05:34:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb tree
Message-ID: <20180912053451.0d937c38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Y9m_PcRO0DOxR=OJNDB63sK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y9m_PcRO0DOxR=OJNDB63sK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Commit

  422e91cc48f8 ("media: i2c: mt9v111: Fix v4l2-ctrl error handling")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Y9m_PcRO0DOxR=OJNDB63sK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluYGNsACgkQAVBC80lX
0GzJIgf/UhEhW68HrTGhsF/X4lOQlzYeJUdf4Z1iynmSqbRR/q+/1sOgCtZ9UhGa
cQ2Q512+iFl1OvgZKOwqJt5t6Aifh/hJIZJzZch3nZcZWdXKxeH8MUaGocU4Xo/x
EARIdZ0CKdTSasf8xWIfQfNcSoJwM6x63fX2J02L/QPVNvS2AFNmu5a14SThrxnb
AcXlktAcWdrvoRcPGXrue37GWdvbvuDijfLk8hIHddJMf6VS0vueMqU3qW0fWrHs
XZsQczHAGLHFpTk5yx3J0mPV9NSNvsUka+RxlOZHwtaWo8OYfVGAxR/LCqpEu7ey
x9Joo7t0j7Pv47s6mWN8RsblFvRJCQ==
=m/St
-----END PGP SIGNATURE-----

--Sig_/Y9m_PcRO0DOxR=OJNDB63sK--
