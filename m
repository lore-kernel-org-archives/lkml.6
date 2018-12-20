Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF867C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992F220866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oZMpLt50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbeLTCL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:11:59 -0500
Received: from ozlabs.org ([203.11.71.1]:55801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbeLTCL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:11:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43KwHc6pdCz9sBh;
        Thu, 20 Dec 2018 13:11:56 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545271917;
        bh=ciSeFkVKWdah5FetgAxfiRQGeBDPYW6nO5746lzIMIg=;
        h=Date:From:To:Cc:Subject:From;
        b=oZMpLt501Zenwbychpa0wthCG2EWdNkBEwxM9klxVB+sM6rGjGi/S1RqODOw2IevZ
         mva5VvpPHmteAeH0/0HlUoLdFsn3LZkz+Ofrhnnt37APd6wxdhfP09svRY14AGBlMM
         l6AyWQxECkmivQySsAYbkg06gdi2eqDKex8AyIbd5UK8Gvn8T+JtdjPPvdz5IcaUW9
         VqiGUEk9tPF6H2uLM2F5mgpFpW7NYzNeT3F3o51gXbAB4alwVjc+NYFsqabHOJY9/V
         So1a4y3FlRKuClDy8d2V0RXiy7ZGhp1ZurQue2lhrc5UsfKHR2bQt7gRXRz+8h9gBO
         VNg2k38Pyy2zw==
Date:   Thu, 20 Dec 2018 13:11:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus <torvalds@linux-foundation.org>
Subject: linux-next: a short break
Message-ID: <20181220131156.67eaab49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ujzj.E9+gUKnp7NWKQH7Ind"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ujzj.E9+gUKnp7NWKQH7Ind
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There will be no linux-next releases between Dec 22 and Jan 1
inclusive.  I hope you all have a great break.

--=20
Cheers,
Stephen Rothwell

--Sig_/ujzj.E9+gUKnp7NWKQH7Ind
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwa+mwACgkQAVBC80lX
0GzHDwgAgBkU6MxgD/3PMUKyXpj3VNOVQzRK4QwxeHA7Hw1rVnEwHz4aPxBhHS1j
nGeq/uSY9wpL/P/ug+IG+N51uiGoNZWM52rPe6jb73enUtlFCQQjjK4ZrF40Gqd1
szk7TpcBiTqRt5puMGCOQhiS7I7VBCSVnBgkp1JsHegig+N+xo3QguLWOJzivtAE
hzYuuRWpgyekefEjuAnZa5Dc/IMCl9C6eBTLQqpEv/PCU+mUfYRlOD95xiZGm4dX
BNphsEK5IMMIO7FsQulYV71fzFggI0/EMkFL5dfTcFLzbNUGgfWFrzq3vElOVGBa
ok8rezlcNilVYU3dpvMStA0lE1U5/A==
=7Kxe
-----END PGP SIGNATURE-----

--Sig_/ujzj.E9+gUKnp7NWKQH7Ind--
