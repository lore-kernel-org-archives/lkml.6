Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756095AbeCHQQd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:16:33 -0500
Received: from shelob.surriel.com ([96.67.55.147]:46278 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754578AbeCHQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:16:18 -0500
Message-ID: <1520525762.4638.13.camel@surriel.com>
Subject: Re: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
From: Rik van Riel <riel@surriel.com>
To: Doug Smythies <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>
Date: Thu, 08 Mar 2018 11:16:02 -0500
In-Reply-To: <000a01d3b6f0$c870d380$59527a80$@net>
References: <000a01d3b636$57b75c00$07261400$@net>
         thHZenCOVQdbpthHaeaJ1a tkIhevBcspApstkMJea2ob <000a01d3b6f0$c870d380$59527a80$@net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-aezONdYyKwy3yDhp4FR3"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aezONdYyKwy3yDhp4FR3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-03-08 at 07:18 -0800, Doug Smythies wrote:
> On 2018.03.07 17:29 Doug wrote:
> > On 2018.03.07 14:12 Rafael J. Wysocki wrote:
> > > On Wed, Mar 7, 2018 at 6:04 PM, Doug Smythies <dsmythies@telus.ne
> > > t> wrote:
> > > > On 2018.03.06 12:57 Rafael J. Wysocki wrote:
> > > > During the test I got some messages (I also got some with the
> > > > V1 patch set):
> > > Can you please check if that's reporoducible with just the first
> > > three
> > > patches in the series applied?
> >=20
> > I will.
>=20
> No issues. Test duration: 7 hours and 26 minutes.
> Boot seems normal. Times re-booted 4.

I am observing the same issues here.

I'll comb through the code to see if I can
spot the issue :)

--=20
All Rights Reversed.
--=-aezONdYyKwy3yDhp4FR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlqhYcMACgkQznnekoTE
3oOvvgf+ML6SkEO21i7r6sxLo29pNVWq4XGLa2+FOmpy6aK6hZnCgE7WzIiIxG26
FNsWNFYm5H8L/tnYpPY8XErvfV1sMJMgGjHntB1WabAfKBWmN5ToS/lxZcz7ic+w
HEXFqondbZvBgCx+4xDu4AADGjaCjvFZDE3l1FFX63dT1SpnD6dIqdhb1Ronxjix
p2bX1e9TbUepGt3wJIolAbvUlXduHhecWycXXhrchQjuxrOxNC/LgU8YCq2ElVSu
ZrtptRV7dDTmchm6eVqtF5cpnkfEdgeXiH6xnHUgnpBWNvIRunvF83XeBHXlEpy1
TgvJAhOP9mG6f+NqReM/JcLCfPl8fA==
=3vcf
-----END PGP SIGNATURE-----

--=-aezONdYyKwy3yDhp4FR3--
