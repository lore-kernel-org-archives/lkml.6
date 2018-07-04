Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00676C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBB724248
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lEifMGHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBB724248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeGDVzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:55:48 -0400
Received: from ozlabs.org ([203.11.71.1]:47097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbeGDVzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:55:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LZYY116Zz9s2R;
        Thu,  5 Jul 2018 07:55:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530741345;
        bh=JbR7rIAXdmnGe9eCvNSQ71gO03l8PahLxdwPyHR1A+Q=;
        h=Date:From:To:Cc:Subject:From;
        b=lEifMGHrX+DHlTiwb4qjKchEp1vNOJC2VMP4LSbS+pFnjbiDwwOzXVXkkjkmrsoO/
         NEs/Us5yNWh+0dIr0c6+7Abm8cWshXMg+zbZHTw7HYTSMrRJuzzzrFmJjKCylVou9C
         DDxi/GYLwC+weAaCWVtLHIWriyWuZluA8hd6uqi8zXoVft9YXWkdJUwPDG+KSIHD4h
         A+chHIEYQsjYnbvsGHlFFDQ5b1ukC8kgfcHbOeakwsLn3yNtA6/ZmkDep0dH6YK57Y
         qHsOYns5EXjJpmwKJ16qTAGimMZql2jBuJE3DtmOwJjoqbP/tOpiSOaGPQejNSiQ0y
         /QI+MqQcoNJ6Q==
Date:   Thu, 5 Jul 2018 07:55:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the gfs2 tree
Message-ID: <20180705075544.70f2eacf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yct1U=Wvbk+RW6YAmS.lLq1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yct1U=Wvbk+RW6YAmS.lLq1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  0627518adcc8 ("GFS2: rgrp free blocks used incorrectly")
  b30cbec54def ("gfs2: Don't reject a supposedly full bitmap if we have blo=
cks reserved")

are missing a Signed-off-by from their committer.

Not updated in the rebase.

--=20
Cheers,
Stephen Rothwell

--Sig_/yct1U=Wvbk+RW6YAmS.lLq1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls9QmAACgkQAVBC80lX
0Gw3PQf9Gr5mS5Lq1UUvALhz9Z5YKJc8dH5MC120a4BKyIZsq0yWNC5Zt2i5hvml
zA3y+8MH5wbUfYeHJKrgdkQvKEQDpeamfF2rH5VVRZ43j5TvUYxOsaYxVoTVldaD
LLev/ZQnjLKgIZ5JEwd2V6VIIy96VvhVa7IpM5tHpcrRG249Q24D4/fVfSthLjR3
DuMtCKjOykArpWU27ZeIEvwQpQwjBFnonYilkCjZ45rft4jGBPhLsOIXFbigHakm
daZ913YBFpv7AZ6xJrVCrxvl1t5jT5Cla5oM0WRmYpAsDXa+u51SJsyV7cwmo/0a
RevErlFD89st4ua/D64CtaEXrDgDdA==
=Uoi7
-----END PGP SIGNATURE-----

--Sig_/yct1U=Wvbk+RW6YAmS.lLq1--
