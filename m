Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6E6C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7431620645
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qu85rfIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7431620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeLLWsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:48:40 -0500
Received: from ozlabs.org ([203.11.71.1]:45681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbeLLWsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:48:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43FX6D6Ybwz9s3Z;
        Thu, 13 Dec 2018 09:48:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544654917;
        bh=NBY2y1Hxw7IpLEk/ATahfgOfGql+hQD79vcfsc7jPFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qu85rfISqcUx+lOARfAH4wCPdcYkJVbl21YNZckHno/B8IS8BXgOIwhQaOzKpvPIG
         PGFEqYxHv2DoC/CE54qyYBiUZo/3bWXS4MLxu+lp4FnSq/gH2kA5HQ4JwqME799IzY
         ZsNXFnfIQ09JMkHkzz5Mp2jRLARJYX8Lvrw7mFmSBq/HY9GWoApsFCfH/6O2rLIl4N
         VmNkmdROZx5trUKV39Xp0gtMrDCaI83iXwqqNdjPUAP5GntdFkcqAb323c6ebum1a1
         M/coFE4VG1+zBJbX8SXzSMVbVf/pZX3QcBGlhiOxsqjnkMHB/DbJWnPjz8AoWPOFl3
         hCtKVf6kOgz+g==
Date:   Thu, 13 Dec 2018 09:48:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next
 tree
Message-ID: <20181213094820.62d26354@canb.auug.org.au>
In-Reply-To: <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
References: <20181213073245.5b2d2536@canb.auug.org.au>
        <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YhAEp84TgXfVWmN.9ptqAqn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YhAEp84TgXfVWmN.9ptqAqn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Wed, 12 Dec 2018 12:53:11 -0800 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> On Thu, Dec 13, 2018 at 07:32:45AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Commits
> >=20
> >   3bdc28aa2340 ("selftests/bpf: add btf annotations for cgroup_local_st=
orage maps")
> >   1dfd1959fed4 ("bpf: add bpffs pretty print for cgroup local storage m=
aps")
> >   3adc62d9a5be ("bpf: pass struct btf pointer to the map_check_btf() ca=
llback")
> >   9cf3a785dc4c ("selftests/bpf: use __bpf_constant_htons in test_prog.c=
")
> >=20
> > are missing a Signed-off-by from their committers. =20
>=20
> the must be a script mistake?
>=20
> I clearly see SOBs for all of them.

For example:

commit 3bdc28aa2340bf1e5af753287b373522bd1c02a9 (bpf-next/master)
Author: Roman Gushchin <guroan@gmail.com>
Date:   Mon Dec 10 15:43:02 2018 -0800

    selftests/bpf: add btf annotations for cgroup_local_storage maps
   =20
    Add btf annotations to cgroup local storage maps (per-cpu and shared)
    in the network packet counting example.
   =20
    Signed-off-by: Roman Gushchin <guro@fb.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Acked-by: Martin KaFai Lau <kafai@fb.com>
    Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

But it was committed by you, not Daniel.
--=20
Cheers,
Stephen Rothwell

--Sig_/YhAEp84TgXfVWmN.9ptqAqn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwRkDQACgkQAVBC80lX
0GwcYQgApSY5aSjv4ynkNhg44iRlgOrfrE1WyMkGkVM23flsOeb4wSl0ucjM+QRu
bQtclpftjdkz0KY2ZwE7/4Mw6GNcITc5Z56MjzDXRgl/h82sz2nS0V+lVr1e6tKk
Up22X3Ixlf4/cPoIR17L3jJTSoiGBgmamF4QhMQoj9agSdB4PVN/c7dgwk8qvITZ
PTrFVnac+uVsEaPIiMPSBDDJuk78gGcixWZNzmu++kOFkHiLqa54rtEZYkrJvgVw
8ca4SRHL4DezJrUWw3KQnP1Mzcx1GZvzPkEHwCRZEI7xJ5LokcyuyljzY9Yf/Nts
OsHSr90wDmQVpBs8uYZ+FRt2xJwSNg==
=bCpM
-----END PGP SIGNATURE-----

--Sig_/YhAEp84TgXfVWmN.9ptqAqn--
