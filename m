Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74012C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267C020817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Jy7vvrb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267C020817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeKHOOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:14:21 -0500
Received: from ozlabs.org ([203.11.71.1]:49967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeKHOOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 09:14:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42r9Zd2NZJz9sC7;
        Thu,  8 Nov 2018 15:40:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541652041;
        bh=IKsMkZtE/XDcWycF8+JjzQy7Yuo4zLvqYBtl5S7QQiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jy7vvrb72hHmxA1u8xcX2PUnUFcSbVlKqTo6nS00yf0N3FDHsXCRPJPxx0XF+yctX
         MFW1VHoW8F2Q2rFC5laytM8zoBZrBE+JHBWv7uY7nXl/ZVEYg1Q/rvZl1XB02Xwm6N
         TI070nZOOu84KysFlFLxawwW7lr25iIkw2jRn1KGij58UBGMRPVaEBoAl11vAIywLI
         emNexNuc5H62dA3V91Bjb64UO1STlwf8Z5BpkoQ/pTL5ZB/fAk53/gkkRGCCPmGRY+
         +2Udd3J+DOQ2zGmu06RfrIe7WytmzCbQNfL3r2p0BfuEZAK5GsJWvJtQr1If/p38Om
         wzwztB6F6nUIQ==
Date:   Thu, 8 Nov 2018 15:40:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 4.20-rc1)
Message-ID: <20181108154036.69bc4e0f@canb.auug.org.au>
In-Reply-To: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
References: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CyxnKmrtWcX5cokb8GQEwO7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CyxnKmrtWcX5cokb8GQEwO7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20181019 was the last linux-next before
the merge window opened.)

Commits in v4.20-rc1 (relative to v4.19):          12125
Commits in next-20181019:                          11296
Commits with the same SHA1:                        10466
Commits with the same patch_id:                      526 (1)
Commits with the same subject line:                   56 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20181019:     11048 91%

Some breakdown of the list of extra commits (relative to next-20181019)
in -rc1:

Top ten first word of commit summary:

     86 net
     60 powerpc
     56 perf
     54 media
     36 drm
     33 pci
     32 thermal
     32 bpf
     23 ubifs
     21 selftests

Top ten authors:

     36 hans.verkuil@cisco.com
     28 darrick.wong@oracle.com
     28 acme@redhat.com
     25 dhowells@redhat.com
     24 s.hauer@pengutronix.de
     23 christophe.leroy@c-s.fr
     21 kishon@ti.com
     21 davem@davemloft.net
     21 daniel@iogearbox.net
     21 bvanassche@acm.org

Top ten commiters:

    161 davem@davemloft.net
     72 mpe@ellerman.id.au
     65 acme@redhat.com
     54 mchehab+samsung@kernel.org
     41 edubezval@gmail.com
     33 lorenzo.pieralisi@arm.com
     32 broonie@kernel.org
     31 hch@lst.de
     31 ast@kernel.org
     29 richard@nod.at

There are also 250 commits in next-20181019 that didn't make it into
v4.20-rc1.

Top ten first word of commit summary:

     28 vfs
     21 mm
     18 leaking_addresses
     14 arm
     11 nfc
     10 interconnect
     10 btrfs
      9 xtensa
      7 arm-soc
      6 drm

Top ten authors:

     38 dhowells@redhat.com
     19 akpm@linux-foundation.org
     18 me@tobin.cc
     11 arnd@arndb.de
      9 jcmvbkbc@gmail.com
      9 georgi.djakov@linaro.org
      7 nborisov@suse.com
      6 hannes@cmpxchg.org
      5 wens@csie.org
      5 sfr@canb.auug.org.au

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

     75 sfr@canb.auug.org.au
     40 dhowells@redhat.com
     18 me@tobin.cc
     13 georgi.djakov@linaro.org
     11 sameo@linux.intel.com
     10 dsterba@suse.com
      9 shuah@kernel.org
      9 jcmvbkbc@gmail.com
      7 paulmck@linux.vnet.ibm.com
      7 maxime.ripard@bootlin.com

Those commits by me are from the quilt series (mainly Andrew's mmotm
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/CyxnKmrtWcX5cokb8GQEwO7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvjvkQACgkQAVBC80lX
0Gx0jQf/WVVgd88XcTxwzllA3kRr0jt5GMD/mkg/uXP+nZtiR54Gz2cFTnUdGN2j
2486eMFuK71qFgnfUJfHic7IVNxKq9mxiRN50fU0Vw2lEMlbqzLHqYKdDgKvN7Vv
+uIEWQm4xlkcnmIATnkN24uUAy/8qxV/R6s0Q+VgCTXS4XpOzO2gyFjD/Pe5+X8u
Gcovn5N1STtwDEmzqV/aD+5GNY2uGwxkLhxSed5gKDtGcHbdn7vy/y5gnvAwvFBd
PQtigP6g9DgJOtpQ8K3C8f7fHYhzDpyRfjZMc2HmV9+WmuIVL0dz7s+snRMKQwsb
0Q8ucCRVxo5GIxwrn3BBxNIumH2peA==
=6RZg
-----END PGP SIGNATURE-----

--Sig_/CyxnKmrtWcX5cokb8GQEwO7--
