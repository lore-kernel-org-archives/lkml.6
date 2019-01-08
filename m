Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DDAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4442070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b1DccWWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfAHUoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:44:34 -0500
Received: from ozlabs.org ([203.11.71.1]:48825 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbfAHUoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:44:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Z44b4GTwz9s7h;
        Wed,  9 Jan 2019 07:44:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546980271;
        bh=9EfOMsxluGI/aMM5aVrscjoQJAh/hU8EUUkTu15QCcw=;
        h=Date:From:To:Cc:Subject:From;
        b=b1DccWWakLT7uIQHVkD9YvkqVnwcmHllTSXK+vpDc/FggdEx6QwklIBJiPaFG8FZC
         MgRlV3C+3+y7W+LuSBZ/2zlFuml60IaJB5MnzKuEutwpsvKJ/zLOd+IYJGvDI0C5KW
         CCjlCVAcXAqtV+miOn/L4o5/DZ6IKf9hJolx1CScswhYzPsE2lr8swYk0RiI/L6imw
         iTTzHEnBRGaGEsfKJZfinb55XmHX5nvi1lxkura4k6Drdv9EacVHFikjZ6O8QmUHAd
         yXSDQAQLzZd7Iwn0gJ/DJk3lUyLkeS1goOJZhQ/C38B5+1IvV91sx5XrshbEPUEn7W
         UaTe9Ek7xgS6g==
Date:   Wed, 9 Jan 2019 07:44:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drm-msm tree
Message-ID: <20190109074422.51289d80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o0f0/kUz+pHsdTbpanE=roe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o0f0/kUz+pHsdTbpanE=roe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Commit

  b363cdbd40e8 ("drm/msm/gpu: fix building without debugfs")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/o0f0/kUz+pHsdTbpanE=roe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw1C6YACgkQAVBC80lX
0GwrzAgAiUHwVa9WKgEHBE26EMwn02BHPLOwqsq2/g82OfFgLDulsJ/hOD++L8oy
i6cgSkw3xpZA68T7aKh8CkMPpvI7j5LOsZmYMP763oEJFf38vOLDoJtpmI8iCpB9
ac3IObBSxmgBQPt+d1FHETNa+rUiAz3oQ7OHRKKGOcgf+538G/bULWoWk5UCp1VD
Jy/9zEeIbqWf7xQuO2xScT32QgH6IrpDsdePETk7zeRr6DJq8rRuO8LUigAJ3Ye5
D6i3mpPO6Z1tafKVL5Q2kgo03yOU3EkLcT1KsVNBAAxeJbTLzczzdAOYbRwGcoBw
ED2VXj//1R9bVUPF8MhpuJK+2g7Xeg==
=W4Cc
-----END PGP SIGNATURE-----

--Sig_/o0f0/kUz+pHsdTbpanE=roe--
