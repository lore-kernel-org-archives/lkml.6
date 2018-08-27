Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7146C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1A1208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="te54GxOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1A1208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeH1BJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:09:05 -0400
Received: from ozlabs.org ([203.11.71.1]:51869 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbeH1BJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:09:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41zlD86n1hz9s47;
        Tue, 28 Aug 2018 07:20:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535404841;
        bh=4sy0bfRksGOgF36IkK0eV4WTRnd7Nn4tPdiqfeflaII=;
        h=Date:From:To:Cc:Subject:From;
        b=te54GxOzwAVtEFEO9LFxvCMSuB5moB3cs0bODowzdiaAFbN+KKTlyDpZho+Ef+ut9
         13XoiXlLE4meE98pDvsTv+f9ruwW8xRux7eCp0n9EyY6egq5MUEortVkA5mrauOGNg
         BgbomgWH9t0JzrBosOU0sfwwGqrToi68jzTPx2Bhpi2gf/r0cjo3cKsXYVVY7PZw88
         k4os5FF08JLwpxjkzytzqUSZsDEPUT2O8gQVWVioBZTjHdNpoZaf9gF5R8nfrU+qRq
         KekQK3gJBpSlAMIR0V/lp18WjfMnoyQJRslCAMVld+vSAFb3F8PT2svNNgM2RmAsYs
         purNO1o7AYzLA==
Date:   Tue, 28 Aug 2018 07:20:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: new maintainer/tree for the libata tree?
Message-ID: <20180828071944.02b13db4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VmQs+8Pux3ZsG4KkS.rXJ3o"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VmQs+8Pux3ZsG4KkS.rXJ3o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tejun, Jens,

I noticed the maintaership change - so what shuld I sues for linux-next,
now?

I currently have

git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git#for-next

--=20
Cheers,
Stephen Rothwell

--Sig_/VmQs+8Pux3ZsG4KkS.rXJ3o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluEayIACgkQAVBC80lX
0GxfRAf+PSx2eC9NqOtd5PiaSlFuCu0SuSOdRGFt84tor0LQZKOLjQdY0fily4CO
mQCDQHeEAYS7TTG1qqX/d4PqgDaA0X9F23sjubGrN59R+0wWGmnZ3oUvU7bJbDqS
02Ufm/RSX760U47ItTONohT6ZDEo3VTDk45eggqLtc5TTWVhr0fZrpvdGonboeqJ
YebPsUSb2mi48pvuR6f2DFLQtq4V8qsepc2lsPdh2i/bdRwRG6l16BzpLAGnzAHu
4+h3FhBXCUYVQt2ASiu2WHRZjCabi9eB0eCbiKYbkYk/jzQ5US1MUqxq1J9oQf0T
aPJQjjquDp3ofE9T7i6ggevraCpPNg==
=hGJ7
-----END PGP SIGNATURE-----

--Sig_/VmQs+8Pux3ZsG4KkS.rXJ3o--
