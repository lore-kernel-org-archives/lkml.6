Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F98C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08A7217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pzILvFDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfA0Dld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 22:41:33 -0500
Received: from ozlabs.org ([203.11.71.1]:36417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfA0Dlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 22:41:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43nJTN3rnKz9sDK;
        Sun, 27 Jan 2019 14:41:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548560490;
        bh=uI+mu7eP4CwQItPRZs/UE2lHAKgQmYWewPmKZaB3TPE=;
        h=Date:From:To:Cc:Subject:From;
        b=pzILvFDHH+SzJCF/iY5N76vNTQ89PdFvrUjBNFw5Q92PLH2Ai0tkLAl1bJ2agcuZC
         bPKuuM0Z/eVCLRabQmPMdbOUf0zVEaCCLgX6kbsGvKh70edfgsNJN9HBjPKHhIJizA
         mUT8T0oFuKStTDXpbTH7U+/LQcxfGPJnq8aI/SjiO9nRhM2nijSi3V8gUzLJOCyN+5
         f9/2bY9Ca+8mgRFJy1p116c+cjKnvtl7OuEeMbvy2uJ4rhUiVdcofII9g3yiGVkzxd
         diDh9S+9ftDZfNZh5WJ8EPaZr1DuZ7sSbrq/bSvNDbOvb54nVgJyn5iv9HHg4aEjxY
         x7t4oFtGyelGQ==
Date:   Sun, 27 Jan 2019 14:41:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: linux-next: Fixes tag needs some work in the drm-misc-fixes tree
Message-ID: <20190127144126.6fc70a71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LIHR_E5UmizOOwQOhRM_PYJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LIHR_E5UmizOOwQOhRM_PYJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  053ff09f1a8f ("drm/rockchip: rgb: update SPDX license identifier")

Fixes tag

  Fixes: 1f0f01515172 ("Add support for Rockchip Soc RGB output interface")

has these problem(s):

  - Subject does not match target commit subject

--=20
Cheers,
Stephen Rothwell

--Sig_/LIHR_E5UmizOOwQOhRM_PYJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxNKGYACgkQAVBC80lX
0GwKXgf+P86GlJDxFktJYVZh7npJM6LUTjeN3RFgxtNzbfwy6PShLVosKmDCVwbx
aAiJk/DtZJMStrX1ogilf585b1IYEuSDBP1Ht8uTMVNAvAA6Au/qpWJovV+KV65i
n0LUqT12P0Zq/L6m9SDV91hJSBr81kzK4++S3A7gHsVnlxqzU2LrOmy08N83OAqU
Bbr9wP+RQ5voO5rscSdoD7UZdR2nNcz9f2QzQkeSZO6mSzTI++aDFKzaWWYFvIXP
c0soD0xHPMtSdPNiZcKOxSriprRtZeskHOHXswUj1wVofkyN2xs7zEVWeA1ts8kP
7eHFOYnkmuuukUpfTf/Kd9eIcth5Gw==
=0YvE
-----END PGP SIGNATURE-----

--Sig_/LIHR_E5UmizOOwQOhRM_PYJ--
