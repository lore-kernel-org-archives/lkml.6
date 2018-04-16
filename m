Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755466AbeDPOZt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:25:49 -0400
Received: from monster.unsafe.ru ([5.9.28.80]:57932 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753356AbeDPOZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:25:47 -0400
Date: Mon, 16 Apr 2018 16:16:16 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alban Crequy <alban.crequy@gmail.com>, Alban Crequy <alban@kinvolk.io>,
        Dongsu Park <dongsu@kinvolk.io>, Iago Lopez Galeiras <iago@kinvolk.io>,
        Stephen J Day <stephen.day@docker.com>,
        Michael Crosby <crosbymichael@gmail.com>,
        Jess Frazelle <acidburn@microsoft.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Daniel J Walsh <dwalsh@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc
 mounts when not fully visible
Message-ID: <20180416141616.GB21965@comp-core-i7-2640m-0182e6>
References: <20180404115311.725-1-alban@kinvolk.io>
 <87tvsrjai0.fsf@xmission.com>
 <CAEiveUf5LWpvA-QMm3eYr9yFgUjwyQdkk-WVptze9m_EfbGMwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <CAEiveUf5LWpvA-QMm3eYr9yFgUjwyQdkk-WVptze9m_EfbGMwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 14, 2018 at 12:41:31AM +0200, Djalal Harouni wrote:
> On Wed, Apr 4, 2018 at 4:45 PM, Eric W. Biederman <ebiederm@xmission.com>=
 wrote:
> [...]
> >
> > The only option I have seen proposed that might qualify as something
> > general purpose and simple is a new filesystem that is just the process
> > directories of proc.  As there would in essence be no files that would
> > need restrictions it would be safe to allow anyone to mount without
> > restriction.
> >
> Eric, there is a series for this:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1533642.html
>=20
> patch on top for pids:
> https://github.com/legionus/linux/commit/993a2a5b9af95b0ac901ff41d32124b7=
2ed676e3
>=20
> it was reviewed, and suggestions were integrated from Andy and Al Viro
> feedback, thanks. It works on Debian, Ubuntu and others, not on Fedora
> due to bug with dracut+systemd.
>=20
> I do not have time to work on it now, anyone can just pick them.

I continue to work on this. I am now trying to deal with the problem on
Fedora. I hope to return soon with the results.

--=20
Rgrds, legion


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa1LATAAoJEKRaulRM/9Q0mxgP/i5DN/dM7ff93D15xZ81YBsz
LudWQV2KVlRl09E24AQEOU806DJkxNjw5x+cQB40Oh9FgzqvLsHceseYH6dbUtz4
wrHlZnya1nQRZl32Bx+5XCDGbVN0ylBO7P1ZUUMHNYJN91q36o/RIlncKJ4m6VuW
ViGx9lb/e6frjSiHnWEui3V0kut4cCnoS/CsatpjlZK77GkwuJMwJph49FNRwZBs
w1t7exDPRI4y7nG9ufWT5/okIQv0awAo6DdPRJT/8FdRNLoeRJhYEUF1Ul+uRMVj
ZiQQBlnH+eTdMtvhr1zy99QYQSVpIwfBW8wXd2IxAEOF+l8js8GxzShShJ8cHtvP
x3Rm9yUFBuT8CoM+Y8or/Ev9HfyoECOHKzKzrYLSN2JKZVa7Jou9OnsZ/EeIbqyt
wGlAsuGEgi7Is/eXB/N0vj05QLklukNuwGaXY3tBrvcZB1GubTsnJ3wRRU2UipRz
8XP7yTDq0ntyO+d5YocC4SPCO+up7LWjT1a1+vTgpA/sWCwuVMlwkKTv6Qe3bIit
mzlIckxgJ/MjRDCruzd+xviRWy3xzlgI0NIFsIHB7nmcYjv/izlIBQ7uAK0sUkHN
2gc1phjgob8kSJiAd4icrbCKV2i1hhg1r8Lj6tCuHSGctACCsb6itZnfYA+DpJWV
3YGDyJeeO9znx/7PEhMr
=kikD
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
