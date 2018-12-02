Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C9BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C05020834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C5uSUqwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C05020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeLBLRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:17:45 -0500
Received: from ozlabs.org ([203.11.71.1]:50417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbeLBLRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 06:17:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4375Fb4gmjz9sDF;
        Sun,  2 Dec 2018 22:17:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543749459;
        bh=4IF1DEMzabrvnZOQyDb5kowLq+GivRJxxJmQTZReQ9M=;
        h=Date:From:To:Cc:Subject:From;
        b=C5uSUqwMKzp8jBp5afkkWPkq7+dmfVlfrfOyHbSRPxmPIsf2YWH5ClNlRDwGjywLr
         lkm8/ypxLQQ3O77OSLorLFlL++hUjd3HOaUOkpKrx0luIvCygwyIlbzWCfsOQ7l4M1
         p3XnKQqvq5S1E+A3T8s54Y5s8yIEFji2gHSQn/H+DS/Mj2fyk/yxYCRzzJzmq7yWta
         O+eXe3oqAZbWLS+c883KwjSTwl29zOMedSv+6ZK2R5R3mp/LJlrfYNZpV0IQuJ7oyP
         G4Je4hnVsxfYY2FEBzUjDU7FjMyccGDiSqbmHnhsjfar1SfGbsTB/hDkVphzIWhcq4
         rHqiO/b4TrwfQ==
Date:   Sun, 2 Dec 2018 22:17:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: linux-next: Signed-off-by missing for commit in the drm-msm tree
Message-ID: <20181202221733.34f7ddcf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6niei6bi3HC8sM3rAX0O6IQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6niei6bi3HC8sM3rAX0O6IQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Commit

  a288ee6eb8d0 ("drm/msm: validate display and event threads")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/6niei6bi3HC8sM3rAX0O6IQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwDv00ACgkQAVBC80lX
0Gww0Af/XYLO8GZfq6KIVVMb6kGUORh576YbNXwlwk+lSiYIXXNUjVLk7gN2xAMW
K75ZaaA4I1pQ2hRsjBDRPUMu5QHlGRbQB3ZIS+anXjvR5EpqumowyF7Y4zWy2SS/
m9tlJmoht5w0aOFtp7U1OXpMU9+HOWfmnvQ/1NZ23YMtgnFhXEZKwBbWAwklkjAG
xlcQpyPAdNjcc8gUlDJP6/BGYpG3tytvKSUJmROPyiuYiHq81in3SszUH23vB8L2
/wmbElg2nR11mvhQ3UqvC0UJJ1hKYpDD2JihmOjXTB0duM/kxcVEW2P+lstKuq4G
mxXI97GmpG5tTZDJSGWNHYjNK/rwJw==
=SuLx
-----END PGP SIGNATURE-----

--Sig_/6niei6bi3HC8sM3rAX0O6IQ--
