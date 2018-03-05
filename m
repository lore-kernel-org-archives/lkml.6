Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeCEQ1l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:27:41 -0500
Received: from sauhun.de ([88.99.104.3]:40249 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeCEQ1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:27:40 -0500
Date: Mon, 5 Mar 2018 17:27:38 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] i2c: add i2c_get_device_id() to get the standard
 i2c device id
Message-ID: <20180305162738.kkbe3qlt2xbzabl6@ninjato>
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-2-peda@axentia.se>
 <20180305155111.ihlt4hn4yz3igo3z@ninjato>
 <b624a0c7-ffe2-245b-ff9e-ca9d10063715@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kdsrakcrj2twy3wk"
Content-Disposition: inline
In-Reply-To: <b624a0c7-ffe2-245b-ff9e-ca9d10063715@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kdsrakcrj2twy3wk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> ..._TEN should definitely be cleared.
> ..._SLAVE will probably be cleared anyway.
> ..._HOST_NOTIFY, ..._WAKE and ..._SCCB I don't know about?

Not relevant for device_id reading.

> Are there others? The bits aren't that densely populated which makes
> me worry that I'm missing something...

Historic reasons, there are no more.


--kdsrakcrj2twy3wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqdb/YACgkQFA3kzBSg
Kbb+chAAhinG4r3v2pUHJOUMTAgO1e4Dli5tphgUtdHG6p1j38TLg0HOBZr71RjU
IuaC/VgUGvpfm8OdbFNb3r673o4OssWb1GMpsjhZl2urZi3GZkI8Rp+noW2dlCU5
XYXpQJ3sQle74gft0j8Oy0ajWnnVroDMZket/FdXtBwDFk7y75c5lZfS8V59wd7o
y4LNoE+rOaaGu7imASpIuWr185CCXK0gLvcXbIy/+g/Dv+n5wPKQySCf8+PK583T
VWjD3NsQMnbsMYXb482Wnrs0Dc8BddPuDVlFXjyuV7ximZ2j4Q2Al3t89+twn/tV
PjjBCUAT6wRqBoLCfuk0NMPOXHIQ7hpzP8SyNcQGYrNxnL4+rq64E3Ksv2dY9R9M
GC+pNDMOK6WY5K1mblaZKbcH5Xitq4Qd0NxfYyz9X66Nat2090q2LE8p4aVZhE+f
3Knvh8tPxPz0hd+crE3Z098hmgaMEZvvhxJO2UP7EAdj9jyMG8FwK4bzUvHvDVo4
Pzp0PlBVwz2b1J9rfUlc1TbMfaWJaJQ7UlOR87TZV+QJ88zH9msnrzIjHYjzGg1a
vVyNLMPMASFZnF6gYkdcz1UDFJR6ezkwbocDB/82mfghRqeqgUHuRCfrRCpF/eaB
8A3xjqZkH1HKw/AtfMoUFwm8K5+TgjFWNMJEok5NPs94Jxq01/8=
=f4ep
-----END PGP SIGNATURE-----

--kdsrakcrj2twy3wk--
