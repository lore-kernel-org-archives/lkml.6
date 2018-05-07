Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeEGURE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752905AbeEGURB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:17:01 -0400
Date: Mon, 7 May 2018 21:16:57 +0100
From: James Hogan <jhogan@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: c-r4k: fix data corruption related to cache
 coherence.
Message-ID: <20180507201655.GA27369@jamesdev>
References: <87sh7klyhc.fsf@notabene.neil.brown.name>
 <20180425214650.GA25917@saruman>
 <87h8nzlzf1.fsf@notabene.neil.brown.name>
 <20180425220834.GC25917@saruman>
 <87vacdlf8d.fsf@notabene.neil.brown.name>
 <87lgcwcvj2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <87lgcwcvj2.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 07:40:49AM +1000, NeilBrown wrote:
>=20
> Hi James,
>  this hasn't appear in linux-next yet, or in any branch
>  of
>    git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
>=20
>  Should I expect it to?

Sorry Neil, I haven't applied it yet. I'm planning to get a few fixes
sorted this week, at which point it would land in the mips-fixes branch
at the above repo.

Cheers
James

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvC0NgAKCRA1zuSGKxAj
8oKRAPwK7fmohcud0fjIl2pvltDY4gpwo83BsYs92ho1OS55JgEAlVOso4iJX4X5
7NItreTsvuSUoS9uUB3be8tkG4FGKAk=
=y4bN
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
