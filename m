Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E7EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 06:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C22E2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 06:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j8Lh1sgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeLPGXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 01:23:43 -0500
Received: from ozlabs.org ([203.11.71.1]:58403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbeLPGXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 01:23:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43HZ3v6Dykz9s3C;
        Sun, 16 Dec 2018 17:23:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544941420;
        bh=hB71LY+45e1lSnzC1da+t1mcC8z76TZaQNJsziJmqWU=;
        h=Date:From:To:Cc:Subject:From;
        b=j8Lh1sgJJiPl7zjsyFgCQps2bmqW8NYNiFKhFfW9IHpJdNi9pSPAIq/ZsbPP+FOAd
         ea22ukb8a7n3RjUkQwDkl7lVnxX0tMgZSzHEXAZQFDXhQEhSy450v6Zo9SAQLDBcuV
         loGMrhmR7C3CTqq0/iSkuQZ6S4aHhcG6MtT63b4PlY2acx8YDx1i/w+F+MZnjUV/aF
         XxvLgLuZ42H6NlCIOVrsK98ou6hjtRaw/evRCtLWwsFpkcyZRI7sLD0/zexWqf7WBe
         yzMo8VDAM2tQ9x9ESmKCvIh9Zh9GlFgnuoIWkOmW/uw0WFJ+tumdANvf2adOAoA5e+
         /fiS+rQTmy5AQ==
Date:   Sun, 16 Dec 2018 17:23:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Cao,Bing Bu" <bingbu.cao@intel.com>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20181216172339.486781e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EJLHN6UEr=yWXhdqJ+gvq5_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EJLHN6UEr=yWXhdqJ+gvq5_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Commit

  7ab9b77a9410 ("media: staging/intel-ipu3: Add dual pipe support")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/EJLHN6UEr=yWXhdqJ+gvq5_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwV72sACgkQAVBC80lX
0GyQWwf+OOEMZfbNLOekrTQe8KFwKpx5ne6QGoQ1qdKYS7qhJu4v3F28DuyqTFtw
ZcFQoTmJiEojWNAyiQ1SlF/FnD+rek4Zxqmqbmmu9KDQK/bIAM2waZ0o0I4d+vBb
ZYEzvSP1yx6IJUJxU8rjP0Mh8QMgwUA+dKk9kP6Q/AGzMeBo0VEsNMjFVNmfMwwd
yQJn7chy61UqgpAQWQoPEiEzb8axAgyTWZq72WfyHWi8u43kP3e/l2GUyB4vhXW6
RtM/I8MA42bP/7ivGgH1vgDP34CS8XWQl6gCoWLWhhYCVkX9kJq/pAyWZt0MnGSf
9ShtBdvm25ejiObTAXTeUWbB0+ukyw==
=JQPv
-----END PGP SIGNATURE-----

--Sig_/EJLHN6UEr=yWXhdqJ+gvq5_--
