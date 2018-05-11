Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEKV4R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbeEKV4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:56:16 -0400
Date: Fri, 11 May 2018 22:56:12 +0100
From: James Hogan <jhogan@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: c-r4k: fix data corruption related to cache
 coherence.
Message-ID: <20180511215611.GB20355@jamesdev>
References: <87sh7klyhc.fsf@notabene.neil.brown.name>
 <20180425214650.GA25917@saruman>
 <87h8nzlzf1.fsf@notabene.neil.brown.name>
 <20180425220834.GC25917@saruman>
 <87vacdlf8d.fsf@notabene.neil.brown.name>
 <87lgcwcvj2.fsf@notabene.neil.brown.name>
 <20180507201655.GA27369@jamesdev>
 <87o9hraqlf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <87o9hraqlf.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 11:22:36AM +1000, NeilBrown wrote:
> On Mon, May 07 2018, James Hogan wrote:
>=20
> > On Mon, May 07, 2018 at 07:40:49AM +1000, NeilBrown wrote:
> >>=20
> >> Hi James,
> >>  this hasn't appear in linux-next yet, or in any branch
> >>  of
> >>    git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
> >>=20
> >>  Should I expect it to?
> >
> > Sorry Neil, I haven't applied it yet. I'm planning to get a few fixes
> > sorted this week, at which point it would land in the mips-fixes branch
> > at the above repo.
>=20
> Cool, thanks.  I just wanted to be sure it hadn't got lost somehow.

Now pushed.

Thanks
James

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvYRegAKCRA1zuSGKxAj
8k+cAPwINk3TzhEwI2ihwliaC2od+nT6EC7fExzUTqgV/oRjNwEAxDNL493COhi0
X1TZWyeMreE6ETF8yPlL5483oyRagQ0=
=p3I8
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
