Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDD5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A8220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LOz9+D+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfAaX5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:57:42 -0500
Received: from ozlabs.org ([203.11.71.1]:46985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfAaX5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:57:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rHGp4WtQz9s4Z;
        Fri,  1 Feb 2019 10:57:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548979059;
        bh=xzhhudWbwGV5dH5aatfey98FzA7s8sgHIze9sbhiP/8=;
        h=Date:From:To:Cc:Subject:From;
        b=LOz9+D+YjJ+QSMIWqyRqhHOS8FImbiCmT+Pr5PMlsOD6BREe6FWe9JI3u5NNXn8NQ
         1LbecIo6NyJypTEiRrMLhF3+Q08gETylaRhyCbFz8/+65vtZrnfl5py+REu10Rxk1p
         mLciWHvxhHWIg4UGH1Q4hdTMWw0gbM7qtxKtD2O0x83misj1yyg33OMbIzGnaoyTyL
         FA9vQpQKh3IqZswsjIFkBDUrXygmH2+jQF26WB9axpdzs4Ddbkqq1bSg04GU9rRgT3
         /pRdJpGfkuUI2DTNIcKNGppSjiLIZ3TbiemrOU4JCOY9myS3eMxkTczht7K7arCkyd
         cd/PJxrJtKIxA==
Date:   Fri, 1 Feb 2019 10:57:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        Kent Russell <kent.russell@amd.com>
Subject: linux-next: Fixes tags need some work in the drm tree
Message-ID: <20190201105736.1428c9fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q7A6sF2/x+N6AAYNC/JNS11"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q7A6sF2/x+N6AAYNC/JNS11
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a93587b31e34 ("drm/amd/display: Only get the connector state for VRR when=
 toggled")

Fixes tag

  Fixes: 3cc22f281318 ("drm/amdgpu: Set FreeSync state using drm VRR proper=
ties")

has these problem(s):

  - Target SHA1 does not exist

Maybe instead:

  FIxes: bb47de736661 ("drm/amdgpu: Set FreeSync state using drm VRR proper=
ties")

In commit

  32e61361b82e ("drm/amd/display: Fix 64-bit division for 32-bit builds")

Fixes tag

  Fixes: https://lists.freedesktop.org/archives/dri-devel/2018-December/201=
008.html

has these problem(s):

  - No SHA1 recognised

Maybe instead:

  Fixes: 80604e27bc9 ("drm/amd/display: Use 100 Hz precision for pipe pixel=
 clocks")

In commit

  c4312c27c826 ("drm/amdgpu: Cleanup 2 compiler warnings")

Fixes tag

  Fixes: e4ae0fc drm/amdgpu: implement gfx8 post_soft_reset

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

Fixes tag

  Fixes: 5e01c09 drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings

has these problem(s):

  - Target SHA1 does not exist

Maybe instead:

  Fixes: c6064de4b734 ("drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq r=
ings test sequence")

--=20
Cheers,
Stephen Rothwell

--Sig_/Q7A6sF2/x+N6AAYNC/JNS11
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxTi3AACgkQAVBC80lX
0GwzRwf8DBWijKBMDHpG/ElUnWlulbVi9qYhXRJxHKvmLEnHRNlPnjFC4qXS65ci
Fm7U27XnpTKYNN86dtGCELE6V1whHZaCGgyV6yZZUneD2JmmJYVv9AnGeEygkBzX
xuFS1l3C8DNrf290dWP9QPABCD1Vcpw5EXgqEjd1EgRs6v1tvu+s0yoR2BIvWDzf
nF38r46RSYZoc3pq0xorKJ6MX8onfi5lZBjMA2zntmswKPDcga31d6vjfwlEBp+G
U7rb1xsTHJKaanjp9AOyHm1dphpXR98LX1phRBRxshu9Z7ypuOGD9Xrs5bwOP/55
uGJYarSgcjICevRyBSX6CRnqIat0dg==
=xPLZ
-----END PGP SIGNATURE-----

--Sig_/Q7A6sF2/x+N6AAYNC/JNS11--
