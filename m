Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeCKOOb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 10:14:31 -0400
Received: from ozlabs.org ([103.22.144.67]:34993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbeCKOOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 10:14:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 12 Mar 2018 01:13:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20180312011344.6071896c@canb.auug.org.au>
In-Reply-To: <20180311110551.GX17177@axis.com>
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
        <20180308155116.GW17177@axis.com>
        <20180311110551.GX17177@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vYf6Q1j5Q18j+77fvZ4dtj_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vYf6Q1j5Q18j+77fvZ4dtj_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jesper,

On Sun, 11 Mar 2018 12:05:51 +0100 Jesper Nilsson <jesper.nilsson@axis.com>=
 wrote:
>
> As promised, pull the below tag for the removal of the CRIS-port.

I guess the easiest thing for me to do is just remove the cris tree
from linux-next at this point?

--=20
Cheers,
Stephen Rothwell

--Sig_/vYf6Q1j5Q18j+77fvZ4dtj_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqlOZgACgkQAVBC80lX
0Gwr2gf/W0AnDKZ/Xb6qMMiA8QHSNYd2tPMUpatATyv5MKU/TWaCkHJ3QfEJDUVf
eP3gKQ+HzJUiym4s+O8+BpdQI6Hn5WFzjKnxhxDm0H+MnMEA4JEOitq4oH+e6LJx
kWFYk8V7hCxhhG275nW7L27/wJwgEepFbLs0IyiUT2pGyly2GxMqCTXAnrfNSB8O
rLnEPE+cPTVHJ9FCyNVJSQwH2kOsP/jPQ6gE0CPp2kM41Ipj5VJBwESP61lC14A3
1Orvt8CZc3s4+4dsdCPovxTPwh8wE1JwwwsevYkhKnqRN7pgolXWc3kBilfHJjgo
vWHs445z1vYrJkAvOS2AA8QpDkkP1Q==
=hgjp
-----END PGP SIGNATURE-----

--Sig_/vYf6Q1j5Q18j+77fvZ4dtj_--
