Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5670C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CB420866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rUwEsTBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfAPUzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:55:12 -0500
Received: from ozlabs.org ([203.11.71.1]:55269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfAPUzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:55:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fzx90xw0z9sDP;
        Thu, 17 Jan 2019 07:55:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547672109;
        bh=kjuoGIwHolbisRWPYTlcBT6S+ZmPpzdrxBSZ0hx+4Hk=;
        h=Date:From:To:Cc:Subject:From;
        b=rUwEsTBDaxvBbRbQZB/1cvASOy8VNnVY1wuk6A00MOi8NiH4lc9MA5/tegNTXI6Wi
         TmFMlcO6XRquWQjL9vEhb6U640wDxFTG9LBfcr+4CGg6+gVbE/H3scob5ZD2/yIHlo
         q7JiyU7TYfExl53ZuwW5N13dzADilRRLW1RGR5aah3vl/hzSY196IcHp4dM0aZIvLP
         PF2UB3IIdlI4wM0kECxB3wHJfoTsnMQVtNe3AxF5TsM/mRS3z+8+ExNxiWGl/svj36
         y4USHgUJFdTSY9pMWMtNhI7OF+3RWkq9y1whzzt9ynwP1wJdC+OZC40WOYnvjGOH94
         7Pwvrh7k+E8UQ==
Date:   Thu, 17 Jan 2019 07:54:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20190117075459.50e6a22f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WPSaKkiaC0N+lZDb.IwvpAI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WPSaKkiaC0N+lZDb.IwvpAI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Commit

  fde7ed930ca2 ("arm64: dts: imx8qxp: Fix MU4_INT number")

has a malformed Fixes tag.

The SHA1 should be at least 12 digits long.

--=20
Cheers,
Stephen Rothwell

--Sig_/WPSaKkiaC0N+lZDb.IwvpAI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw/miMACgkQAVBC80lX
0GybRQf/evqxS0ALcGxM8VXXFAQZhDPTAj+6rLi7TJ1sHKqDpWDm81zURJLR+Ru6
iqCHAOZdkD6VbgEWZQZxz681fPZQcR2E/N9nOOsrRpmLTIX7Mf1QDDe7B5BgiIcP
mU/fT4nTa3yWR19nLSpG8XDb9ZJe4owWmvAGrCaSxNS0r7ZquT+nzHrKUY81welE
aUfG7HWxp2rBb8ssCuK6GgLNkfHcRNYFEk2jzbRc3bmzXsoYvaDdz7kG7q9/rBmy
l0CHZMY86t1RWBNnsE2Synb+dDT7mglrinLdzStSPYKgXFBFS3TXTUOuPaZu94q+
Wogi88nkiES2efaaJYVAeXLiivJ7EA==
=sCtf
-----END PGP SIGNATURE-----

--Sig_/WPSaKkiaC0N+lZDb.IwvpAI--
