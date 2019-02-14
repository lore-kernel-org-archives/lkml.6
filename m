Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E438AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2197222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SqeYOO4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406858AbfBNLDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:03:46 -0500
Received: from ozlabs.org ([203.11.71.1]:51541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfBNLDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:03:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440YRL6kFDz9sMp;
        Thu, 14 Feb 2019 22:03:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550142223;
        bh=Ruj9B8Q+wvPyNu0Khiyt98Ya3pDKAEkOBmP1oWdJvTQ=;
        h=Date:From:To:Cc:Subject:From;
        b=SqeYOO4uJHntPr9yIK1iBPckvLZCVWjht/JYSYKmPi4sogci/aEh49YfqpVZGUtwj
         Lh5e8zP6qN7EYiLo4mouUjhS0k55LCUOMhlizPKorM4KoHpnGkSnjdj/su46YUBR9u
         w+3tUVY9FypN03UPxjiUL+onRt/CwtNnWFF7cukT6GuIq2lbT+iGhDYTANVEECMzgH
         6po4x10SXDX3iVPmaIl2HEx2xNVCkKZ0xCFruBMMZerdgz9IzF159FFo7PB9jxwIhH
         L1/CFwXMTsjU1ZGuMP32sYJmZoLQk/Noaerg88Qqb19sfKldBPb/tlgqTLXAZMBBEI
         AxFia3HWL2Dmg==
Date:   Thu, 14 Feb 2019 22:03:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190214220338.7241bdc5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KlTLonZdfXUG/YUdjLwpWnH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KlTLonZdfXUG/YUdjLwpWnH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

In commit

  a5a0bbca16cd ("pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins")

Fixes tag

  Fixes: 0fefcb6 ("pinctrl: Add support for Meson8b")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/KlTLonZdfXUG/YUdjLwpWnH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxlSwsACgkQAVBC80lX
0Gw/ywf/THFr29snIMcqZ4CD7J83H5MzpQW4efbNUNk2+m4bZmJKLnIwRsywxwON
vO5BDH8Mc3DkoKA7V/mt1rbj/s7VlDilqsSOvKIFZ1GTdFFmCPOYCIK8uNlkV7eP
KHrf2A14r8QCSyHG/9W/MfRRHKH+ETqLZEqL2vUrhUbdi9/vWgwa1UnR1GpD5uBN
KQgweRJy1m/H3zzPb4UoSSDLr8iRY62RiGILFeYOhXrmdXWSeF2DR0dGR5JOpae/
BNMEJD98ivevj5kErGkMj8BT06PgyTsGvm53fReaPSkicWP3dBUvAbuS+3z4zjRl
wICUfOi6VuBElYbB1p5AQ6gjYISG/Q==
=x77H
-----END PGP SIGNATURE-----

--Sig_/KlTLonZdfXUG/YUdjLwpWnH--
