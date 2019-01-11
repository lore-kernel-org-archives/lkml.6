Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1984C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF23321872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GfxCLAzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfAKDsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:48:24 -0500
Received: from ozlabs.org ([203.11.71.1]:57573 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbfAKDsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:48:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43bTNg4Rjnz9sCh;
        Fri, 11 Jan 2019 14:48:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547178501;
        bh=XgczFDd3fsw6t76OZ8FXdT/uIFjV77rA1wzdADUDD9s=;
        h=Date:From:To:Cc:Subject:From;
        b=GfxCLAzI7UF1WMkMEet67UT8QcO4ky2xuyT7gHkcvGPOfkyywNBno4DwapbH3cimZ
         V/XoHmiOPfpK+kwPnAuEuSxNqIWwmbzPjexm+XlRep5lcyWSYbBGfptniKMRmbcT46
         AO4cg7jj/NDAL8F5qmDPaC+Vrshh3ZC0TX6yuJtzZpmA8YTTMutDcaB0vYARcTDS0r
         FxuRAV566f1dhmMCQhhlmRgjmbQttvBpeFN83e4r2WmOOLKSC9AAZbpWfHO6x+SFLh
         aTuapv8Sl87Vcz92mGZOit3olkkQgi/fgrO66H8Y/FqHS98XI/xSCchyDnuaEX/LSK
         mL537i6SASxKg==
Date:   Fri, 11 Jan 2019 14:48:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20190111144818.0fe8bde2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YmCBCE5/VNM7QcL2feSRQ2n"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YmCBCE5/VNM7QcL2feSRQ2n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b19bce0335e2 ("net: ethernet: mediatek: fix warning in phy_start_aneg")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/YmCBCE5/VNM7QcL2feSRQ2n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw4EgIACgkQAVBC80lX
0GxDOQf8CS4+7j4pDYbSDumoahs2ThLSJpJEbpzfGOImIcNHTiA7ch6xw7bgUktK
da74siHJZYRRt/U3nvQR5cW3c8fA1RTDCqjoPhvu/XaMYzuS4dcJwb2Qiou5fuqa
4GwNlk+roz9fDeFZPP+aiay2POvAZlIQNm4UiluNTURVqa1Z64Gy5rLgIr5jGak1
GW7xGuQhPTzqxkbE9ayXVl6Kx3QTsJRS8l9hCgo6xKy5Z9HXbHKvvGDXIwVCU8vm
Hk24KX2jsJTb/D8kso9AMzMd2iJ8AAoj6fnLup5TA2Oae2y3o82dlKtcggh3dyAm
49KUNjJ8lQsNB8hFIeSFryvClz0QUg==
=F1i+
-----END PGP SIGNATURE-----

--Sig_/YmCBCE5/VNM7QcL2feSRQ2n--
