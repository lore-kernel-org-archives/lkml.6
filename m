Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D514C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C309E20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PfGGMxub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C309E20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeKGF03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:26:29 -0500
Received: from ozlabs.org ([203.11.71.1]:36103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeKGF02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:26:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42qL3n0xqsz9sBk;
        Wed,  7 Nov 2018 06:59:30 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541534374;
        bh=UTkOcBkHrG2ENeLENXNyYVrcfkczTiM++v8JZL85D9k=;
        h=Date:From:To:Cc:Subject:From;
        b=PfGGMxubm1Iv1rAZ98hwCoTdpzUJdEIQqXsGYejjcyjqIubleDW/W8rL8pjIf0JBO
         R5dy6Sfp37rcmUXNUP9JYJ5mLmXaCare9AR0eALyTKdNN2carBt8pAKh/zcPFQ+nGm
         mmOvCHuv0ZtW8R+xS/xncK5OXZcVjjtT0yqFr+ZeXvt0l+eb6QBL7EfjdBpxtUEkVT
         335b31M5vw2N3NuYBrrpMj9C1I8Lyiyy3Gp5txXnwB7fD8R/ywBeehWm4o7YNZlsff
         t9MMEpFfBBQJKBGnsJjaKuaNAs83gXSFkhS3I02N9Ijx4bKO9p0Rvc/DRH46CqKfZS
         nEV5WdBhgZaXg==
Date:   Wed, 7 Nov 2018 06:59:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manasi Navare <manasi.d.navare@intel.com>
Subject: linux-next: Signed-off-by missing for commit in the drm-intel tree
Message-ID: <20181107065929.3ded00a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d..b2aFzeDSBiUS5XZT2LAh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d..b2aFzeDSBiUS5XZT2LAh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  35b876db4a42 ("drm/i915/dsc: Add slice_row_per_frame in DSC PPS programmi=
ng")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/d..b2aFzeDSBiUS5XZT2LAh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvh8qEACgkQAVBC80lX
0GyMcwf/XcMiMFdq+1Rs3gUNPkN+pb6bkC6QnRm7TOZ8NxA77mVRxgO1NHMvf6RD
SyKPlLa5n8WObqDvflObzEpjaLSv8FoSpW7Zxkxwq3yzPPzcQJpI/pjhFU483rb8
B+iZnSVUOgs6CoiOAl4z1B0iNQHDpFLyfYMa1jmqOx0GwI8MDhYEXtrGbs0RErGk
uFqTn75ifFMGPndpnaVQwSuYNjzWRs0Vdrnk1m2Sta9AX+4KP6Nh+ACbX2WxtxZR
Kc2Fle4qL5PlXOsZZxFpQA4aNWxi6vzON2PkCg1oCrkviZB+sfKUa8+KoZWS69T8
lSm+tEspqZ7/HGGp7hf8PLIt77mATQ==
=Po7P
-----END PGP SIGNATURE-----

--Sig_/d..b2aFzeDSBiUS5XZT2LAh--
