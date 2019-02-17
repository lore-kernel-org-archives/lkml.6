Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D41C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898672173C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EZrVgKxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBQW2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:28:14 -0500
Received: from ozlabs.org ([203.11.71.1]:36273 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfBQW2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:28:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442hTk4Xryz9s5c;
        Mon, 18 Feb 2019 09:28:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550442490;
        bh=tfAQAW0ebzi5G60TiaL0jykmLXvRGjyHTKzboliiTG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZrVgKxmJZUV/M2qHSduwOg1D+/+8R+zTDKrCm5t9ioPBnlouS5IBw+ZbHMn3x4MG
         KcvwfUlzAg/ky53QFxQ4oRkGBdIiD2tOJarv1PN1PAfoW6Rx5+dAeQdURoxiy+F25o
         rIS5RkBb3XtTx7LMDzVR1YICAQ76KXNU6dgLydEW0GJPGTma9m7PCYVHNLWpXRfOZ7
         LZ8GmFnduNFS+ANjCb+rUyvWxKUhbtMkPvfB6Wae1aY69dI7VtxfogS/CGeX0V0K/d
         My1oQF9q1tslHqWcZ55kZr0MMdsTPxW/ioK82s1f9/4/3s2owa4c3BTJ7vkhbta+jp
         fUa1oQ+ho8iOw==
Date:   Mon, 18 Feb 2019 09:28:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20190218092810.0a46ad27@canb.auug.org.au>
In-Reply-To: <20190218092536.39375e84@canb.auug.org.au>
References: <20190218092536.39375e84@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/km8zEk8AgWkrbktC.BTp9yt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/km8zEk8AgWkrbktC.BTp9yt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Feb 2019 09:25:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi Linus,
>=20
> In commit
>=20
>   a5a0bbca16cd ("pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins")
>=20
> Fixes tag
>=20
>   Fixes: 0fefcb6 ("pinctrl: Add support for Meson8b")
>=20
> has these problem(s):
>=20
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Ignore this, I am still half asleep :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/km8zEk8AgWkrbktC.BTp9yt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxp3/oACgkQAVBC80lX
0GyntAf/SmLdLoAIIcz0h75npYqagH6mADGu5DVXqWnhw/KzLKf0SukXKh5J8gIb
Y3YX7ph54+ytpPIklp3fmaD5IH0IMfl9kBpRMYWE7vcm+63Rhxe0c5mDnwIpKPSq
H0Vc8jBjhbAv4VC3uDqWHcFxQBQTRN3cMwtroYey/8ipH/nquo9IAjD+5VJB/lQS
qEFGB8CNF3wCu2DpZpqtBszpaHA3LlVtGwHLQA2rbfyKn+YEFJCAi4ch42tqNGFO
PrICjmoXSAXKEBcejTTqueZSFncKy8irTyA/PdLWQUH60YMKNnhFpo74GVG7DnLP
QjpC8HugjM2KYuo45Poh7WkaihJiyQ==
=wJ8v
-----END PGP SIGNATURE-----

--Sig_/km8zEk8AgWkrbktC.BTp9yt--
