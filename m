Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FB6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CC02146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pShoJYUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfAIA3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:29:50 -0500
Received: from ozlabs.org ([203.11.71.1]:42859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfAIA3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:29:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Z94S5sBzz9sMM;
        Wed,  9 Jan 2019 11:29:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546993787;
        bh=6lxdzACKmovoYkJcI6P0ngKip1jua59qFgLz5aY1AE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pShoJYUc7ofraKdJ2PE5z0MHGxD+G37jk4XRXLRhhSigYKBLrZR+FcuU/m+tMnmWi
         +oLUrSTDaIsQTBGIY5F4XhUH0MEO9yDB6MCqQCULqC5BQWsv1jqM1rGE7IK3NfHiDv
         CxGQMWY/lft03f6ZXd5IHqAcQydqQhz0NFfuL7FUFFTGjJ30ZPktnFbCdCSMNl03U6
         Zqh1QmXk8Yyb89ZZZVvEzb/H3JAAVdtSfl/cYMQpmNBC+2I2t3w539s8tIeXRJ6RdY
         p03Me4+NYqFaAiLWBIy4COga27x9xCtpX45UsZsRXAb9G8Iq1ZZDusxV6tADaQ+cQy
         K/MIrlgLWTw/A==
Date:   Wed, 9 Jan 2019 11:29:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190109112939.04ca3fee@canb.auug.org.au>
In-Reply-To: <20190108083722.GQ21184@phenom.ffwll.local>
References: <20190108111230.2dd3abd9@canb.auug.org.au>
        <20190108083722.GQ21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/O0DKDpXUcy50pkSujkZIdZB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O0DKDpXUcy50pkSujkZIdZB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, 8 Jan 2019 09:37:22 +0100 Daniel Vetter <daniel@ffwll.ch> wrote:
>
>=20
> https://cgit.freedesktop.org/drm-tip/tree/fixups/drm-misc-next.patch?h=3D=
rerere-cache
>=20
> is the fixup you want. Should get baked into drm-next any moment, since
> the first drm-misc-next pull is already out.

I added that resolution for today, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/O0DKDpXUcy50pkSujkZIdZB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw1QHMACgkQAVBC80lX
0GzjuggAmCeKS9w8FjUSC0lVPqRjROMOOYbZlp5cdxOdeEpUr5mZGuyyeMNWC9J+
SH3LxD5gtaywf5jBabVyzZcB067FpsaiDApAc3HzpK2JB84mjsalKUG5Dq4xkV+j
XmB6RPDe3lCxyPt0p7ScAXJrvF07KHnIMmnUKAqDvCsqms7nyXWs+FNvbC1AOt0o
Wagdj6H9K/iPIpI/cdmYIP1La51vYWEWWo7kwTObtUm49c9/w5k1uMXXsqd0UmK1
vsTTJLr66iLV5fNZ5+uKDARGeiFuNcCIbwTdY0E/tYZbU+XCtyzMi1doxoU2JaRj
z+8GbII70zEnV/Shiu0/z3bI/X6mGg==
=KUKa
-----END PGP SIGNATURE-----

--Sig_/O0DKDpXUcy50pkSujkZIdZB--
