Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DEAC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D5B2088E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bTuYzVXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D5B2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeFQCe6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:34:58 -0400
Received: from ozlabs.org ([203.11.71.1]:49157 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932598AbeFQCe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:34:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 417dbz23Txz9s0W;
        Sun, 17 Jun 2018 12:34:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529202895;
        bh=FPhzXRuqlBbdSX1YUyIheV8qofMrDqUW+UMDwH/5Qak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bTuYzVXjepZAfr72h8gsVaS95gPa3mjaNU+Qi84G6/7KnbMTAsMGXrId8xDAjNKO8
         8lFsLdbVDjpQlsOPujqpkrNvExoKvm87umV3UrxLttFtVYzL+5twVsyVXtMZVmOatN
         bRk/PuQgbstYF750Q7/2MvRj53r9/4VYXkT9fjkLoYMEwZD651cuLSUYc7WVBZFsMj
         dPIY2bCov/EuzAdULTDx8o9dzzMfhu346L+rysMmF6uDtyUCCpmBY5ghHbNjVFs899
         aJORgXJ6FCCZVknS5wKC9OIdJm7rsKNMEOC/ciAWoSqC12Ar5qW26e23mQhXCwHFq8
         AN/TGRy1d/22g==
Date:   Sun, 17 Jun 2018 12:34:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 4.18-rc1)
Message-ID: <20180617123454.155ca9ce@canb.auug.org.au>
In-Reply-To: <CA+55aFw34Dh6p0qAZ_Ja=fjuJ89ojZZTWtmrRPKmB1QuP3C7hw@mail.gmail.com>
References: <CA+55aFw34Dh6p0qAZ_Ja=fjuJ89ojZZTWtmrRPKmB1QuP3C7hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NjJj_VEbnNQWFlMJJdBVzBF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NjJj_VEbnNQWFlMJJdBVzBF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20180604 was the first linux-next after
the merge window opened.)

Commits in v4.18-rc1 (relative to v4.17):          11594
Commits in next-20180604:                          10962
Commits with the same SHA1:                        10324
Commits with the same patch_id:                      168 (1)
Commits with the same subject line:                   38 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20180604:     10530 90%

Some breakdown of the list of extra commits (relative to next-20180604)
in -rc1:

Top ten first word of commit summary:

     61 f2fs
     54 perf
     54 net
     53 drm
     30 xfs
     23 ib
     22 netfilter
     22 kvm
     19 rdma
     18 treewide

Top ten authors:

     38 acme@redhat.com
     37 yuchao0@huawei.com
     28 keescook@chromium.org
     26 mchehab+samsung@kernel.org
     21 chuck.lever@oracle.com
     20 arnd@arndb.de
     16 rostedt@goodmis.org
     15 darrick.wong@oracle.com
     14 trond.myklebust@hammerspace.com
     14 fred.isaman@gmail.com

Top ten commiters:

    146 davem@davemloft.net
     67 jaegeuk@kernel.org
     54 acme@redhat.com
     47 alexander.deucher@amd.com
     40 trond.myklebust@hammerspace.com
     39 tglx@linutronix.de
     38 torvalds@linux-foundation.org
     38 keescook@chromium.org
     34 mchehab+samsung@kernel.org
     31 idryomov@gmail.com

There are also 432 commits in next-20180604 that didn't make it into
v4.18-rc1.

Top ten first word of commit summary:

     82 rcu
     46 ovl
     36 mm
     24 arm
     22 coresight
     18 nds32
     18 leaking_addresses
     12 vfs
     12 revert
     10 drm

Top ten authors:

     90 paulmck@linux.vnet.ibm.com
     39 mszeredi@redhat.com
     28 vgoyal@redhat.com
     21 akpm@linux-foundation.org
     18 me@tobin.cc
     16 dan.j.williams@intel.com
     13 guro@fb.com
     12 greentime@andestech.com
     11 suzuki.poulose@arm.com
     11 olof@lixom.net

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

    104 paulmck@linux.vnet.ibm.com
     87 sfr@canb.auug.org.au
     67 mszeredi@redhat.com
     23 mathieu.poirier@linaro.org
     18 me@tobin.cc
     18 greentime@andestech.com
     14 maxime.ripard@bootlin.com
     11 olof@lixom.net
     11 dan.j.williams@intel.com
      7 p.zabel@pengutronix.de

Those commits by me are from the quilt series (mainly Andrew's mmotm
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/NjJj_VEbnNQWFlMJJdBVzBF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlslyM4ACgkQAVBC80lX
0Gzj/Af/b5B1jhMgTwpjb7UTP6SAS7V7uYiaFPwjs1ejySmvSIVSY+fEyf7ZG6jE
3qmzWlDCei5On2RqFfUJrCiiXfdbKoG60w1ReeNZ9cgX7piAAxh78DlwIkMmcWjT
Qc9hD2q6Z3jZZPgO8jBKs8+THeSaDUcXGAKruudQ/7a+RZOlb3lOn30gyuxCYPPG
RQzulurWihbo1iKJ9qsKCPA060E7msTsHIhwdLgEEUjwVcEkLIP+zCEpaHDvK2Ew
hcUDM7bA8avceAuOfdXv5bomw6kHX76aJFGD4XG4FZ045mzao3eZauiaaiGGJVAF
8d/OfQ81sSxfJd5LcAwvkvWyO+59Ew==
=Qi6b
-----END PGP SIGNATURE-----

--Sig_/NjJj_VEbnNQWFlMJJdBVzBF--
