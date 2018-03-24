Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeCXMiR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 08:38:17 -0400
Received: from sauhun.de ([88.99.104.3]:40952 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCXMiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 08:38:16 -0400
Date: Sat, 24 Mar 2018 13:38:14 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: fix no check on returned setup
Message-ID: <20180324123814.xgwgtvq57d4whd6c@ninjato>
References: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opvfwbopasbraelv"
Content-Disposition: inline
In-Reply-To: <1521650920-11578-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opvfwbopasbraelv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 05:48:40PM +0100, Pierre-Yves MORDRET wrote:
> Before assigning returned setup structure check if not null
>=20
> Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Applied to for-current, thanks!


--opvfwbopasbraelv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq2RrYACgkQFA3kzBSg
KbZ2HRAAjvj1Q/oQ7rm1O3iQ9tJ2FniovR9nO8BIRDdeb6uRscipMW0THGi1PD7J
Xy/IQo/QDqKa8zTMn0ZwH2KDIcBSoSOseDHeKjtEImRHKxVXJAiF5W4HitjdNqDm
vL6cC51FwRg/QHFMiSVvV+sKYUhJyUkhvTPFrUbUFdhcvDIR+VNostMorY2rX15B
oQDh790MnWEfRrbdqbFcHxD7g/8zzClx1S/GLLcHGxecxyduHwSXl7Mf1aDI0Ox+
jVH7VY4+zjypCCjk00aI0B5cSsBWCaRtsSvyI+WzR6bbzV/16dH/cC1YTew61wEi
DpmywqVBdns8/rvIZJOFBBpwCohWaZbF9K8mDky3IP6gs/kdyN8zz0p27blXhYQV
e4NSn+c+dj6qNhnaKDP8PHB/mjhvXVC9iIHWr5ABpRu00E07PUuy7Gqeoj+wr1Ej
tInXjuM0YlWf2OgRgPTotKk3h8ERTCbuwUFnt0NHRXbwjmIodJfHIjp5iWfnofRB
FHpaPaViWW1dsdh1tSwn5RMq7NIAw+Fz0YxPHpH5CUlMHpoGmZfqOP3BMdTWYmd0
cQXKYyT9iZAGWBS5fRF6EaNwVTmWB9IVjuaqdjQnknW91ALI+PhB1rKAllLohglU
03Qooj00MPhQ4JBqxZOhmGVFucZKxENZVs9G4j/BQstGirkq/5A=
=bNGg
-----END PGP SIGNATURE-----

--opvfwbopasbraelv--
