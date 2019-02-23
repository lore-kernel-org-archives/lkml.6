Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACA6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B391120661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ddJ9T+nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfBWOTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 09:19:30 -0500
Received: from ozlabs.org ([203.11.71.1]:44915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBWOT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 09:19:29 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4469M332Yhz9s71;
        Sun, 24 Feb 2019 01:19:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550931567;
        bh=3LvfIH6aUNqfa3+M1tjfnU6HU2HTqB+I2thp0+kP7fs=;
        h=Date:From:To:Cc:Subject:From;
        b=ddJ9T+nfDL2JMl6cGlboa7p1OEl9QRfXz7EVc7YwwM8Bynti6oMyXV98ODDsYRhJ1
         s+J9qDHDQqKjY/zICc2syeYJK/kNoulR/lZoCzTCbGc6a895e9TF0Xt0qNnxXaGfoM
         z+Knpb79Wbt8IrJiKXMZwy9XK0WKzxje/dBTtsp5B6ZtCk4NdEGG7YoJ0rnIvsL8Ig
         /yGQPCwg+sbFODaI443cVlRiOUILy9VhSQsz5NLmghjQ9hwAJp+5juwVaGVgTYRodJ
         nXKqwZLKaaatMWCwFh0MIQU46CNn8btI//jbzhrV6seYCBsXwNlSmKcCReN1pxBJYR
         RORvrhtNJzL0w==
Date:   Sun, 24 Feb 2019 01:19:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20190224011925.6db87446@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N_xnHxZuO.fQFKL=eVIoH.m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N_xnHxZuO.fQFKL=eVIoH.m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9bfe33ba29d0 ("x86/CPU: Add Icelake model number")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/N_xnHxZuO.fQFKL=eVIoH.m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxxVm0ACgkQAVBC80lX
0GzqUwgApQKmt2XQS+R5d3owu3zH3NlBwWJXCi7Nr7UaYv3tfOijnnt624mmUnAl
XNxEHLZYyYakNSuDM7xe0RMXFv7lltE5mZkLE9WIm1XnjBVjbYFSMr4A3T5fujNU
vT34qhwvvVcgTM1Ay0Iuuj1Y53wW1nEDRPyX3yyiUX8rVzqUwIzffXJrbqODrRIK
J7hVVCv6wwKzl0aFoX2opYysfOJZdy97WQ+Q7Zy5DlV+vshgDYP2O37n8vO7Iz1t
Gzztya/gpmjMR/oK9sPfDS6x2gcifOSCo9iHKTiFcAZtpFIPVw3uuKxWNK1P6vTi
8ig14K2FIVmD0PF0QL5NVNUM5N9IOw==
=Qd4J
-----END PGP SIGNATURE-----

--Sig_/N_xnHxZuO.fQFKL=eVIoH.m--
