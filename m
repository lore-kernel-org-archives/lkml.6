Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CA0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC6B218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sfeik/Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfBFW5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:57:06 -0500
Received: from ozlabs.org ([203.11.71.1]:57091 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfBFW5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:57:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vxf74fB3z9sLw;
        Thu,  7 Feb 2019 09:57:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549493823;
        bh=8qE6k2HDtv5kkw4XGROJp22eI5s8WNyWQZFkmL7DtwE=;
        h=Date:From:To:Cc:Subject:From;
        b=sfeik/ZlsNflgpJ2qLCKZzptfd48SNFbHgFni2CvkhEd/aqLEur4kx8GLq13CIklV
         zfLSYe4CAVOValUrde8IPNW7fSK0U8G1L6JxydyfDbpsXgVDFBfdG4fMvN0o4WhAuT
         FAYjezP72U7toT3YlqnOI/kc9GVSLoBrVI+wdOjpqR/WJEEzeJSJNw8qhSE5CSdled
         6O2Ul2MGXboh91MhJTWy9PJ/wTd/NQpXStY8zxvgensikooYp5K0wQ/zWWs3gnTBXp
         sqwKU7CoJX84NVTSXGkNyTspgTnhVluZ7D0eT3v05JOUfz2KAL6wS5Wg/xyvlacL3k
         B7QwwCyagtCYg==
Date:   Thu, 7 Feb 2019 09:57:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the drivers-x86 tree
Message-ID: <20190207095703.564e76b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JrloarUeDi9Ju44Le1giVnh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JrloarUeDi9Ju44Le1giVnh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4284dc008f43 ("platform/x86: intel_pmc_core: Fix file permissions for ltr=
_show")

Fixes tag

  Fixes: 63cde0c16c67 ("platform/x86: intel_pmc_core: Show Latency Toleranc=
e info")

has these problem(s):

  - Target SHA1 does not exist

Did you mean:

  2eb150558bb7 ("platform/x86: intel_pmc_core: Show Latency Tolerance info")

--=20
Cheers,
Stephen Rothwell

--Sig_/JrloarUeDi9Ju44Le1giVnh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbZj8ACgkQAVBC80lX
0GxziAf+OZiiUxf14raDsB9CyenVnSXgLln30g4hqU9cdgCHDsXjNSN1KKevSQ/P
Kd9W26sBqt5KlPZ2mUJ6fWiHtmRi5vv0dvHVavGvgAr380qjIIQvucpKSdqSP2iJ
Yq+x6l9Hxq6VXTocJKATMdTojwnW3KSYu5ENVhYnZJH2K0KTmQOiUDsl5lONwMtN
Eupg3rW/iSyahpG3eB5nPIjBf6B5LwbosRzpbKsBqaQwKZwY+46LYGg/ddSe8A84
GlQaBGY3ZHYjN+V89jPvh7ZlqSSIjSZAlA1CAYm1wl6qsU2ha9yt9Slnt2U+oQ8y
zzPx72gpdpAFPDvMgrJOq7LOz67/vw==
=J3HE
-----END PGP SIGNATURE-----

--Sig_/JrloarUeDi9Ju44Le1giVnh--
