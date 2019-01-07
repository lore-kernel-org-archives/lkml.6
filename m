Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA5120854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 05:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Euj1/WhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfAGFH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 00:07:59 -0500
Received: from ozlabs.org ([203.11.71.1]:53625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbfAGFH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 00:07:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Y3LP13Rxz9s7h;
        Mon,  7 Jan 2019 16:07:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546837677;
        bh=JffPQ/rOjzbh2JD9wtW7rHVD0NiHw1drk+0QBYzxUho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Euj1/WhUETx+BHjdv/tO4v8cUe+IonLyGiv+uh13XO/EyBcdf0in2Tmsd/HAAjHN/
         KPw+w2xdD/QfW6sUrCUSP/1ohR+abm484JI3bKr6Irh86Sh63+s9bN8kO8Uqaw4v/f
         rbDlxcako0NmTQeCrQa+kR2a2YEXjYN+LopXAdZsOycxetaWXoBdznKvG/NTU1fBQv
         1W12AGcEKj/odvNab5giFYddTENE/mN5FvqQ6yZ2YgkyaCC2UcxP1uN09cVRGpInOH
         Q2YiMzLeRxv3rtkRjTz0cC2cFHsTz0QZOH0X/01TZwy6uEN23pV/zj5QVmz/bxrgea
         YcKMiI0FZHSOQ==
Date:   Mon, 7 Jan 2019 16:07:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: linux-next: stats (was: Linux 5.0-rc1)
Message-ID: <20190107160756.7c502d5a@canb.auug.org.au>
In-Reply-To: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sRwQE_xvWYXLlcmtQywe79C"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sRwQE_xvWYXLlcmtQywe79C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20181224 was the last linux-next before
the merge window opened.)

Commits in v5.0-rc1 (relative to v4.20):           10843
Commits in next-20181224:                          10867
Commits with the same SHA1:                        10044
Commits with the same patch_id:                      301 (1)
Commits with the same subject line:                   52 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20181224:     10397 95%

Some breakdown of the list of extra commits (relative to next-20181224)
in -rc1:

Top ten first word of commit summary:

     49 drm
     26 cifs
     24 perf
     19 net
     16 um
     16 thermal
     16 dt-bindings
     16 csky
     11 arm64
      9 pci

Top ten authors:

     20 yamada.masahiro@socionext.com
     15 ren_guo@c-sky.com
     12 torvalds@linux-foundation.org
     12 palcantara@suse.de
     11 anton.ivanov@cambridgegreys.com
     11 acme@redhat.com
     10 vvs@virtuozzo.com
     10 hch@lst.de
      9 julia.lawall@lip6.fr
      9 daniel@iogearbox.net

Top ten commiters:

     51 davem@davemloft.net
     46 alexander.deucher@amd.com
     29 acme@redhat.com
     28 stfrench@microsoft.com
     23 torvalds@linux-foundation.org
     22 edubezval@gmail.com
     19 yamada.masahiro@socionext.com
     19 ren_guo@c-sky.com
     17 richard@nod.at
     14 axboe@kernel.dk

There are also 470 commits in next-20181224 that didn't make it into
v5.0-rc1.

Top ten first word of commit summary:

     43 asoc
     37 mm
     23 mfd
     23 arm
     19 vfs
     18 leaking_addresses
     15 xtensa
     13 nios2
     11 nfc
     11 dt-bindings

Top ten authors:

     34 dhowells@redhat.com
     32 akpm@linux-foundation.org
     18 me@tobin.cc
     17 kuninori.morimoto.gx@renesas.com
     13 olof@lixom.net
     13 jcmvbkbc@gmail.com
     13 ebiggers@google.com
     11 npiggin@gmail.com
     10 david@redhat.com
      9 dan.carpenter@oracle.com

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

    125 sfr@canb.auug.org.au
     45 broonie@kernel.org
     36 dhowells@redhat.com
     26 lee.jones@linaro.org
     25 tytso@mit.edu
     18 me@tobin.cc
     16 jcmvbkbc@gmail.com
     13 p.zabel@pengutronix.de
     13 olof@lixom.net
     13 ley.foon.tan@intel.com

Those commits by me are from the quilt series (mainly Andrew's mmotm
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/sRwQE_xvWYXLlcmtQywe79C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwy3qwACgkQAVBC80lX
0GydrAf/btcOOjZ86MOF2kvNM35pNviwhHoIPK2/3XTU0IxhDmtlovQ8Zb/NQsFF
D++cfUztxaHDbLFt7UfSLk5JOOnkEGnsZwvMC4bFgMzdM1rfe/yZ702C2jTr7+/0
1+JSHKPcWMtYIrbzFVFfPYC1CoMv0T1MakMOB3BKicwYUl5TnAhF/H7plRQNkkxh
plK6eBGq7Ml66OiHnCJwl1EdOohrI0cCBbduPeuTLpoN8O7lcd1KOjmECFP2JD90
W1Du7Qi9yhSeWcrOs5IhJwMFPSt6N8Sg2xYlC5EF74hhqZl4ZIDhPB+9th7oaVbp
FNj0az9dR+OWlEiqIMNW60evVKzfHA==
=3jim
-----END PGP SIGNATURE-----

--Sig_/sRwQE_xvWYXLlcmtQywe79C--
