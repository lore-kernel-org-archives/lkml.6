Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeEBFXn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:23:43 -0400
Received: from sauhun.de ([88.99.104.3]:60224 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbeEBFXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:23:40 -0400
Date: Wed, 2 May 2018 07:23:37 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is
 called
Message-ID: <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pyqc3ex3plu6boam"
Content-Disposition: inline
In-Reply-To: <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pyqc3ex3plu6boam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > We should maybe handle this in the core somewhen, though. Or?
>=20
> Thanks. Yes, It will more helpful if we can handle this in the i2c core.

To understand the issue better: which kind of devices in your system
still send I2C transfers when the system is going to suspend? Do you
know?


--pyqc3ex3plu6boam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrpS1EACgkQFA3kzBSg
KbaOqhAAoPH2rKnJ9MygI6R6IQAjnzaAO27UGHdgXVlbFnREJx9+CkFttiflfk5a
Vfwp7VmTXyQyrU3S+mianRijU277qIupRkG8JgjH0JtlVWqFrWP3jbqLFmBhD4WT
FNEU7zIOLOS4j/Y509dco0M9TgNIpHVFvepFWWdTNlv2KYmi5Q6gjnTYil8xT15M
CqO2DSUKBio65r6CdbVodyPUzJ+/QecwNk+W2wdFMftCSKoUtUmlyiisSjSFAFjw
vgMks9JUE6x0yeQnaLAl2UjMN/dvLd8x1kN+8kXFeTxV7QjtuZG94pjnj8nPvkYC
TABWG0Fdho3U1PE/54UHoL2Yr4EbukQnYknDhc4sefznqnRFYj8C/QV81Z9YyFsW
ptI4MtzMiAhN7JQgd4ck8qZBQJNqrv3oft4wQGBBpASXBl4/wvuC2W5ITvRm0o/K
2lWhy0bXT1Z5HwZ7tfDAmnrYJmU9aZs7jFpEmUyShoKSnCeNgwjkMhgCyxi5EC5M
aMcZz4oKXcha4PKReNUUBpci3K7oXmAgeRpyuAYxL5auvUhXHbv8dECTL+v4TKqo
1vCoz/WuzP9kt9EDRljhr5a1ERbPaeGoSIJkFY0IZJqD7lUHZmMKo6MbnOqPe4Jw
6EppwModREnoNMzOMKyzM8odsMra2Ler/tbuAbODW8aIqDEMSQA=
=x5R6
-----END PGP SIGNATURE-----

--pyqc3ex3plu6boam--
