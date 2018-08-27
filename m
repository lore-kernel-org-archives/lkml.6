Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280E1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4810208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="prjzeS5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4810208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH1Baa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:30:30 -0400
Received: from ozlabs.org ([203.11.71.1]:40789 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH1Ba3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:30:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41zlhn1WTTz9s2P;
        Tue, 28 Aug 2018 07:42:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535406121;
        bh=mgOUH6Wlb4aLjqKdNL7jcFERjhFYgT0D8dQ9n2tmYhM=;
        h=Date:From:To:Cc:Subject:From;
        b=prjzeS5YsTcHE4Ri1qLnVrYvHUnzDErAJgYbjwEZvPpxnnBzqJ7x8xMAN7BxguiCm
         jllIad7uk4xNwBuYT6UTnw8zZ3Y4Iz/Ay9+z1v4DPEobwNIyLnXa1CXqulyq4IsGKY
         ysGvxQfFLcbgsPRkmQgsbQABX/wNrIFfBVuXrppj1BeluyrJGlnzhXVLRHa5pPpaBT
         mfm8m3fkj9UGmf4Dmny0mtMZoAUZTqlzF7vRI3ah5Mo5otPMyifNs9klMMFgahZV1y
         KSw0BpdR6bllvkjtYDqnTHn2TzzKYjgYgGl9rEdL46Mph3WbDz5F93KEp6H4gY4ucU
         llmvzH67AkfRQ==
Date:   Tue, 28 Aug 2018 07:42:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Anholt <eric@anholt.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: error when fetching the bcm2835 tree
Message-ID: <20180828074200.440fb5ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZU699v_7QWFA=yGkBoXwguF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZU699v_7QWFA=yGkBoXwguF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Fetching the bcm2835 tree (git://github.com/anholt/linux.git#for-next)
produces this error:

fatal: Couldn't find remote ref refs/heads/for-next

--=20
Cheers,
Stephen Rothwell

--Sig_/ZU699v_7QWFA=yGkBoXwguF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluEcCgACgkQAVBC80lX
0GxAaQf+JQs8P4qo3rKPEIZxip+bZclQFJPWBeAhB/6Q3ZvmfJfrnxyyaCc734aS
GrrKSg4pRhfzRrqgE0GOWu0rkyaRygRAXN7im8t253dFHrBHl1RN08uTiHo3Xqr4
Gh1WIdlHMHJaCg+TzatwnzT49BUpBHNa97Zqq9Z7+vostVzrf1BfQnJOAL9MUSMu
6sDFVT79XWvBAm/HzAzA74ckE++UKS757Hl4xrWuC//ElI8mYOgjZfGgwja0FOSq
ypUr6CiiXs8cYfHt1H21SzR28/YocLvIxFWBOgT4wzL7WareGsBdy+GW9vyL8wU0
RXym7nTlTM/3fvgUxY8fuinkOrFa1Q==
=NJFD
-----END PGP SIGNATURE-----

--Sig_/ZU699v_7QWFA=yGkBoXwguF--
