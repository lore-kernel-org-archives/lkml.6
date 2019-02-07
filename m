Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF43EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEB62080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="meojyJGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBGLpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:45:51 -0500
Received: from ozlabs.org ([203.11.71.1]:53479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfBGLpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:45:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wGj71Hy5z9s7h;
        Thu,  7 Feb 2019 22:45:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549539947;
        bh=P9LUtkTDZkoyCQ+IWmhAONy5i1RAK1rZjOqTETyLytk=;
        h=Date:From:To:Cc:Subject:From;
        b=meojyJGyXEJ45e5YRh6iz6JhFT5mAkS+ZBW8a9TzFLBYeRacWOPH78xolwET/Q/aV
         e/rHqPhkvOOlSyzjuB3+E98uNr1J+kwS7N37CxmmxE1OcV+pQVMPONwBkVgILz1vX7
         qvHP9sUf9Boisr4eveMq2B+BHJgO45N0z2xCJ2GwJOIYnjc5FktgmX3vKUMxKayO1s
         ywkt0xMaXBEPL3BdR9I4DbLnGu/TWDhvPZPNP2Zd5Wn0xEu3JNHcnWrSqeGM2rwcfZ
         z5/cLLc1J4cDyYdZGc5RMfJRpeakBI8XmVx7jXA9yqZxYa5pUJ7JFeO8WxrR14ZHjK
         Q148mF/KOftxQ==
Date:   Thu, 7 Feb 2019 22:45:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: Fixes tags need some work in the drm-fixes tree
Message-ID: <20190207224539.52b5e209@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XbE+LumaCv.tsn1t1Jv3L5C"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XbE+LumaCv.tsn1t1Jv3L5C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4cbfa1e6c09e ("drm/vmwgfx: Fix setting of dma masks")

Fixes tag

  Fixes: 0d00c488f3de: ("drm/vmwgfx: Fix the driver for large dma addresses=
")

has these problem(s):

  - ':' unexpected after SHA1

In commit

  479d59026fe4 ("drm/vmwgfx: Also check for crtc status while checking for =
DU active")

Fixes tag

  Fixes: 9da6e26c0aae: ("drm/vmwgfx: Fix a layout race condition")

has these problem(s):

  - ':' unexpected after SHA1

In commit

  51fdbeb4ca1a ("drm/vmwgfx: Fix an uninitialized fence handle value")

Fixes tag

  Fixes: 2724b2d54cda: ("drm/vmwgfx: Use new validation interface for the m=
odesetting code v2")

has these problem(s):

  - ':' unexpected after SHA1

In commit

  728354c005c3 ("drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_=
user")

Fixes tag

  Fixes: ae2a104058e2: ("vmwgfx: Implement fence objects")

has these problem(s):

  - ':' unexpected after SHA1

In commit

  2b3cd6249b14 ("drm/vmwgfx: fix the check when to use dma_alloc_coherent")

Fixes tags

  Fixes: 55897af630 ("dma-direct: merge swiotlb_dma_ops into the dma_direct=
 code")
  Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")

have these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/XbE+LumaCv.tsn1t1Jv3L5C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxcGmMACgkQAVBC80lX
0GzMbwf9Eqn6EMPk90DAYlTKjiETaUj5FekiVfWV6sb9N05gB3oAjzMYrlS7nRkB
yd+q75RAJ4HPNeV17jSy1PZ5hCVHT6NeQBuj32moKg/dVyypyzjkwzEoRsJU33g2
8ArCwwCFxszYrdHyB/UGXDbuyyM0IryDC6aKxYfqXejMtf730jLRFY3YPgmcaJH/
FjmY7kH7mEM4ENjf1KeFtcka7Gtr50i29zBUJrWsjUL2+n+D7QfVotTyrSSbAGH6
CyD6g0hh8cu8p1fMnxczJDdHCHBSM+aokbbQnwSfCAH34aERAyOEo/Jndpsa1QAP
W3Yb2Bke81rabUnvK4LhnxG86rG/jg==
=ligY
-----END PGP SIGNATURE-----

--Sig_/XbE+LumaCv.tsn1t1Jv3L5C--
