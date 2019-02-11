Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D90C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0E72080D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBKK0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:26:52 -0500
Received: from sauhun.de ([88.99.104.3]:52966 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKK0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:26:52 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 84CB62E3542;
        Mon, 11 Feb 2019 11:26:50 +0100 (CET)
Date:   Mon, 11 Feb 2019 11:26:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Message-ID: <20190211102649.pixedc2d4u3imoud@ninjato>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-6-federico.vaga@cern.ch>
 <fd5b5044-2415-c52c-ecb0-1f0f38267355@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4efbmwoassybo64t"
Content-Disposition: inline
In-Reply-To: <fd5b5044-2415-c52c-ecb0-1f0f38267355@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4efbmwoassybo64t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >  /* Read and write functions for the GRLIB port of the controller. Regi=
sters are
> >   * 32-bit big endian and the PRELOW and PREHIGH registers are merged i=
nto one
> > - * register. The subsequent registers has their offset decreased accor=
dingly. */
> > + * register. The subsequent registers has their offset decreased accor=
dingly.
> > + */
>=20
> The preferred multi-line comment styles is:
>=20
> /*
>  * Read...
>  * ...accordingly.
>  */
>=20
> So, please fix all issues when you are changing it to conform.

Yes. It is enough to send this updated patch alone; I applied the rest
already.


--4efbmwoassybo64t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhTekACgkQFA3kzBSg
Kbbdng//eA9O2upNhs3JFKhZpfb0tjxpRrw1VUdm9ioWOAaktg7WDvPObb/lu6s4
JQLPtWJ+xHwHBAgLddf2jkgmZ6kz8j3SlCj+bkMnDBs31UbNguIK9rG65n7s9F+8
RTpV0AGQei3V+GDYAFAeiveMuencAXvHbOZdnSc9UeyYgJXauBq3uIu9I1XLDUaQ
T1jfd+QfJ2FMiN70dOIuQU1Xk694e3uYlAJ025XDw/C9UcNq3JWKoJSNeo7AXH+X
iJ2+L+S1/qCeFgWQLmTo3fPMw2w8eciQw3wBbHzB4v+F2y/FrRY5T3R3+5rYmI/Z
GJ569knkL+C9MvDPOYRczksenrJJsre57BQTM0/qZahrF8uJjf76QHHXthVknMJW
2Ca+U8XokTx4vhw/rmlYWzJMuT42d5NlvKo9++thp5s0YhEanSNAsddQxxfKJfLu
LpPMQoFT2f1N2RsfQ1cSlOJWQ4SUCMLKOG52paDD/0xicfmERCw1WHX4aCKOEMxU
lzt/x1GJRQG9RSrh21I70xRtXKG2fYIoqAr8Iipk04xEnmLj+PsIrtSDU5uylk9e
D8fj31o3NMAlG20NsEJmdMUDfo44yN8yVkT4YLH6sTV46we4pRR0ry2H/Ldny3eK
LMUfHl6+Vtbrgtz/XvLEFH7k/MfC1dq6h7F+Hqz4K6qD3SqXs0c=
=hvH8
-----END PGP SIGNATURE-----

--4efbmwoassybo64t--
