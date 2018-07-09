Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83276C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE8B2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L9H/91SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE8B2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeGIVyn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:54:43 -0400
Received: from ozlabs.org ([203.11.71.1]:59809 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933012AbeGIVym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:54:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41PfHz6dGyz9rxs;
        Tue, 10 Jul 2018 07:54:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531173280;
        bh=i5PUef+l88rF2Ov3QaWCCLOZorclu87vcoSizp24huA=;
        h=Date:From:To:Cc:Subject:From;
        b=L9H/91SWLm/4MVRXI455Hr337oIBuu9BDfHbyf3c4KSnBOmkKYYt4dQv0FY044aQv
         9ZXTOKMIaRz1zdCB7bMgBn0HSTKR19euZzL4DFjspGmjrkYVt/j+iw5ZOEUuar4WY0
         ekTsCzy1hFA+j1dCh3zhOA+CzeHBd4GcSN4TierbthEsEn0Eio575sxwGBDIhwoSlJ
         3tCfO4YjkX8CeQj+7o7bQWorGICxh/lOLQsKjr1Ot6NPtgUzls3an1FzoEVXVXf4Tw
         7uyyLPr+QsXRKD8E+iFIXvtTsBnkyrR+XpVLI3QL7W+Xjki/w++RBRpKMD9U/4cij1
         G+J3IpGx9sGVw==
Date:   Tue, 10 Jul 2018 07:54:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: linux-next: Signed-off-by missing for commit in the pinctrl tree
Message-ID: <20180710075439.4a449b3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R4sAG_Yo9CHCKFaAWCOrqLJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R4sAG_Yo9CHCKFaAWCOrqLJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Commit

  a742fcf72902 ("pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and fun=
ctions")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/R4sAG_Yo9CHCKFaAWCOrqLJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltD2Z8ACgkQAVBC80lX
0GwCzgf/dfUVOht9wSReL1RXy7nyL82/VGduwSglL0fd4QfOY1f4CpwcjRBCH0w9
h4gW41DqJ7TOzl3Dg3nOYrJ2oxKikUjAv4Hb6L8rDAyxbQzOnbDdzo4DP/1xv1Ys
krI84MrnXaaXRUb53kWTpGmZGHg0pz0qtYxxEnULet0ak+1VXiS1OK7ogWNV8I9q
8d0vjduq/7oMdfExvlTEoLXjfQ925R3MSHA3bZ1GgtgWokRzyTH/HcfI812ydiHx
gerE7kAVcO9d2nz9eVNCokviMIblJ8FM2jRb7K3PPNwc3956kbsWfpo/+etPL/1n
+kiFhtsKT2sTwJTrF3S4OOylo0OR0A==
=F4IQ
-----END PGP SIGNATURE-----

--Sig_/R4sAG_Yo9CHCKFaAWCOrqLJ--
