Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750736AbeEaVee (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbeEaVed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:34:33 -0400
Date: Thu, 31 May 2018 22:34:28 +0100
From: James Hogan <jhogan@kernel.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ptrace: Make FPU context layout comments match
 reality
Message-ID: <20180531213427.GC30406@jamesdev>
References: <alpine.DEB.2.00.1805141441260.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805141441260.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 11:03:09PM +0100, Maciej W. Rozycki wrote:
> Correct comments across ptrace(2) handlers about an FPU register context
> layout discrepancy between MIPS I and later ISAs, which was fixed with
> `linux-mips.org' (LMO) commit 42533948caac ("Major pile of FP emulator
> changes."), the fix corrected with LMO commit 849fa7a50dff ("R3k FPU
> ptrace() handling fixes."), and then broken and fixed over and over
> again, until last time fixed with commit 80cbfad79096 ("MIPS: Correct
> MIPS I FP context layout").
>=20
> NB running the GDB test suite for the relevant ABI/ISA and watching out=
=20
> for regressions is advisable when poking around ptrace(2).
>=20
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>

Thanks, applied for 4.18.

Cheers
James

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxBqYgAKCRA1zuSGKxAj
8uHhAPkBifAbPhcj+VwFhUXKfcLd0iMFaVBlPeVfEZKVvhX/zAEAoT/rQhvIvI3l
quwDvYFbs9EG4GGn3vzTiKCpt0zkCQA=
=P1yo
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
