Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3906BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F098820652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="efzePBnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfAPVCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:02:51 -0500
Received: from ozlabs.org ([203.11.71.1]:46473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfAPVCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:02:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43g0601sc2z9sBn;
        Thu, 17 Jan 2019 08:02:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547672569;
        bh=hsJFeKdDfCcpMoIi7Hu48f0qx6pxmwDJJ0/ccV1Am20=;
        h=Date:From:To:Cc:Subject:From;
        b=efzePBnm6ilns/BpkvQpURKdM4V3OgWY1rEB7XjMp18AXmOuUo8UWyOkB/OIw+V80
         1KtaPebv3vhGXwNC+2rpeLe4ZyDsp/wPcarvLYbz9EWncx5b+g8YMHQaUFtLG8eFU9
         E/0AsV7/6azvoteNOjiBtNfcjreMkS31h97D9TSYqt4ien8vcDrcL4JuS5llH514gY
         LBL5FO0UJb55nAvRNL4WwnX+ELHQEx4ESvsdzWEbhmHwGgfu3ea9J5LOPyz4X7VzLk
         vItfx9TzUToogE/ZHaX68b6OTPJe5xlGRE3NX2Cdlq7VrIlmS/AZYH1zMRROTcfP8k
         58Z3MroA8ottQ==
Date:   Thu, 17 Jan 2019 08:02:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20190117080248.6f26b8fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_B7K4PT4YEFOcVN4J6y=5Xy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_B7K4PT4YEFOcVN4J6y=5Xy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[I am experimenting with checking the Fixes tags in commits in linux-next.
Please let me know if you think I am being too strict.]

Hi Mauro,

Commit

  961304d17a61 ("media: dt-bindings: media: i2c: Fix i2c address for OV5645=
 camera sensor")

has a malformed Fixes tag.

The subject in the Fixes tag is usually surrounded by (" and ").

--=20
Cheers,
Stephen Rothwell

--Sig_/_B7K4PT4YEFOcVN4J6y=5Xy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw/m/gACgkQAVBC80lX
0Gw7lAf+L1EVf1ZqsEhsfzzNyjD0kxf/zFmqGC/S3+YrjwUOA498RvswZdM39veC
pwxL5M9ZrzOEUqamf5mxqpAoqBz+Gy8jevv7QnLbmSAZ2DZGCAZbScGyoge2M26O
KRa4AnHL9e9hBRJl63F6He9RAdbJAaT4aKwFtw/pu+nSV48B4kTlWZzRZoraMDiz
Qv7Aic87G/k/a8X67jsI9KqVOi3mpOVkDpo/sgW97aY0OANz+FCPZst/GOpsk7ic
F4uBomatvO5PlSFzrM1rq9q7Ahquef79JmDZwHsG4vp/mgL8sRclsGcc6Vc/hzH2
0AXeAiUDhMJIE8zm1ZlaKZG+MXTSlg==
=7daM
-----END PGP SIGNATURE-----

--Sig_/_B7K4PT4YEFOcVN4J6y=5Xy--
