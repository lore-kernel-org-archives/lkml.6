Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B5C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 04:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7EE21870
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 04:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z85Vyl/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7EE21870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeHKHIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 03:08:32 -0400
Received: from ozlabs.org ([203.11.71.1]:57579 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeHKHIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 03:08:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41nTgy1G0tz9s4c;
        Sat, 11 Aug 2018 14:35:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533962142;
        bh=SggvAUw+rvkUeVGdhHwp49uw2d5mLYXEuYMKz/7FvyA=;
        h=Date:From:To:Cc:Subject:From;
        b=Z85Vyl/chp+52mv1+rNcJFNGTH9JQqGPfK+oX9qBcaXIWkm6HDYC699YSi9OWjvkJ
         9dzhcsrElv9kGaQRxa5gsB4v8Z4vm/PHMKeF6sLwzADRQDVJBY8P4n2HFkyfj9J8nA
         9Fajvj+Zpw+9TA7twzUHpFl1i+AMDAvuFQvslcDnVuGHltQUcOwluBxCAHABbbF0hq
         EeBg1dlYT3Oo/FYhRQB+aTuCyQClv4FPe1F5JUpivmkcXcoHsv9Dc4QGBVf9z3scHT
         yM9cUVdFmJptDETjfuZt/ovkkrMuXQMnSVFdiSNGj6hF/vKiDsGpWCH8x5JCOtnKPc
         69y8/kpErwUOg==
Date:   Sat, 11 Aug 2018 14:35:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb tree
Message-ID: <20180811143536.46ceac24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BDS_lyjHP7Vv7fw.bY=dCed"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BDS_lyjHP7Vv7fw.bY=dCed
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Commit

  da2048b7348a ("Revert "media: vivid: shut up warnings due to a non-trivia=
l logic"")

is missing a Signed-off-by from its author and committer.

Reverts are commits, too.

--=20
Cheers,
Stephen Rothwell

--Sig_/BDS_lyjHP7Vv7fw.bY=dCed
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltuZ5gACgkQAVBC80lX
0Gx9YQf+P4c4wlibivB1wkP1A/isq/NLXaddttn8VujWsBJrYSRc9Q1CMH8gdaWZ
jNWEesTgDSfSV9nyYTnw3xOGQ56YDQrq1cohai530/Whc7k+Fdlb/BikqFxAHD7k
vE3mSYllc+3UjWTBEMXaHKS5Uf+nv8HTUiuLhXXXFiiOEsI/OhTansGhHVPtXj+k
av2V+GxykyNbXmNmMPrf/valofSkRRrrIv6KoddjmooYIjz6NsO08DTyJxy10qBS
7A9yQiQg+rYHdDVrQRhJ3bmf6JR8F1mWFz353D1bQEy3ggR2qHSjZJ1MxN9pwPng
LoyAQ+McsFzuLEgMwYYUWGGgSgWK1w==
=4uo2
-----END PGP SIGNATURE-----

--Sig_/BDS_lyjHP7Vv7fw.bY=dCed--
