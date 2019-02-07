Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7176C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F172190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="B0JWQByW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfBGNr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:47:27 -0500
Received: from ozlabs.org ([203.11.71.1]:35737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfBGNrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:47:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wKPQ67Zyz9s6w;
        Fri,  8 Feb 2019 00:47:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549547243;
        bh=9dUE7qdYt85IRChPaaPamNsiL4vYB0lWJRZejvsQJtg=;
        h=Date:From:To:Cc:Subject:From;
        b=B0JWQByW92ktDP82JMR+hJ2zVXOPRFvYRjhoaXPQrSjrSaDbXKyYAzBnXVDawpaw1
         J7MXQEfeHQQi8eLRocUBzCSZl7APfCCi3qgMQDMPfoF4nvUbvbuaCN+pML7JLIH9nu
         gDaQQTHEEigb7Xi01QN1mCj58HN8zwth8u6XrVdfc8jKgoBXlv6835zJ4+XqfBb7Ei
         /kHjUO36lzDzKbC1OmKva1zKycLnxHFeUtNXNFCtEkn8WMKSJn1M4+jnUSY1o6cZoB
         BBxyN42bFPyrEP6h/k1OjXpCxAGrCh3QUHUaMLl1FMnOcSBcc8k1NBldD/H94EDic8
         yEuFrb2HNzJtQ==
Date:   Fri, 8 Feb 2019 00:47:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20190208004721.129a9eb7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BjaIFSiDSbYLuTTzOa_Sn9a"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BjaIFSiDSbYLuTTzOa_Sn9a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

In commit

  761f63b2ff21 ("arm64: dts: sdm845: Add clocks and iommus to WCN3990 WLAN =
node")

Fixes tag

  Fixes: be7019103469 ("dts: arm64/sdm845: Add WCN3990 WLAN module device n=
ode")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

  022bccb840b7 ("arm64: dts: sdm845: Add WCN3990 WLAN module device node")

--=20
Cheers,
Stephen Rothwell

--Sig_/BjaIFSiDSbYLuTTzOa_Sn9a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxcNukACgkQAVBC80lX
0GyegAgAmfcukKZOJpy0z7Ung0nahPqBX5T6Tb5PVnrPei0EY/d/9/EzSlNYR47n
diYx6t/sdGC+5OnSy4Xqm18oX22bny8mqolIaf2DnTs1GIqUScssWAFNwuy/GNsI
oEXZocBhE457HqEmch8rvLnTIZj/JWES1qwt98/QMbPh4Uo8Hfg0/HWDAK3LPpZ9
4I+oGW9fm4NezXv543Hd5iNLtljRr+Pb3h5XbDwjA/1/L6C1izwLz9esRlGsAX1U
1A/ixluZTaZ1DwhcB8X+bYzVLJp4o27Ox2YLSus0vsrkDmlRzyiHurHZAs7uWo5i
ABmaMIsxek9VMf09YeTka+VCXubPPQ==
=iq23
-----END PGP SIGNATURE-----

--Sig_/BjaIFSiDSbYLuTTzOa_Sn9a--
