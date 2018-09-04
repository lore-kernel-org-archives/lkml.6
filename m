Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD984C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B4620836
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B4620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIDWHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:07:33 -0400
Received: from anholt.net ([50.246.234.109]:40688 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeIDWHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:07:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8968010A18B7;
        Tue,  4 Sep 2018 10:41:25 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id vsyXNbLumygJ; Tue,  4 Sep 2018 10:41:24 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5CB7C10A01FF;
        Tue,  4 Sep 2018 10:41:24 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id DAE3D2FE1B3C; Tue,  4 Sep 2018 10:41:23 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: error when fetching the bcm2835 tree
In-Reply-To: <20180828074200.440fb5ca@canb.auug.org.au>
References: <20180828074200.440fb5ca@canb.auug.org.au>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 04 Sep 2018 10:41:22 -0700
Message-ID: <87wos1gny5.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> [ Unknown signature status ]
> Hi Eric,
>
> Fetching the bcm2835 tree (git://github.com/anholt/linux.git#for-next)
> produces this error:
>
> fatal: Couldn't find remote ref refs/heads/for-next

I'd passed responsibility for the git tree off to Stefan while I'm
mostly-unavailable due to new baby.  Maybe Stefan had deleted the branch
for a bit?

Stefan -- the for-next branch is what linux-next pulls in, and I was
regenerating it whenever I pushed -next branches.  You can find one set
of scripts for helping generate a for-next branch at
git://git.kernel.org/pub/scm/linux/kernel/git/tegra/maint-scripts.git

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAluOw8IACgkQtdYpNtH8
nuifUA/+KUqbSmr1eyohjjAxRZeeNQwscCYbHxCGp2g2oplwt+73/zTEEHyf7Z8b
+UgcHhCbjh8jakNJe3jRPRbjgAH6Xq8gomq9Ow3TYoeAxm6JVNEtxWm10kSPAYle
l29E2GG7iKM529TGYsOVG2AgDFm8GnSrh4JfgP1cfXGuAu03W3Li3vmQuJPVKmGq
1knwZRYhSbFdOUA7d9H4/6xxuopTKM2iO3JZea12kfJTNK91KTWRbLyzIGjzeHSk
INNWlIb0HISDDNUdt7OH72tlTGIDtUxYrM1+T5kcoZH3lsPeYCFR/0EsINwiLDTO
it/7vnDJNsZ/krsHdAr9BugFyx4Q1oFFViJPwLgmr6bFAq9qoTs3jGllZCQ5CwZk
bBkJ/iOyFMc9Jj4y8j8SL98hvjZjYXD9aBvx5um9SQH44GmKCFf6FNBdl5VgV7x5
ZP7YOlW0+V+Y51/1K6gEHSuw9xOhe686mYpbRtymzMoRYBIux/Q+wxddGSuNNt1z
iy9Pw5BVb7nUtLypxBOIg4pyTuU/gauBV/YqNOlW+vd0HLM9556WN0c9PdAFC0ib
GRebzpmBExj2rt/V1RFV/6OnHk+uUCLfE47puD91y787iIi6SoQf9YQvHKxofrhV
gXcLWVE9lBfn/fDL/l35xPW+zs5IxuJ8lJcueZQ9bHgFOkG92QM=
=8Gz9
-----END PGP SIGNATURE-----
--=-=-=--
