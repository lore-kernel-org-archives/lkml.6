Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VAG3uOHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2DDE60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeFFElf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 00:41:35 -0400
Received: from ozlabs.org ([203.11.71.1]:39141 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbeFFEld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 00:41:33 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 14:41:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the bpf-next tree
Message-ID: <20180606144128.2fc46517@canb.auug.org.au>
In-Reply-To: <84481a2d-3930-93c5-9d4f-55b3d066050f@iogearbox.net>
References: <20180507120909.1fee1683@canb.auug.org.au>
        <20180507141003.79783848@canb.auug.org.au>
        <84481a2d-3930-93c5-9d4f-55b3d066050f@iogearbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5W5QjjIozSx2Yj2DVa5YO1b"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5W5QjjIozSx2Yj2DVa5YO1b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 7 May 2018 10:15:45 +0200 Daniel Borkmann <daniel@iogearbox.net> wr=
ote:
>
> On 05/07/2018 06:10 AM, Stephen Rothwell wrote:
> > On Mon, 7 May 2018 12:09:09 +1000 Stephen Rothwell <sfr@canb.auug.org.a=
u> wrote: =20
> >>
> >> Today's linux-next merge of the tip tree got a conflict in:
> >>
> >>   arch/x86/net/bpf_jit_comp.c
> >>
> >> between commit:
> >>
> >>   e782bdcf58c5 ("bpf, x64: remove ld_abs/ld_ind")
> >>
> >> from the bpf-next tree and commit:
> >>
> >>   5f26c50143f5 ("x86/bpf: Clean up non-standard comments, to make the =
code more readable")
> >>
> >> from the tip tree.
> >>
> >> I fixed it up (the former commit removed some code modified by the lat=
ter,
> >> so I just removed it) and can carry the fix as necessary. This is now
> >> fixed as far as linux-next is concerned, but any non trivial conflicts
> >> should be mentioned to your upstream maintainer when your tree is
> >> submitted for merging.  You may also want to consider cooperating with
> >> the maintainer of the conflicting tree to minimise any particularly
> >> complex conflicts. =20
> >=20
> > Actually the tip tree commit has been added to the bpf-next tree as a
> > different commit, so dropping it from the tip tree will clean this up. =
=20
>=20
> Yep, it's been cherry-picked into bpf-next to avoid merge conflicts with
> ongoing work.

This is now a conflict between the net-next tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/5W5QjjIozSx2Yj2DVa5YO1b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXZfgACgkQAVBC80lX
0GwLfwf/TuGUTSd1ULEdms7XBs6TsK04Vc+oAEvm4XYaeMP7KjCzniKGmqZkKjhD
7iEATWHgi9mFEkMfEoR2DqtzUNHeTCsYz/yn+GWJmWH/y9bnucM2tjxhLPISVzTh
wlzTUKkpWluJPFNrysCz06zyoU5QEgperc4KDLvFgxTgLP7MlY8Sk2udaKXpGEpb
pIWqtl0SaWyX2AgS5Eje1Q3PKAu3l5zInKjht6VZH690a8447vKpBUn/V2MgFTGY
QKMSy3YyC2bspMLns92byh1wyT/brXsl5Ta7CW87m0m59fYl0yRG2VSRn8GMIqbT
kbVzf2lS2fB/9c5AALIFUQfsJXK6WA==
=GXvh
-----END PGP SIGNATURE-----

--Sig_/5W5QjjIozSx2Yj2DVa5YO1b--
