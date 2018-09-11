Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB69C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A24206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a7A2mEo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A24206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeILAaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:30:24 -0400
Received: from ozlabs.org ([203.11.71.1]:49103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeILAaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:30:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 428w34341Qz9s3Z;
        Wed, 12 Sep 2018 05:29:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536694176;
        bh=rn8U4iWAEZRo0AV+eWZNy/cuKVPbwmwC6URYmoEOK2A=;
        h=Date:From:To:Cc:Subject:From;
        b=a7A2mEo7W916oNBnvWKgKYwN5DifygyqWdi4xK40GeGdfRsiKr2jqz1+9TWtwxkQs
         09vJ5LSi1110YetgqB/sBbec6ie8SToeW7eqn9Lg6u/cVC+8R8pJMzlOvRczSwev6y
         GCYMxCZToPHtIHdq3y62kHOFWKUX8NovYE8BUVqBlX+V1/WvzGoThvqGCNCPPIaeed
         EV1amY6sF1+dMfQgdK4xXLBhq+Ao88E0/jDcDJoAoEm7JllHOSv1lJkHBfULA2KhLM
         ZxRPmzUHeBOXicbBodtr4cU0+G6kysmolekyGt0HvWYpKEN4bs+j/jt4VAyJsFCfp5
         zrQ3S66pYtxLw==
Date:   Wed, 12 Sep 2018 05:29:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-fixes
 tree
Message-ID: <20180912052930.65ef6c2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QZ3wOrCqkDuMd_xbrX02kZa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QZ3wOrCqkDuMd_xbrX02kZa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Commit

  3b03999136b1 ("media: i2c: mt9v111: Fix v4l2-ctrl error handling")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/QZ3wOrCqkDuMd_xbrX02kZa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluYF5oACgkQAVBC80lX
0Gwo+wgAhh97C5S7MFWxvF2AAKysBLbwf5xemuD48ltJjxlernL66irh8/l4Xa4l
gag3WjARZ/SwWj0DLiydKEbmiNoQ59bTzRxnnlqPfluQSJ8aQG3Q6ADYpfrCW1Bt
DNYDIuE9XAbovaEemrU7WwTX9p+vS/QoB1SW2isTp1B2eNkRmxkpwODpInzGOLYE
25KIukhXXNn5PV6qL9Tc9Zazj1oVQkJp4U8HGUu0c9IIf2oUfd/nqRL7nmYdHpX8
dtjG1osS5bNkz5sN6ME7ccjuYKQRWQlk/b8xSib0Gx6KRFrjnilwouVMWDBKOXQD
HKhyqQj2FATORtYw16l62p1sSowEwg==
=sEc6
-----END PGP SIGNATURE-----

--Sig_/QZ3wOrCqkDuMd_xbrX02kZa--
