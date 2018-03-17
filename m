Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeCQIhO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 04:37:14 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33497 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeCQIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 04:37:12 -0400
X-Google-Smtp-Source: AG47ELsfRpR6gayVGMPNwrjdSFy0/ROad1al5WTsXj8OlF7uvzhPbMfLirP0cb4tpRlzXDDPCPJzcQ==
Date: Sat, 17 Mar 2018 09:37:03 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/7] watchdog: sama5d4: make use of timeout-secs
 provided in devicetree
Message-ID: <20180317083646.GA927@gmail.com>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180316133703.GA31029@gmail.com>
 <f3d913af-a396-ccdf-105f-c4e64397cbff@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <f3d913af-a396-ccdf-105f-c4e64397cbff@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 06:56:27PM -0700, Guenter Roeck wrote:
> On 03/16/2018 06:37 AM, Marcus Folkesson wrote:
> > Hi,
> >=20
> > Am I supposed to do something more to make this patchset picked up?
> >=20
>=20
> Did you check linux-next ?

:-)

Thank you

/Marcus

>=20
> Guenter
>=20

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqs06oACgkQiIBOb1ld
UjIvSQ/+OZNz57o0QzL0AcahUDcORE0yMlvflD5NjEFI6idt7gcrLkx+kTr9L+Pq
HGyamPmXqSY01zTqbSfcIdJQ3hKO3Bs8TaGaoksdP/fyJRQ71QkvEWn09P8VnElb
SBxkcEj8OPzIk5bgy+oW2o8a1Qlv/7qsrsihuEBRK9NPZ+ac/Xc3Zcg4K4l/28MT
LmfK7H1gTYk38hjk0TzMrv9hVJDAbLudhow74kB4czRz0T6bJBRbkZdaoANGejJN
TKFZkBh3/pqQ/IKu498Qnm7K0uLqQD8q3FJKRXPEjuIkzGSOYkVkuJGTJA8m6l3+
72lfpERxcO1+nl+2MMX9CPM7F7lV25mPhWgQ/C40tYjpB+0MUrT8jv3CBJcTN2t7
cZLIA12aI21nBuvsWNWH+X4npSu1CPPXRvZPx2rfP/L5fHlve7unY0qr3CL9fGtV
rKTA3+ZH5jEkD+qrGnBCWEbArzhC70UyrT3C/fChOZs36HnrCUD3GocUpD2DQnU4
q+oQ8capQqf2T3/PoRTpx1oOZ6KqLBll6WIU0NJvOUmlE6d9K/KXXfM4G5RDrrf2
s1qh1ZPYSq44tTPDy7xDRqsgMbfqsHRae8jyTcB4MSHfJajR9w0utkRxvPDnateg
FhQ5lyF48DBfz5IXgZ/e2JQLebAkAb7VOfZmPm6wZy6THST6L7E=
=ubOx
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
