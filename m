Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F50C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EAB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jxPEgKcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfARFdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:33:10 -0500
Received: from ozlabs.org ([203.11.71.1]:55245 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbfARFdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:33:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gqNN0tbHz9sBZ;
        Fri, 18 Jan 2019 16:33:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547789588;
        bh=DsVckhLo1lAX31kvzNj8gGeT+83OvufmwRCuYLTeLu0=;
        h=Date:From:To:Cc:Subject:From;
        b=jxPEgKcM5ORNzgFmyMQLIX1t3eBHkxx7c+UWX6e2/W8fMFXlDFrhdX85ZI7QNI2wN
         Sjvw3cf3gZVijL/M9YKgB4cvm/Lto2QQUeHpT6cNfQengLpt4wbB513If8ePAp+GLq
         yVBW5VbdVZaqFi1epwAFMk9X3zeGk1HJZbr3V52ik5Oa+LFi3wmRu91IGouLBursUE
         djbYrRf8DdM2hn+hVKT+Gvsrcfhu4aZXBVpK20Y/LFx87JMgsSOXGacY6qy0lvxLpz
         QccqpSv+VplFOa7VYLJKGytOmcynNjOnueFnGh+reyO3emm6vyYRfh6e8r0W2j3yL3
         6qTtoXH/G/Frw==
Date:   Fri, 18 Jan 2019 16:33:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: linux-next: Fixes tag needs some work in the cpufreq-arm tree
Message-ID: <20190118163307.03bd6710@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bjEUKAb9lkwEFU/uoNpoNdc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bjEUKAb9lkwEFU/uoNpoNdc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

In commit

  3ca12c96ef5e ("MAINTAINERS: use common indentation")

Fixes tag

  Fixes: 46e2856b8e188949757c9123fd7f9ce36edd1a52

Fixes tags should be in this format:

  Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/bjEUKAb9lkwEFU/uoNpoNdc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxBZRMACgkQAVBC80lX
0Gw0lgf/WP5OBAbTgWyjx2Es9pKXovjKtzKBU0MFCrVHmnUTOX+BzOn9obH9ginW
gsFOi13oVI+m3SEYZevvnjp4mJ0/2KI3M0rwkrJWNticIu3pzXmIcP1lYRI8bRJY
e5KhvKF1dJ5cFwlY/+FGKCtpF+zie6P82wkVmlKGYrDxQWz4f2eJnLht2w0QQ4e9
OHrjfQmnwiXyy1il7WAjJALPPGiu2xyYQJ4PbtUUcLKGWMWQu+Uk/kC426PXJ2Vg
pmOYucrPEGHsMQBIhRqsoUuhM7DYVkv549uTb0RQx9IjCMaMyo3nHKzEnYSJfYNg
a1uOSTfx8WdD7aC3UnEwP/lD2+p2kw==
=+BBN
-----END PGP SIGNATURE-----

--Sig_/bjEUKAb9lkwEFU/uoNpoNdc--
