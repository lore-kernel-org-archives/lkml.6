Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D86C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7092E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pFwEJmqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7092E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeIDGLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:11:48 -0400
Received: from ozlabs.org ([203.11.71.1]:57655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeIDGLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:11:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4248rW51PDz9s3Z;
        Tue,  4 Sep 2018 11:48:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536025739;
        bh=nQFeSLs8ZmIPycboG5ZmHs3bUQl5KhVcelZP1+St+ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pFwEJmqLYmUBUX8JXZOlgXshv7ZH9hbnzgvjqS+1G6fZhjIRXAAgPSPW7i+1qrU9g
         DGHL9pTJPnFEcelWMDt4GC/dRpHWiS+v3CsfKfEsWrHpmhgs5jB9LTBaOxXuvoXfyg
         2oEnYPUf5ZGtA6aET2RU5VQUwehxEFCacYNTaHv9ZZyTWB7zOJmKvy1hFaSaTVj2ta
         NCHTrSksGMUALEtv83uCVRQzXROnbtOjGgP0S7JzDGr4GIF4++oMo7RCGCswxih2wm
         g2AlyXF3A1vZCqk3oPz+LErJR8O3peDJjnmXhONyRoJ6RiazmcoX2KNPghtiUUW6fD
         rKmHQj81XqN1w==
Date:   Tue, 4 Sep 2018 11:48:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: error fetching the jc_docs tree
Message-ID: <20180904114857.355920d2@canb.auug.org.au>
In-Reply-To: <20180903180640.607094ba@lwn.net>
References: <20180904093049.6e458884@canb.auug.org.au>
        <20180903180640.607094ba@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lbFxVlhD5d37Gk326rkYEXl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lbFxVlhD5d37Gk326rkYEXl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Mon, 3 Sep 2018 18:06:40 -0600 Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 4 Sep 2018 09:30:49 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > Fetching the jc_docs tree (git://git.lwn.net/linux.git#docs-next) today
> > produced this error:
> >=20
> > fatal: remote error: access denied or repository not exported: /linux.g=
it =20
>=20
> Funny what happens when you switch to a new server...all should be fixed
> now.  Sorry for the trouble,

Indeed, no worries and thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/lbFxVlhD5d37Gk326rkYEXl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluN5IkACgkQAVBC80lX
0GxVBwf/UHWCtwGsBDf6WsbQ4bFiRtGiiSWqXd3J2geF+BCrY7vW9YUe9++Of366
NSS41PEydn4YbWBPqUNIK+V7lEBqoc+YalZeKmvYWLvD5lVCb0i7LfVAmaKyPSHG
2qMDGxRpRTsDAxCF/mB/nxfd6qD5mVmnN2vrZsNawysyGVgfV9JJNE5XnCX5X+UG
jYgo5m6Q+pbRRWbrANoGtBiZlm8KRwOQozgNH/448SUbYf2rCEsIw8dhfgpBYtSr
WySwpjUAQcutQi8Nyr1JGXCCQZtvhZBHLWoufonY2tBJ64uB8OJQqSRkDzoej7c4
nOPY6MFVu8URvi/OW4dXXgde9AXPNw==
=ufvj
-----END PGP SIGNATURE-----

--Sig_/lbFxVlhD5d37Gk326rkYEXl--
