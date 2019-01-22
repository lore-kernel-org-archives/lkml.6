Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D733C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC79D217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YM5eenqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAVU4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:56:09 -0500
Received: from ozlabs.org ([203.11.71.1]:47375 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfAVU4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:56:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43kggT66kSz9s4s;
        Wed, 23 Jan 2019 07:56:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548190566;
        bh=+x2rjpEuiulvwPf4V/AGHLyLoqC/pWRmYi7tyoauAyw=;
        h=Date:From:To:Cc:Subject:From;
        b=YM5eenqyL3pfgHBWpA7JCmoO0oIs84FAxPVX+b8o/BK29NUouW9beVu6/mKAwmF+Y
         MgIZohInmOtAi9xAFx4+2fPTho2qoHkkzUYl7rf7V2NtwkrmIq2girk6Yl4P9b8l89
         EJBEyeAoXuG+9+Wk5cQAihlODF96FOyDiHxL+MNAbqLAQa6cGbb5m/bNMZ/kpiWaPC
         eEp+tJ2MQkVyyJju1EPpCM2248j6bb4UDqVTKACdfGmYSczI9X2QZSpE4s4l5gTEZ7
         2d9dF1zLx01kQWl4Mq7eTqgkg94ukKvCW/oHfAtm8fhEPh3ChQBjcW4Qf4kjJFrTEa
         WZOLuk+nxDL/w==
Date:   Wed, 23 Jan 2019 07:56:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Simon Horman <horms@verge.net.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: linux-next: Fixes tag needs some work in the renesas tree
Message-ID: <20190123075605.116ddbd0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YGyIxYLgTJF6YbZ7JO3Zxhz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YGyIxYLgTJF6YbZ7JO3Zxhz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8d6e2bbaeceb ("arm64: dts: renesas: r8a774a1: Fix hsusb reg size")

Fixes tag

  Fixes: ed898d4fc19d ("arm64: dts: renesas: r8a774a1: Add USB-DMAC and

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please don't split Fixes tags across 2 lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/YGyIxYLgTJF6YbZ7JO3Zxhz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxHg2UACgkQAVBC80lX
0Gwkxgf/ZCI/KU8klbgL6sKakQ50tMiJOqh3vRQCJUZ6fLKDXWJW7sHRyXx2wx9R
+pki+C9w2Rs6zRy3ZaSmeb7NzNiz8GamCw5cXsgYII/uYM7lPkSz63dWPCI0mzLf
+IVapC1mjMF2iIXJ9ekFO/ltb2PyY9S6pX9OvmWOGwP0mlHpRiOEy0fAty9SVDjm
aroLfa7gurTeQQd8lYPX+3dJ4GzGJwiG5rpKoqtOU3RHkow0LVa/T+n23sn4xBcF
1hwdbuckMP3l37g/GzjRy39hLzTX4B4r+mfTLR1eqi4rGac4gTeZVNvA+nVSLu9K
Xz51EJ4umBC0TZ2MZC5YbqYS+ibqQw==
=+QQm
-----END PGP SIGNATURE-----

--Sig_/YGyIxYLgTJF6YbZ7JO3Zxhz--
