Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeEHBWq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:22:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:56339 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753457AbeEHBWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:22:45 -0400
From: NeilBrown <neil@brown.name>
To: James Hogan <jhogan@kernel.org>
Date: Tue, 08 May 2018 11:22:36 +1000
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: c-r4k: fix data corruption related to cache coherence.
In-Reply-To: <20180507201655.GA27369@jamesdev>
References: <87sh7klyhc.fsf@notabene.neil.brown.name> <20180425214650.GA25917@saruman> <87h8nzlzf1.fsf@notabene.neil.brown.name> <20180425220834.GC25917@saruman> <87vacdlf8d.fsf@notabene.neil.brown.name> <87lgcwcvj2.fsf@notabene.neil.brown.name> <20180507201655.GA27369@jamesdev>
Message-ID: <87o9hraqlf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, May 07 2018, James Hogan wrote:

> On Mon, May 07, 2018 at 07:40:49AM +1000, NeilBrown wrote:
>>=20
>> Hi James,
>>  this hasn't appear in linux-next yet, or in any branch
>>  of
>>    git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
>>=20
>>  Should I expect it to?
>
> Sorry Neil, I haven't applied it yet. I'm planning to get a few fixes
> sorted this week, at which point it would land in the mips-fixes branch
> at the above repo.

Cool, thanks.  I just wanted to be sure it hadn't got lost somehow.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrw+90ACgkQOeye3VZi
gbl7ihAAvDWYQORJ2Fp279rRBBxckcbj1lJmXon2JszAqmitMmvRTKg38KD2xWYK
GwTWxZXsH+xe/6sp1by6W8K6Pt0jTJMAS4SUS/khKGYm7pHaNAC9dnHDhtizjMRo
FIQ1uBhmp7ik1O3x3nYdMzJYADFKlhOif96CIua2ix7jO17WpLkFPe/aq9h/0kqb
9C3M7WJX5X3FVZC5y0JEkuEsfIQVlPu+C+NEKo+4jmHbYu1cySGye43aTGasGrGY
JzHchQq06enVh/KZj24UvmDtTs+T43JDOL8OvXoLafALhxvlc+BgAUqqXz84Y8na
XxPAY4LIYIIe/WRnecucM1Vh8JCt9RLhpcyTuzekDgBNN8xLi0uVLLz+m9Ap++3h
2V1mWhusXUCpNOye5T31g3L6miH3G9zwKh87rlLK0g3Ypmso76Igg6qHGMqxHkQB
RxRmSVYbWKKJ/rKJA6nMtccIMo+EW6UE6cxdtUIBDLb/P1s8PqkC93UOLaFr2/0F
0DM94U8NlBXWRzqSS4NN5jZEypkU9qwTC2wR5QNkgkJtVsH8ATh5MN+7Lkp6SfOn
M811uwkCtC+0VxTUyShk5e4c3ae9dnRs2We/Q3MRPnpCCusnJpqfwpk3ci8iIfCh
xMhZ33FugAQTbnM9r5xZePxHxXqHhcYbe8Y2NkKznscrsYS0Nk8=
=rIhl
-----END PGP SIGNATURE-----
--=-=-=--
