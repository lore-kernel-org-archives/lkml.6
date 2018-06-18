Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A108C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF992083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LMHJoVCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF992083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936879AbeFRW1l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:27:41 -0400
Received: from ozlabs.org ([203.11.71.1]:48677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935073AbeFRW1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:27:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418m1k25gYz9s37;
        Tue, 19 Jun 2018 08:27:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529360858;
        bh=rlYbg2ll6VBOQqd+flH74G5DuSaqCw3nz9vRcTUaBg0=;
        h=Date:From:To:Cc:Subject:From;
        b=LMHJoVChdeMQ3eFLNY30gmvLjvJsT1sbKkaMjw06Wz+Zf5UIeXJcBlocFiPkDe46q
         frGZnWRPOYI/304Va13tbcTT6nPO8VgyZDPRI9arwY8iQjkrVYdAzzoVbaboxCuRjC
         ZYoA2Hc8yyBF8JkT6xfM1utDrKNARH5wo7L3HWUZGNDceTe7J4yQqd8DaUm0pjo6rt
         I3653f0v2UFe7jZz8xkNSUDrNZZiy71ZC8kf27p+dVi80lgbBAuTbLAcU4ISAHxaKV
         jdty7IFB3nQ0rHbOeIdFnh7ZDnOErx+Dls6nDzuoEELoRb6dNXtgdzCh/rfOC0YbeT
         Cnb+eura2XXVQ==
Date:   Tue, 19 Jun 2018 08:27:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the
 usb-gadget-fixes tree
Message-ID: <20180619082737.1c4d4d93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LpRiY.+TW+DaaLLSrFx6XkR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LpRiY.+TW+DaaLLSrFx6XkR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

Commit

  36b0f5cca90c ("usb: gadget: add error handling for skb_realloc_headroom")

is missing a Signed-off-by from its author. (actually I find
it hard ot believe that "linux-usb-owner@vger.kernel.org
<linux-usb-owner@vger.kernel.org>" is the author :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/LpRiY.+TW+DaaLLSrFx6XkR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsoMdkACgkQAVBC80lX
0Gxptwf9FBHAUIlS2kxR7PTrKr2vrVizxJ1JctqPWCmnxyGr0JMhaTPzhkyBOE5r
VblQltotAOYkyopi9ekxHprix4RBtcWH+frsZx0oB4PaScVvxXEnaYAD2Kpe39rt
+HCNGQ4xjceto4S0t9K8HOYxXRYurrO35lFiw0L6KdbCcHCx8cl9078o9XMKfvPO
4qtJ7ExboywF4VaObtVXxLOBibnZXhodoYAUoHGWVl1B0DCX2qAqVq138WAveA7B
aST/H949i7sK3a02rvSc89uHQNqhYCXaQOSwe4f/2VJagMM6R45+b+EqYWolRa8C
y2d8Q/6j9FABwYMulhBS6/zEBWl2dA==
=R/id
-----END PGP SIGNATURE-----

--Sig_/LpRiY.+TW+DaaLLSrFx6XkR--
