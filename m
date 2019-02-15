Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C67F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfBOJSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:18:50 -0500
Received: from sauhun.de ([88.99.104.3]:60486 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfBOJSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:18:49 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id EE8B42E3551;
        Fri, 15 Feb 2019 10:18:47 +0100 (CET)
Date:   Fri, 15 Feb 2019 10:18:47 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        kbuild-all@01.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, me@jue.yt,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        Juergen Fitschen <jfi@ssv-embedded.de>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20190215091847.pkagndsndjzumzwd@ninjato>
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
 <20190115224351.rtbqaqro5pl3dvov@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qchyiiv27q5ypmam"
Content-Disposition: inline
In-Reply-To: <20190115224351.rtbqaqro5pl3dvov@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qchyiiv27q5ypmam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:43:51PM +0100, Wolfram Sang wrote:
>=20
> > All errors (new ones prefixed by >>):
> >=20
> > >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] un=
defined!
> > >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undef=
ined!
>=20
> That needs to be fixed. Rest looks good to me!

Ludovic, do you have time to fix it? I would really like to apply this
series for the next merge window.


--qchyiiv27q5ypmam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmg/MACgkQFA3kzBSg
Kbaxtg/9EujPwpdjaYtxYjWa2I4ETfR0dHWnklKyaTbLIDlAi1HZnfhQ656dWaat
h+FpC6m9SubOr3DeJxG7XVBsygDvn8AnWS0UJPxzYlBSuOl+XAPoDdpiBwMugpEL
mKBOyBiLUQ8M7L1LzGHvgnm5Bm3r4xBirPVBYckHc5S2kMGqgarQYopILiwrC62D
6b+eyKYWbcmpESEIwPz7Sl6KbcOb1WzEJbdmxNCFDmzQhV4K15fMl/BsrRSb0OLa
9qwhzQ+suUHXk6plDkXg49qvzxEZmPEPg0fDLFAdDHKUVNnLitgj+2DzSdAxSv5c
PpQaWv82b4CxxAyMi4Zm35CsfwiLb4fhMnfflZh0AaCoRBQit9/R/ROPCFmMVkSG
2LJ3ap6eENveUXifYjqNV4aoucOtvcQrn0u2Dt2WhaVrlImVoq7hW7+JirzTZxUd
VpPdsB9Zx7yU/6EgeuzvXaeH780vuWkGezw7GgnQMA9as1KQXOyAsw9KwKEgHnBI
MlHxZrpv0uYAKKVXV/5gvYmQF5TpkhhWfe4iSkMXGuHKqXFBZ095XAagt6roP58I
hOQ4eGbKyE9kiIbR2Ie8fQwSK/PpBTDxxcF2ZUk/F2DbPRyh9j1yHLnqWPs11TTo
fftCDKNQAV44g5TveOVZ7eQUWM9lL/UoSyrrjS8yGZs7LIXKvPI=
=PYSp
-----END PGP SIGNATURE-----

--qchyiiv27q5ypmam--
