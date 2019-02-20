Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0322CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AD92147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c2n3FsOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfBTAvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:51:35 -0500
Received: from ozlabs.org ([203.11.71.1]:53737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfBTAvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:51:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443zZD3t7jz9sDL;
        Wed, 20 Feb 2019 11:51:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550623892;
        bh=Wza2wazV59NUnnAhxsrxCXtUUX519X/ZbU+qgofgxpg=;
        h=Date:From:To:Cc:Subject:From;
        b=c2n3FsObSfzFc3GagDg6RT0f1OHOcN6bDFzwLnNVaG+XhLlRyZG0rwJp7OhoyGsh9
         Mc8HJRuVgyF6yvEoSYQxKtdg8IwxvssfHqg5dqyRWk1nD3Xp9vOEqVqkVKOWnFffrK
         DEffBN0hiuA06ajlUdzpioVJaYnrpWH94qYf8dYSB9Cr87RNCp04+vzWZP4m20VDxx
         7TiL3fhB9ttZjXuy7k07d28QfljsjOXUHhvWSj+SdbkdR6i+D1AMkP9INMjghs75E0
         zie6nF1KXQfliASIY2xz6TOw2t9MwNEljUvDL6yVibp4g8RIfgLmLj7JNRPC3ztbDB
         L77eRlLG1EZ5Q==
Date:   Wed, 20 Feb 2019 11:51:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the drm tree
Message-ID: <20190220115129.70e4093d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CbGYXyplzt=xCVUFQexHiHt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CbGYXyplzt=xCVUFQexHiHt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  f180bf12ac06 ("drm/nouveau/svm: new ioctl to migrate process memory to GP=
U memory")
  5be73b690875 ("drm/nouveau/dmem: device memory helpers for SVM")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/CbGYXyplzt=xCVUFQexHiHt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxspJEACgkQAVBC80lX
0GwFJAf+KmMI3FzHtXhEfWAV9sXkcD8t4TtN8SRRcY/M05/c0m4ySZSz1FKgNJ+c
9XJHEuJXvYEKnYoXJxpK5xqE1ATaHzlwbn0VZ8SBT6Te6eGXahUUNt1/UujhhFw1
0SqRjeFSU2xYqdbFeSagyUyWju/c90wbjaTAaI8L+i+BKELZBp/MyrVTrwaKShQF
+kGVcRLH1dBhsd0I2ajz6wZYXfn5aLKtKkumTWsJTVdN+NbI8f4ttLmDIoADMXwj
rD+jLGVjRgTPILFz8NE2l8bG9YcAD4cOyQR21gyLA7ckrL3H8GZyVBd731842CWt
wGxHERKMafSHDgB2OVnvd2uK6gF1xQ==
=n/Gt
-----END PGP SIGNATURE-----

--Sig_/CbGYXyplzt=xCVUFQexHiHt--
