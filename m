Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F271C61CE3
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 04:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0569D2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 04:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l/cejo5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfATEau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 23:30:50 -0500
Received: from ozlabs.org ([203.11.71.1]:44325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfATEat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 23:30:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43j1vW1Lv3z9sCh;
        Sun, 20 Jan 2019 15:30:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547958647;
        bh=D0f1Trgxb+36GYWjrLwLJDEAgdcdb9nxaHLyRjv9gb0=;
        h=Date:From:To:Cc:Subject:From;
        b=l/cejo5Wu4Z8VA+W2e9E9yVMUh/I9CmLdrA9XPK/CZfbPig4XMD5h94wPYjSirncM
         ovgdwbG8jnOVaszB9MrGPnp0S4nlEL93oRkIsHmPlNetqf20vHBj780/Wjx/hQtAkJ
         fBKpnFZg4N8n5ZGk8KWONHvIEhLsuI7FZ+utkjpH60AVlZgVo3K2NHQsCvCpcpt9qN
         IomfoV5n6mscvx0X9ET26qGoJp1YbxPbIdTND+UzRuhpm8s2OKSYrXxEwSubgTZaud
         DaSWsUM/c9MB8tj/lnnsTKI0Xp8MwcN2l6VTZqfD3Q6ngl4OBczrBvlpp9e5qz18SA
         VadXnKad7j+6Q==
Date:   Sun, 20 Jan 2019 15:30:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the y2038 tree
Message-ID: <20190120153044.71775e03@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=v396z8QhdgcpY6MlFXyDgV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=v396z8QhdgcpY6MlFXyDgV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Commits

  e6f8f282d174 ("timex: use __kernel_timex internally")
  683569ef2b4f ("time: Add struct __kernel_timex")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/=v396z8QhdgcpY6MlFXyDgV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxD+XQACgkQAVBC80lX
0Gzb+gf+P8eyfXv9RaKI/1vH61hm6gURaYWh2UdZCXhvcTBm6pb3a+Xz8mJ6aOOk
9rLpg319SxMIjXlouEeKrwKnPrGH/msbxWzABzuenfXGJeIx/lvJHWbLiMmfAqfD
VFpl3rsn6bqDb21fIjdih9rvR59Gl0DVp9Kimop4pFz1luEG3DwUTW1goxHiVhxi
7FMl266oOmVwdnoa0rH+cz9DrsbD71ZvZ1PjIAiOr711dMFzyD7qim6+XbYKD+Nl
HbJztBOQ11D41penAcvZvxvQr2gp3N/7YRRrhQ8wfnktc8MPHJEPx0Pk0Tc4dpUf
vaf769ns65abY7A11GK7MuUq4voDPA==
=3q3H
-----END PGP SIGNATURE-----

--Sig_/=v396z8QhdgcpY6MlFXyDgV--
