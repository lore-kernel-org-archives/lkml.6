Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90128C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409AB2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M7sGlDM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409AB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeJAHjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:39:19 -0400
Received: from ozlabs.org ([203.11.71.1]:60487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeJAHjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:39:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42NkZB3ntDz9s3C;
        Mon,  1 Oct 2018 11:04:02 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538355842;
        bh=OKK5ZY0WPJwGMF0JXUvU/jSbyuUwWODhE6Chav3fN2A=;
        h=Date:From:To:Cc:Subject:From;
        b=M7sGlDM0JzMqI0SB/JVo0/+zpwlIE/YbT3AkAJNJy48mB/sJEpNZpUGGJp8ZwV0qW
         gW7L6HBcpdYY6SjYo6l3mmN9NrbcZKSl2RpSockpE+VShVxnnUO9iY2na2zavMiylp
         tXcizB5gbk2WnFEAdEKAVUnLblUYM7I5u7wo3EMQz75qRELMKXCjgAwsrfi/02bpLn
         I/FM0ysdpLLymQj4ZiT6ohku/6YfUKtdsYfPh0FN8N/exTGXR8hjlpV9IFo7MELVqg
         n9pIcKXJE/oKPmJ6maA0ThZ9+1CyUpRG6iIYW0/pMv/5+63iKb9Z6Xgtc3USdnXhqI
         oedAXaw2zt3gQ==
Date:   Mon, 1 Oct 2018 11:04:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the parisc-hd tree
Message-ID: <20181001110401.046aa075@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/75A6QhBLrMneuYPivE7KPNd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/75A6QhBLrMneuYPivE7KPNd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f17bbdb5eea2 ("parisc: Remove PTE load and fault check from L2_ptep macro=
")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/75A6QhBLrMneuYPivE7KPNd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluxcoEACgkQAVBC80lX
0Gx07wf/atOF3j4/DKTGL3PsMcgrtLoTQI2qaCbwjfqLMNg/UglIM51SqGvsuLe/
LiuF3u+QWJ/A5xgvIoG6q1Bra+wQcUM20I8gZedWwajGeQn3IXfqZKoLBwDFHOCE
I8qTGnP1jYLXOAeP9kuOqvLmWoJBfIluOicMxcasCZVn+A+eshac1e/UW5Wkqymb
J+AInORTJ5Fhl+C/X5qFpbvemyV6GJhlZULXfO9gKT2ovfTEq/9VSwClzBNO7R32
s0+WPdUNSXJBCECxSE06LFMCTkwHhLBDomSHUVSsy0AfJIvrBpXkK/Mz/og3VrDH
7GCZ33AQvpzQN/Ls5ZytVpbptmozxg==
=VbdX
-----END PGP SIGNATURE-----

--Sig_/75A6QhBLrMneuYPivE7KPNd--
