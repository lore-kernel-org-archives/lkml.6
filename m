Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD09CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7884F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sNFyheS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLLFMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:12:22 -0500
Received: from ozlabs.org ([203.11.71.1]:55139 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbeLLFMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:12:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43F4gR2DWvz9s2P;
        Wed, 12 Dec 2018 16:12:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544591539;
        bh=7Iqj1M+uQB/YUWvTbzCNQhS58Gaa+XCOMggGtJbP9aI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sNFyheS2J2Hvp2URLFncffedpg1CdDyad1q2luTQVqqGzL0rNMTMRbmTFF2OKNW4h
         viNElY/A4wFMRcOFQSlXRihXB+fGsX+M+NbruByDZOH4YySN1Tb9A7SnMbIW90pQMj
         If9O8GxJzUP1mHRwqT3LMeM9Su4DUcOpDNwaa/cRPWJFTV0va4kriQOw2qd/UDvJYb
         4GSYOAWLJerruXXlIBuHxuEhNNDxp5rLag3gOCOLlJEYl6IwUKibRXISOIZX5H78g8
         OMqvyKTrGAgnN8QY8226/uTj14bT7gMEhzBQtDeqfZq1eWTfJU5wuM84t/RsJWChZ5
         M7mzJqARHbRvQ==
Date:   Wed, 12 Dec 2018 16:12:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: linux-next: manual merge of the phy-next tree with Linus' tree
Message-ID: <20181212161217.6858c3d9@canb.auug.org.au>
In-Reply-To: <c868398c-9410-fa2d-26f4-dd86102a3584@ti.com>
References: <20181212151647.71a5befe@canb.auug.org.au>
        <c868398c-9410-fa2d-26f4-dd86102a3584@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NYZ_D_aq.qzWg_=V6_JZRd_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NYZ_D_aq.qzWg_=V6_JZRd_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

On Wed, 12 Dec 2018 10:37:37 +0530 Kishon Vijay Abraham I <kishon@ti.com> w=
rote:
>
> I've rebased by 'next' branch on top of my 'fixes' branch to avoid this c=
onflict.

Why didn't you just merge them?

--=20
Cheers,
Stephen Rothwell

--Sig_/NYZ_D_aq.qzWg_=V6_JZRd_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwQmLEACgkQAVBC80lX
0GwJQgf/Q8rj7NKsR1MVSfp2w8naAwbijTE3Ot70ad66DiAAtM7uZl9nZsVQvypG
37zF+QhG5VuARnBX0nEpU+ugVZhyNDVJ0fah25kHib28Ey8+cDwT3L+UUOg0eyvA
J6vMKfXG5nYqZjlLDZR+9UsuXyEsn0k/OqMUQWAgMNHbVw0AiXOQCJTWSLZFrxul
61/uqiJVRm22FuzuPIP3Zisy/l2L6o2q8P8oHsTshwcDmlk51eLUH684qusJITIJ
zD2H4NUXPxkcAkDhEX6e2Jp1QeDYGMLaBE8/4IoU5svA23NgS85UZ0oqtdwXMkEF
t7uU9G1jnGLt6FyT1Lqgc/Y9dzZhzA==
=gGpO
-----END PGP SIGNATURE-----

--Sig_/NYZ_D_aq.qzWg_=V6_JZRd_--
