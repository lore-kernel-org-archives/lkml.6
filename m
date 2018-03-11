Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeCKXNO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 19:13:14 -0400
Received: from ozlabs.org ([103.22.144.67]:36895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932290AbeCKXNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 19:13:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 12 Mar 2018 10:12:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Jesper Nilsson <jespern@axis.com>, Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-cris-kernel@axis.com, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>, Greentime Hu <green.hu@gmail.com>,
        Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Vincent Chen <deanbo422@gmail.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [GIT PULL] CRIS: Drop support for the CRIS-port
Message-ID: <20180312101207.67ce00ca@canb.auug.org.au>
In-Reply-To: <20180311200056.GY17177@axis.com>
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
        <20180308155116.GW17177@axis.com>
        <20180311110551.GX17177@axis.com>
        <20180312011344.6071896c@canb.auug.org.au>
        <20180311200056.GY17177@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_NqHWnDV0cpAA+Inw4LdbMh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_NqHWnDV0cpAA+Inw4LdbMh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jesper,

On Sun, 11 Mar 2018 21:00:56 +0100 Jesper Nilsson <jesper.nilsson@axis.com>=
 wrote:
>
> On Mon, Mar 12, 2018 at 01:13:44AM +1100, Stephen Rothwell wrote:
> > Hi Jesper,
> >=20
> > On Sun, 11 Mar 2018 12:05:51 +0100 Jesper Nilsson <jesper.nilsson@axis.=
com> wrote: =20
> > >
> > > As promised, pull the below tag for the removal of the CRIS-port. =20
> >=20
> > I guess the easiest thing for me to do is just remove the cris tree
> > from linux-next at this point? =20
>=20
> Yeah, that's probably the way to go.

OK, done.

--=20
Cheers,
Stephen Rothwell

--Sig_/_NqHWnDV0cpAA+Inw4LdbMh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqlt8cACgkQAVBC80lX
0Gwx5Af/aJEdlD+0XoSMBrAWdi8JOE8l+s5HkhRS3UWdwil8WvlJgedYp/8jUgHk
5iHJvCtdspVDxlb43u/ce+TzSpYQxwVc33vldXw44sUCv2kB5JTj9rcNYKRQpom5
VsLiIkdypJWwpf2n8ChASoe7jvsLJ9/dYixh4VWARqfC/tgsKycPQrwsfVK99eJ/
M+ws7MPgTbK8HVyjpBilq3Azf6e6yu5ugoBdOCFBvlPDPH9/aIcRZ7yMIQQI+bnM
MXTIbEbzmfhkreLFO9LKp4qlAGrkLjWicLjTZdJt95Acsru9muHIIqjF2S/WkufG
oqb34xp/tyYee0iywCibVBlW3vt/Ew==
=FvwZ
-----END PGP SIGNATURE-----

--Sig_/_NqHWnDV0cpAA+Inw4LdbMh--
