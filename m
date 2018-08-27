Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CECDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC30208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XM7o89q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC30208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeH1BS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:18:28 -0400
Received: from ozlabs.org ([203.11.71.1]:34265 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbeH1BS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:18:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41zlQx14lfz9s4V;
        Tue, 28 Aug 2018 07:29:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535405402;
        bh=QtBVRkOvbujelEg3J95BGHdmL19pH5zwfezdBqekqXA=;
        h=Date:From:To:Cc:Subject:From;
        b=XM7o89q/e+beecR2csjc7iviLTunQCv/LqghZoZbR2j/1dphABEgA+Ev69lGmBETM
         ODZF6khqzoBF6h3vWnlvA7N2gYbbDvghwozCIII/pyx2azkrPfL8IMD/pTqPLcULWb
         sU6y6vIyiz6JKmSiOxxba3cBgmll7VXZbHd+U27mosGpLIclpmPI3pMHlm8R9gbvxh
         89zf2x0AXZj31/sfp2blHJ/XZZvtFHVLWPdMZl4zkGCxjz8qZSk2YZAfOOGmXCF/vs
         +AD5ZCGSfSQ2ecOEXzZ7zmfTK9LdDDG2+Prr/Axm/v6vC24wFONWF9lBcWuwagEs1d
         n24KHBF8ci49w==
Date:   Tue, 28 Aug 2018 07:29:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: linux-next: Signed-off-by missing for commit in the drm-misc-fixes
 tree
Message-ID: <20180828072959.631b9dbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PCFkTqzhSdopWUKOD51uFl/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PCFkTqzhSdopWUKOD51uFl/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ccb748df0058 ("drm/vc4: Fix the "no scaling" case on multi-planar YUV for=
mats")

is missing a Signed-off-by from its committer.

It was rebased.

--=20
Cheers,
Stephen Rothwell

--Sig_/PCFkTqzhSdopWUKOD51uFl/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluEbVcACgkQAVBC80lX
0Gw1Pwf+Pg65ZhXa8nahH6ItMVHmPSfVCkMGowDKOAsht67r+xhXOEZC7cmvzcez
K0wxvKyVpSy3bYXpmSMnfbkbYosgn4LiKiJnyaLy8mi0Cz57G37ntn+LNgo+mGf7
DKeHxFMthDG5GSxcgqZql0aJHL/Nra1CGnovDlIhzWGA1tYyLKNwguiI7Uf/pA8a
i4LkBIdWdQFh6xr4OFreB4fAdhy57Ee8JH0S2KTJ5SP0B7Agg+jBiCoX023VXF7k
m1l8ljV/MpRzI/8QAXYXGXne96WZnuS4SKwqVwEUiVSVKXcEwnHyOQ9LJyp7o4MX
wpkW+d6uuz5m+AjQPVQVYBN94ROcMA==
=fgO+
-----END PGP SIGNATURE-----

--Sig_/PCFkTqzhSdopWUKOD51uFl/--
