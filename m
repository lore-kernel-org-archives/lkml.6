Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030677AbeBNOB0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030582AbeBNOAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:00:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1859F2178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 14 Feb 2018 13:59:43 +0000
From: James Hogan <jhogan@kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: Remove a warning when PHYS_OFFSET is 0x0
Message-ID: <20180214135943.GG4290@saruman>
References: <20171226113717.15074-1-malat@debian.org>
 <20171226113717.15074-2-malat@debian.org>
 <20180102093127.GM5027@jhogan-linux.mipstec.com>
 <CA+7wUszh=xpNMsZXS0fNu2Vcp=GK9xkzfog5qB2_LGizhadv1Q@mail.gmail.com>
 <CA+7wUsyNrLzd0fM5B4_89wp8G9g=VHLu=xQ3o4bK47PLv4p1LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
In-Reply-To: <CA+7wUsyNrLzd0fM5B4_89wp8G9g=VHLu=xQ3o4bK47PLv4p1LQ@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 11:35:44AM +0100, Mathieu Malaterre wrote:
> On Tue, Jan 2, 2018 at 7:55 PM, Mathieu Malaterre <malat@debian.org> wrot=
e:
> > Hi James,
> >
> > On Tue, Jan 2, 2018 at 10:31 AM, James Hogan <james.hogan@mips.com> wro=
te:
> >> On Tue, Dec 26, 2017 at 12:37:14PM +0100, Mathieu Malaterre wrote:
> >>> Rewrite the comparison in `else if` statement, case where `min_low_pf=
n >
> >>> ARCH_PFN_OFFSET` has already been checked in the first `if` statement:
> >>>
> >>>   if (min_low_pfn > ARCH_PFN_OFFSET) {
> >>>
> >>> Fix non-fatal warning:
> >>>
> >>> arch/mips/kernel/setup.c: In function =E2=80=98bootmem_init=E2=80=99:
> >>> arch/mips/kernel/setup.c:461:25: warning: comparison of unsigned expr=
ession < 0 is always false [-Wtype-limits]
> >>>   } else if (min_low_pfn < ARCH_PFN_OFFSET) {
> >>>                          ^
> >>
> >> What compiler version is that with out of interest? It isn't exactly n=
ew
> >> code.
> >
> > I've clarified in v2, that this happen during compilation using W=3D1
> >
> > For reference:
> >
> > $ mipsel-linux-gnu-gcc -dumpversion
> > 6.3.0
> >
> >
> >>>
> >>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >>
> >> Reviewed-by: James Hogan <jhogan@kernel.org>
> >
> > Thanks !
>=20
> ping ?
>=20
> https://patchwork.linux-mips.org/project/linux-mips/list/?series=3D623

Yep, both applied for 4.17.

Thanks
James

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEQM4ACgkQbAtpk944
dnohwhAAtZHxZQ+Wpi+Qpsk4COdtQdH94ODF/fw5BoaLm6MA4YcFfrJDXicCL/Fp
0m4VDCZCDROrqtHWYyDHvweyJGVWmXf+j/9XXn/SKRwKNZonHm8Jgs99xIqP8V+C
XLWNYj3mxFNtvkKe9QHgnFPSv51P7WU8SJnq+e59CYnOjHCzzlYBrFLDyZB7pOjN
7VsS3rM6RQAJgxP6lpTZznnrScn9hulqHFU2CGgSWccBBRypGQymkurm+wZvCgSP
j1K/qUt1bqC36TS5T+WX5gEbO4/S0DoMO9ebRBDRSphNPPUM4cCpJb9t96lbeHss
j0eDeSCj4uT5wR2x7+7YjYzum6IximlBrwE/V/xq0pw8oj+a0WemFea4np8Aikao
Y/15lwcajk1qsUZjLHitlDUq8XF7ZsAz1PzrFja1ucPgG+rPuZ6YfWk5W94DHBJ+
9jaKvluI4VN4jSfA0U5g0VklqBAvbfLok3S8EEQf04oZ4+QLMHfTLd2acODS2ek6
DJcA2EHAEezOeQTv1AjS8ephCLvxs4OeffXE7A78iBmcwsbsv2OotMbW9ib22pOB
MPKnUjlcn5GTJk9dAtn9C5CdcKBVqJTrDxhS29RZ4c45dnY7497WpoedJjoc5sZ4
VFX7fFL3a0SwOKaipRlLz8sc7WbUa6v88MdjNFNKsqbpOHWgcMc=
=wy3/
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
