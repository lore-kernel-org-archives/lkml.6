Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F32FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9D720843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KhNDkYJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9D720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeIDDxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:53:21 -0400
Received: from ozlabs.org ([203.11.71.1]:34001 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbeIDDxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:53:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4245n64C4jz9s47;
        Tue,  4 Sep 2018 09:30:49 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536017450;
        bh=q7gqzUq+pQ7z1JVRxEzs/xVOzFAuWv8P1QFK7USMW+U=;
        h=Date:From:To:Cc:Subject:From;
        b=KhNDkYJ/W0ETRoywpZKgYdHnn2XD4IAxG6tcwAwrnbmPATUUlno8GCltIHVkiSYiy
         yS+82rmsO8gseXWvtI3EPMf5b0WBHIFNauqJG6rFRq3Ln0xpIqsaF33jn6tJxgf8b/
         JP7vlJYTK/kXXduHqg7REVRCKck9CV5/5GndrUQ4zloKUn2Q1iXNore5K/cOFOCWVN
         oedY8tkcfSlg4DdeCM21jO1Obj7D2Xj2y6SvK354KNEsy3r+2f4sJslw+yOnFyYTJo
         DSuDelGQ8d9UpleyY0AkMjnsfrXn4/cs2eUrbduAwKuIc6tvclIOFv1Ls5dutqXXRH
         D7MJrRO2hXK/Q==
Date:   Tue, 4 Sep 2018 09:30:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: error fetching the jc_docs tree
Message-ID: <20180904093049.6e458884@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hxVLvuFQD.c2c.7+JzSPzHv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hxVLvuFQD.c2c.7+JzSPzHv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Fetching the jc_docs tree (git://git.lwn.net/linux.git#docs-next) today
produced this error:

fatal: remote error: access denied or repository not exported: /linux.git

--=20
Cheers,
Stephen Rothwell

--Sig_/hxVLvuFQD.c2c.7+JzSPzHv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluNxCkACgkQAVBC80lX
0Gyo3gf+NA9VvP9vzMVSCS1Mquse9VrVD7E9cBanm+Kt69XPXvWjHqaJo0wWQ6Oo
RklSm0Y9Rnr7NAI3RSFQ9Q36sSz+heLOA5Cbqj8ObRdRdinX+XJkQgKtx3KhsXzV
bryXNhdQ1zdioGTggNoEFQMWd40O4Txxc9pRFsRa1KkJ/f5N2Qsrc4Ts3We/oW4V
dyTvNCgM/Nax1+t6U7bUmi5KwiWmWIwj2GHx7sj14BUh4SF3SCnrL/UaL58cMv4V
aFzg3HX9F6tDySASPMoKE60Gh6WyUxjJuEFkqkgzohorDCnYrBQ2ZN33KjvI7dVK
Xm6BolXCV5K6uYmTGqbfBBzpg8I//w==
=8oOZ
-----END PGP SIGNATURE-----

--Sig_/hxVLvuFQD.c2c.7+JzSPzHv--
