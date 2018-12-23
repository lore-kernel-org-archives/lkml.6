Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D27C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EDA2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ewbGKsJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeLWMN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:13:27 -0500
Received: from ozlabs.org ([203.11.71.1]:40323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeLWMN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 07:13:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43N1VC1cXTz9sCr;
        Sun, 23 Dec 2018 23:13:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545567203;
        bh=7jc8zWaFKK3yZvIAczGEsbl2Et9bffL5NFHSzjNqgxY=;
        h=Date:From:To:Cc:Subject:From;
        b=ewbGKsJbKvbRqUYM6bkTFQ7T0wC2VBpdC0fd9WdHkG+5+U3CM4YOaOgvGfoiGL+aD
         zrc9c9+LRWgKea/MGLt3O8ZpBSBY1rKxfqpqit1JDTlELhKyza8ZoxcMthKWbn2ZON
         CgymUOC3ZWqz5bLnjFOX0rciRocFo2HvSOXgwy42OuQ99tnoR8IcySqyQYt5fjc6yp
         dcnotFfoqmhs3SlvgBh2hXiLNzOEjmxWMcSAqyuvigQRozpwuvdmMbg4KzsHR5oMHm
         w/UUPGCxthOIuIVPoH6OTN6xMM7jArv2/MJOI33IlWYaZXBERM7rehNIEm7eGdat4+
         1PSgyCKNIktNA==
Date:   Sun, 23 Dec 2018 23:13:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harsh Jain <harsh@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>
Subject: linux-next: Signed-off-by missing for commit in the crypto tree
Message-ID: <20181223231304.1654cf1d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IYLvpdsFXFbjDrt=iMB+9T0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IYLvpdsFXFbjDrt=iMB+9T0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

Commit

  6501ab5ed4d9 ("crypto: chelsio - Reset counters on cxgb4 Detach")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/IYLvpdsFXFbjDrt=iMB+9T0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwfe9AACgkQAVBC80lX
0GxwUwf/fgGHy3RPcTHm5NmmrV2SurTIbAdVt5X70aRGxAMAJbDqWCSX9c3IRryg
5jEgHOqOW3F8uwTOYX5sTJQipifysKAY65ICPH0r2U445yU42qLyuAXJgb6SHlpS
IYiT5hkqQO3PIo6MauvJqUxLGIo5lURZOagoy9XP6Rkbbj+7whhWXBwTxL6Z2jQ8
yASTo1f/4hjOkffRffOhO8jF6lleAifzLaEtdnYtspyvkmFzvaZ4C57Op27d8HP1
S8gR9Cbg1Q5JZpqm5zjyGgkF5aDtbjqWad7HqTrNvYox2y6zm5JFwd1hClbPHCDt
GlpNv0dDB86cTtI3zJ6hPzfOWxGjZQ==
=KW5P
-----END PGP SIGNATURE-----

--Sig_/IYLvpdsFXFbjDrt=iMB+9T0--
