Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C08C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A50F20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i/xtobY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A50F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLFWrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:47:04 -0500
Received: from ozlabs.org ([203.11.71.1]:40303 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeLFWrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:47:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439rM86Z9cz9s4s;
        Fri,  7 Dec 2018 09:47:00 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544136420;
        bh=yguJCj5t+IGWZyILtf3kOPneC1BlEzMccv7QpoDg+AM=;
        h=Date:From:To:Cc:Subject:From;
        b=i/xtobY89UM6nCQuyZfGD0BOH10+tmdmRKGTqr2QixC2VBoyKFgOhFyy/Sp9mGgLc
         E+vS3Sw5PvSns1J7BGhEPRy3mVzcaWSd0djrg90FG5auEYbRlE5onDFFdoYorTUR1t
         gvvV6LJ0d+WgQEX6Q8uSxmW0jSLpOitLtUzirnDWUsLJ/gamb6DSzQWP+EZxr5+FEU
         7za7BVL48bC8pNl0woYGXQOZR9xwdnDLSeALSOoCQy/tLmbxJl8lri8Hb5tRWzvJhw
         b8oTFWIhP8uasC5NNcaPshZJhZinA5aDvAFxlHgODCnaOlSSDWlVD1z/Ix0N/0AM8W
         ayVs2bhnKQqqQ==
Date:   Fri, 7 Dec 2018 09:47:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sweet Tea <sweettea@redhat.com>,
        John Dorminy <jdorminy@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the device-mapper
 tree
Message-ID: <20181207094700.35850c25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RLo.nETF/__Yn.iVO_TS89B"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RLo.nETF/__Yn.iVO_TS89B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d569b5efedfd ("dm flakey: Properly corrupt multi-page bios.")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/RLo.nETF/__Yn.iVO_TS89B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJpuQACgkQAVBC80lX
0GwI2Qf+NeWhnc3mEIfYlIHSuGZCYofXZlthgLcLTXyFkIMlA/WWOa1x1YY6wBtJ
L0qczs1jIM2W0/5cnMk0sSNyh7fKl/50cwsfMnAkDLXM0EZ4zVYeC5PPyG7DMaXf
cG+PKnXAVu2S7hmx7vfZFouUtcb6S3HbjZcUDuHWyvRoIXfaL8BWQyvSlvcSE2zZ
px8RLTAE5Cj3miZ09QWWc1MKeK4MtuOI5//xKQqr3DrlCSRAVTOLmgajI41L5QPs
VrP41XMRae7FwMvPoP3wcepMYGxDXqKa4+KskkaXBzvDABeKSM+DhBLJG5CZKqj6
YHA3PhDXxe5OgBbuAJmyluU5btVVoA==
=R+ze
-----END PGP SIGNATURE-----

--Sig_/RLo.nETF/__Yn.iVO_TS89B--
