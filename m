Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F001C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4312145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VJVvVpQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBJUk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:40:58 -0500
Received: from ozlabs.org ([203.11.71.1]:47481 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbfBJUk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:40:57 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yLRC0wqWz9sBZ;
        Mon, 11 Feb 2019 07:40:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549831255;
        bh=No91YQzFyWh2acf4eFSEtrKIYDdiOoH+Pp+6THtf02w=;
        h=Date:From:To:Cc:Subject:From;
        b=VJVvVpQS1RRbILvGn7YXjN8LWtT8LmtnVGAnIgCD8tE3l38rx02RnbYwJ9zQtVL/B
         MfxwlPsqcc6qyS10tWngFEuAXTAkQHBPV8os5Vr0mHHRgng/nBw6EnqmoRcUoTI2jT
         woLf5WHFqQ5LhzDqVnlFOQHAoO3KsIcakxcxoqzy5sEgx720kf7QL4c/97R0xHtgKJ
         /z5AgN/s/vTDNSw3FO4TU3C25/wg4XOhAg6zLdTCjTq37C33DvqbwLiccaQqtZjej8
         OSkg7mNIZ/EmuXO1piJfyc2EWip53b/xER7hpzHnidQD0hURrLaOgXFVUI706SKzqH
         ZB6S1xmUBqncg==
Date:   Mon, 11 Feb 2019 07:40:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: linux-next: Fixes tag needs some work in the driver-core tree
Message-ID: <20190211074052.2407f1e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ps1P.gUG60/254K9ykgcdjL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ps1P.gUG60/254K9ykgcdjL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

In commit

  344c0152d878 ("selftests: firmware: fix verify_reqs() return value")

Fixes tag

  Fixes: a6a9be9270c87 ("selftests: firmware: return Kselftest Skip code fo=
r for skipped tests")

has these problem(s):

  - Subject does not match target commit subject

--=20
Cheers,
Stephen Rothwell

--Sig_/ps1P.gUG60/254K9ykgcdjL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxgjFQACgkQAVBC80lX
0Gz+nAf8D4fIP6zBxOZsEomgnMm+/a2i+lwePkI4DfK1ATEr289BUhzCXrsrtE8B
nXwkqE6Lpxj2i1EOPUnN9ulcblAQ1vzeHa7LzVxjBTsJ+cEbCT32AinRTDKE5prU
842GLxKelU514N5gVgvjOQBQrfGuJWwM64JTLzI24SqoyqS9F2otJ68dEPT6lR3J
8AgiuT+fICcTSctQnJFTFZk8TNEGxnHdQEW9HkmU4GRFnD0sX7E/A0+6ftFXmf5m
J0Fck+ZpQtUNI7bKAQA0v6vxBcDwpdlhXjWE0QS+yx7wV2jT4n/ngi0aLLn/ARUW
HU7K33E5ISCV6x4OS/vdiw72FgGlkQ==
=Kjc7
-----END PGP SIGNATURE-----

--Sig_/ps1P.gUG60/254K9ykgcdjL--
