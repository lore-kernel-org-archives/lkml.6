Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90C1C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7DC20815
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qIg0eRHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfA0DtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 22:49:22 -0500
Received: from ozlabs.org ([203.11.71.1]:39345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfA0DtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 22:49:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43nJfR1dT2z9sDK;
        Sun, 27 Jan 2019 14:49:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548560959;
        bh=4OpDEHHFS12k7D1xdqbVG0MrpBQDS1p1Q1eDkfBDmRw=;
        h=Date:From:To:Cc:Subject:From;
        b=qIg0eRHNudXGXPGvCzvVY27K8tI5k5oGvoDfdhAkkKFTChy9zqbr3FoEH/h0ESCao
         Qpzwwqb6JQiMopmUlBj32KanbFhfYEPfqpZdym6dFKwh3VC/NP1eGDNMXmifWpuyNk
         +GvpXQp3mhRF6E2BrVJbDhTWSU5ucjkDc1LkVj1TfXjCBkmIN6V/y0eIAOo3PMxrdQ
         reddxgRwMVg2M8hA5zKP/loT/iKHjqmfWHdmPsw136M64Hw9sjm/JGroeKIWi8jdA8
         KbHCR3xTQvontR6dHsuNTpvlqcYcleunCwaZJKoYP+JtRCld57PniZtwc0kksjSiA+
         ReSISzfpjdulQ==
Date:   Sun, 27 Jan 2019 14:49:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: Signed-off-by missing for commit in the drm-intel tree
Message-ID: <20190127144918.50773338@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1nFSP.qQ8zxV2y4L=nnwopC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1nFSP.qQ8zxV2y4L=nnwopC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8e525cb4a622 ("drm/i915/execlists: Move RPCS setup to context pin")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/1nFSP.qQ8zxV2y4L=nnwopC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxNKj4ACgkQAVBC80lX
0GwWyAf/e/nbpVBkllkm29g+ZSNaoWNfYr5W67vWjPX4ndpjSs7J15O/IYqLcKM3
q+SCOzyODVfmHxJVK6KfO/Y/WMcyuLeVt6FfgUH7Ttw6M1n0tMEieX6BS/ElRPXY
9OOD1NcPtFGoOJ+LKqIKkY8MUs7ztWo3pXLJ1WkSueIGfPMMkpk+2k6Zl8zzUMKt
teEP5GjIViApkBgiP5JBggN3v6oe/2N75kxCh0CiUpgI9XyZV0h+cQSgG/3AanPR
+i7gx+h4Qx+Jmjr5iNGA6RTtDmbfPS5vUUeZzAhPvPMc2TomuA5kA+c+qawcTD6x
ktq+f2ShOJ+fNIBnHw/HavWumF5G+A==
=H65w
-----END PGP SIGNATURE-----

--Sig_/1nFSP.qQ8zxV2y4L=nnwopC--
