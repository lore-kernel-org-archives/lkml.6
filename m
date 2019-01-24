Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E02BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BEF20811
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bDM7VZft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbfAXLJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:09:59 -0500
Received: from ozlabs.org ([203.11.71.1]:49987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfAXLJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:09:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lfZC28LKz9s9G;
        Thu, 24 Jan 2019 22:09:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548328196;
        bh=jb3/YhWkIRxp9+nQz5MMm0puhIeGEhSvt+q5UejuPgM=;
        h=Date:From:To:Cc:Subject:From;
        b=bDM7VZftfFBpqvkV+xRzNhxku8iLqNgXYvr1kmrgaa+n0VDUu6M0hXdOVAdjvj+iD
         xrB1brh1Zoe62U1y3w34KSL9SZd2bcS9aZvKsQTN40UgDp643WOq8wbNSdrDvZXYO0
         g72vxH21YpPzqvPaPsmfgeqcoQDpeOUzji3zg2mYveZHS9bFErgM0SMhP/lNIY2Sb/
         ea0jLenZQI0qN0SFj0vdtXiC5qNh3kwkgyw3U8og+drwz66sex4kkDzNWDLWDRkWID
         W+RpDK8795QuaiJDPHU0vvJUvs4IfoZ6zfFFtiopkfFe7BazJ84tsNI3ID7dC7iX7M
         xAM8hfr3NKRFA==
Date:   Thu, 24 Jan 2019 22:09:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: linux-next: Fixes tag needs some work in the input-current tree
Message-ID: <20190124220954.2147f1da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0inBpMCXdbZb.4K1MiJ=/7M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0inBpMCXdbZb.4K1MiJ=/7M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

In commit

  ec87da107d11 ("Input: olpc_apsp - assign priv->dev earlier")

Fixes tag

  Fixes: commit af518342effd ("Input: olpc_apsp - check FIFO status on open=
(), not probe()")

has these problem(s):

  - No SHA1 recognised

The "commit" at the start of the tag value was unexpected.

--=20
Cheers,
Stephen Rothwell

--Sig_/0inBpMCXdbZb.4K1MiJ=/7M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxJnQIACgkQAVBC80lX
0Gy3wAf/VXbFqCqycCQnS/MsDgCGYSxbx1Pwb3FXwv6SOCwqQdroCiayj01EzpmR
h0PiRHjHXAN4BfEyuxCgbnQ9G6fRIgZWIquHEflqvhdnpy4Gy8l6DlOC2x5GPoCI
NsF5DrmcYPstEpkgozZVNVuxdckc45m5IZRlRDYjGvMHLCsJ5CPuEjlLLQj3DWxt
LKoMYMQyik6wlkWOo1/DAyfzF12IlvBqzNvyN7NJ6mGI7mTYf5p78XxBOLc+DGUN
BrIrl3Dc77TNxSfuJRYaCca/JSyEtrixVbM8agbIAoQ4/n5M+GQIlM5tZXql38bP
3PAyGgdq6lmkpKW7CPVdFiM+ocgiYQ==
=aN4J
-----END PGP SIGNATURE-----

--Sig_/0inBpMCXdbZb.4K1MiJ=/7M--
