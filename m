Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF53EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751A121907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WsPZSHXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfBGNuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:50:46 -0500
Received: from ozlabs.org ([203.11.71.1]:33351 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBGNup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:50:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wKTH1LRRz9s6w;
        Fri,  8 Feb 2019 00:50:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549547443;
        bh=GyRuL9oe/ceynqogXs7IHI4UzafH554HED2KRDgp7qc=;
        h=Date:From:To:Cc:Subject:From;
        b=WsPZSHXJsNYikU0hcOpUZ0W8v4PFUiMlNrR+ebXkhEypG7JJ0A49Vp6C9S+uPlWJ9
         nTVittwKsQ8Ae0g3BzOfxTLvtyqKlC+tk20Wiy0vhiWd7eerCYTOOQSPuaCruK6QCC
         RUr4AGdz8/QVoAV7uVWGaDuM3xZ+bvK4wsA+L1fu5u8Vf/H7OyEI5eAAwTkGRR4swY
         4+UvANmtPmmnM4ylHngs5b9D4aOkUSZQtlP/RFYNiLB/Et2zULJjjAcfqoZ9Hn1Igk
         q7PxvXKFBySgBJxKD/lrWuggsGwQGPAOiA+Knv3he/Nfo6cXOkGPuNVcaH7kkfqqqP
         VKXLp67sFJ/oQ==
Date:   Fri, 8 Feb 2019 00:50:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sunxi tree
Message-ID: <20190208005042.6b353e17@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d+eRIT+1OUH4EPb868ItlbJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d+eRIT+1OUH4EPb868ItlbJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  df0aeb208b24 ("ARM: dts: sun9i: a80-optimus: Add node for AXP809's unused=
 dc1sw regulator")

Fixes tag

  Fixes: aa4a27bc819e ("ARM: dts: sun9i: a80-optimus: Add AXP809 PMIC

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please don't wrap the Fixes tag over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/d+eRIT+1OUH4EPb868ItlbJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxcN7IACgkQAVBC80lX
0GxTuwf+K+Dot6BOmPRtiyc1uN1tXZhp4cl3ssTep9EFaOnYGHps7oM0LcOWZgQS
wfLR1lZr3UOhcRqzQic+jPcfLZP6I8j7Cuif2JQvUGlRLwxIuqpXPslane/gON9q
ysZd9Gpv9tV3E3y8/g/RiePeYiDhHFaKfW/9RwEEl58Ad/3p/PmImr5+cpbncON+
DXzSJ5CIF31gjeESCht4YDfqPfWioxhE4b+wJLlLFBXRHhOUmnOUs7wl7B5KceIN
SPThONLzhNdxrIpEYafiUHC9DfaLDHnDMaUi19UwfNbmvF0YQKOEyUE/sfO04TAq
dfywZya1Q3q7ClY0yuEWX5K+CQWi3g==
=moIH
-----END PGP SIGNATURE-----

--Sig_/d+eRIT+1OUH4EPb868ItlbJ--
