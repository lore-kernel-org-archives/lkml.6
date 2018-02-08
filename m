Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBHOUT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbeBHOUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:20:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCCD20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 8 Feb 2018 14:19:59 +0000
From: James Hogan <jhogan@kernel.org>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: linux-mips@linux-mips.org,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>, linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 0/2] MIPS: Augment CPC support
Message-ID: <20180208141958.GB31316@saruman>
References: <1516376459-25672-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <1516376459-25672-1-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 04:40:47PM +0100, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>=20
> v3->v4:
>=20
>     - documentation patch now contains updating of MAINTAINERS file
>     - rebased to the latest code

Thanks, I've applied with the intention of squeezing into 4.16 (I
presume this is important for Ranchu).

Cheers
James

>=20
> v2->v3:
>=20
>     - changed documentation file location from
>         devicetree/bindings/misc to devicetree/bindings/power
>     - minor commit message improvements
>     - rebased to the latest code
>=20
> v1->v2:
>=20
>     - corrected wording in commit messages and documentation text
>     - expanded cover letter to better explain the context of proposed
>         changes
>     - rebased to the latest code
>=20
> This series is based on two patches from the larger series submitted
> some time ago (30 Aug 2016):
>=20
> https://www.linux-mips.org/archives/linux-mips/2016-08/msg00456.html
>=20
> Both patches deal with MIPS Cluster Power Controller (CPC) support.
> More specifically, they add device tree related functionalities to
> that support.
>=20
> This functionality is needed for further development of kernel support
> for generic-based MIPS platforms that must be DT-based and will at the
> same time make more extensive use of CPC.
>=20
> This series is reviewed by the original author of the above-mentioned
> larger series:
>=20
> Reviewed-by: Paul Burton <paul.burton@mips.com>
>=20
> Paul Burton (2):
>   dt-bindings: Document mti,mips-cpc binding
>   MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()
>=20
>  Documentation/devicetree/bindings/power/mti,mips-cpc.txt |  8 ++++++++
>  MAINTAINERS                                              |  1 +
>  arch/mips/kernel/mips-cpc.c                              | 13 ++++++++++=
+++
>  3 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.=
txt
>=20
> --=20
> 2.7.4
>=20

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp8XI4ACgkQbAtpk944
dnrfOA/+In8If/1vp5ny+2e77cRKewe891ye8wgEVNE6FOoZDz8/+lgfDBpDmuGP
tfPQX6SEFG/MZ4cIass3LlCDVugjG6ZZWvwDO5PBLnr0DP4M29KrVjFdTL1e/DHe
TUjoHzoEptgBLdvs/pDINE320gsfvymO0GC93Qiaxd2k/Gl+Uk1/eUAVT8GYGZmg
wrHmDT6zwfGv/HEW2eUrkQN+3WqQpFfWvyoQomdeXx+HSdQNvrK9pvlEFTecbuIk
hls0kdc1717Rf4NalPiC1grWRGnyAAoLNsJM6MU3qAB+RnVV5yWo2On+3jzJhZRj
zzxbH0jxjQ9J8E6LUR/PFBHURziBHvdbmkpU2XMfNemqgoPeZl9DNyIrh8eRGZIX
llHLudOHyo/eGYFvBpH91SnC4tGIarfX9a2dVCY+AU/1xJ94BzM4JAxDUzIbdEog
Yy1qeQLKkbsMlwKW50nDkUJ1uh2fjjO4Ff545U0v4E4A/v5iTejnWk/aZ7Yqa/oA
AWv+YPS09mFYWGrwdrlhJ7Ei36+Lb/SfLtUHgqIW6hdQGvHakghccAIaFljUUtbK
ZbgZTWzwLENKMUgwOB3VqFNXAr5T6x3VwyzvvORsFxlt3eF+zIpQBY8wVBWBVzOL
fY3tzby41P4uRccg3oNKAyBuYIYNdp/DmiT6Sv4DdbgX0J6LMoA=
=YWLJ
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
