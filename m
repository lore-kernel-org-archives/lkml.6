Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CBBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BCD219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IkUU4068"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BCD219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeHFE4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:56:25 -0400
Received: from ozlabs.org ([203.11.71.1]:43725 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbeHFE4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:56:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kMYj0VH0z9s3x;
        Mon,  6 Aug 2018 12:49:28 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533523769;
        bh=AYdKY2zDnbWKuJvLFDEoKVyyyP3nKejj7oHYpwfS8R8=;
        h=Date:From:To:Cc:Subject:From;
        b=IkUU4068Fc/q0FPOWtfnOEO81OvtKp+VpiXRkgL/1+/hPOm9Po1GAwAgLbNce9Db0
         Xx4ukxAgPaoZL1ONtPhuRVRbiGoXF8ylO0IjPE1r0JCPFTt3guqCqUyb2hno6G6+dX
         xhVhdIHbzcuArIZ6uNO1F9C+0e9evhaI0N6milAsIhCuXhJBsV4K+my5ORXu9/OOgY
         gza1Jhx+v2kn538wjJB1L3Vdiro3SQzCQuqhTzkRKwfcyG0tMFVXOD1mvBxX/kt4Gw
         wLuc4N/mjNYqf/bgbpBVi8NEyXRDNgnGAj464ntekmFbmCebiGbbVPbr9O5dOt9Dt8
         p4Fguif0yGrOQ==
Date:   Mon, 6 Aug 2018 12:49:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Simon Horman <horms@verge.net.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: please clean up the ipvs-next tree
Message-ID: <20180806124928.43db0f44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=Xi+6Of27sVPWJluIZD4Iz1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=Xi+6Of27sVPWJluIZD4Iz1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

The ipvs-next tree appears to contain a set of patches that have been
merged into the net-next tree as different commits (some of them
slightly different). This is just causing conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/=Xi+6Of27sVPWJluIZD4Iz1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltntzgACgkQAVBC80lX
0GyLfQf/dOcTGpBeBZvfq0XaqiTGDlJtHilHghE+JKOddWVoz988bWlc0LNJg2kQ
h2lKrtFJaOJfw18o5JcLnJa6SBZStmC/T2sxtMIlVxv4ydvc3kuWXXzT/edEOoxB
h/0eGbkwAXWfGBWilElt5bM/AnA2oOaQESSYWMYxRqn87z8CBGahgHKOPTjzkqWq
r1eaGaKCOv0swWO/qz/ISAPr2Z/8kyf/OpRipjK9oifG7xwBf3eyCzmepnIEEnZQ
CAbRhtl22YnMS1YVYlouReff0EyCJ6F661NJyrzsQo7yKSi18mneuwCKPc1dkwaR
Vq/X4TNc4pCzx2HyWVGcYm3ciScU0Q==
=jhmU
-----END PGP SIGNATURE-----

--Sig_/=Xi+6Of27sVPWJluIZD4Iz1--
