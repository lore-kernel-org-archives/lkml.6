Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeEQRJl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:09:41 -0400
Received: from anholt.net ([50.246.234.109]:47796 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752285AbeEQRJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:09:39 -0400
From: Eric Anholt <eric@anholt.net>
To: Vince Weaver <vincent.weaver@maine.edu>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <alpine.DEB.2.21.1805171233500.7984@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net> <1412187220.62585.1526572780332@email.1und1.de> <alpine.DEB.2.21.1805171233500.7984@macbook-air>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Thu, 17 May 2018 18:09:34 +0100
Message-ID: <877eo2mcoh.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Vince Weaver <vincent.weaver@maine.edu> writes:

> On Thu, 17 May 2018, Stefan Wahren wrote:
>
>>=20
>> > Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:
>> >=20
>> >=20
>> > The a53 and a7 counters seem to match up, so we advertise a7 so that
>> > arm32 can probe.
>
> so how closely did you look at the a53/a7 differences?  I see some major=
=20
> differences, especially with the CPU_CYCLES event (0xff vs 0x11).

I'm a bit lost in the code, but it seemed like the 0xff was a
placeholder for a bit of special behavior, but that the cpu_cycles ->
ARMV7_PERFCTR_CLOCK_CYCLES mapping got you that same value in the end.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlr9t04ACgkQtdYpNtH8
nug6GA//WbCbCgUyT8tNGxSWFgh1TTmOWv5t7C5cd7nEa3Lt6+XiVdCbyqdvEwK0
w5TRFWdVaEiWnUZltNUKxZKgc2MKAnGiISP7kV/J51Eg2eg5SHdYKIemsVLUXAJP
X4u7bOKSwtF5yQ8vw2a4s5rVZc8Q634fVjY7PBZ7pr9zgjfYJdDKtZFQQ8HbabpF
YZgxrOhjyiBJ+4yUwh2GNg00B3zGfkh/dkN0c9pxcEfCf7wG0Ys/aocMzKpRdOz+
2puB6ofM7AOfomMiwiklyrrm3emJENLHDeAuwPyXJwzOY8O+lt2PlxAvbLdsUkEd
MJcOieMzbkCqtkgB8EXBGx2gRYgJTQoOOy/98gIpHHvwyiNifvJLKGcsxKSTD45G
z5oRJFWUEEWNBbWKNrzZiQy3YRkknl9SwHyp21a7MjU6KVgG2e2PXIXqDKu5LfaT
3ehhXdp/kXd5gwIw+h7wQdGIWIzpJ+PUv3Aqlscet6ifLkhlX84JBKS7xhyTdfUL
egB8ZgpLyODO3YrQADkwbv5OdJt0G/TFyk8FnVKPGbEFNuiSYu50PUT9uuJCBwri
JJR46V8dfsRb5LL1ywAq7EVus+XpDx6R1oXgs/I+yKOdxc0nMZG8SoqidLef6cv/
q83CeZdV5ZWrXQ4u9kO6BzH8iW5wUoOwXyFfZlz1bmBEQOwlRxA=
=lsxw
-----END PGP SIGNATURE-----
--=-=-=--
