Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeCQUrY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:47:24 -0400
Received: from sauhun.de ([88.99.104.3]:38693 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeCQUrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:47:22 -0400
Date: Sat, 17 Mar 2018 21:47:20 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
Message-ID: <20180317204720.mclh4jw5owobbtww@ninjato>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uxgcnuvhy2xifurm"
Content-Disposition: inline
In-Reply-To: <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxgcnuvhy2xifurm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2018 at 11:53:43AM +0100, Pierre-Yves MORDRET wrote:
> Feature prevents I2C lock-ups. Mechanism resets I2C state machine
> and releases SCL/SDA signals but preserves I2C registers.

Does it release SDA when held down by the slave? Because that is what
the recovery mechanism is for.


--uxgcnuvhy2xifurm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqtftgACgkQFA3kzBSg
KbYrdw//XZdl/P3FOgH3x96OLT+VRWIUUpDyDavmmJayw6YlACwYEy9KbfwBBwfG
2CvOWh4UEXKw4dhzQxsnAkX16RecExQakBO1Fh4TFjd1y/34iqtOX0s6HrocXFYw
PvVo/ysFYpkb08C4+8zXgCtD7VzjiRuSO0n5TvAkN4THrZ/jje8sv3eSnWLug+uq
3N4fVaxE0tshoesuOWozZ2L6qsFSeLM2ykcVfnwbJWzuFHVFCvzF0/kAsK77uvUI
sIoGxOLJK4gcIduojRs0jrKMxOBbUP3XqS3DTW7nVYSfRpZmDrnWkdv2HdIab3BP
TIQotg31GsxTVcU5JgwPZeM4HbA4pHkR3V1U5HvwYIu+siilETaywTChS6shxvpf
6uA7ulOhmfRxjZcmcbLzz+y29hEUMU1GIfPpAWM83xnm9kwdEWa6RxqPJN/sXZw6
Qbw9iktBCTaz8riNkYceJ4di/XfVIUP7BNtNu0Fb94e2n8ln+FaUGSsJcYPhPFnp
RCB14Ijl/jPXH7pyl7nTDA0SKoDr8RjtTSK8BaIqRvMC7h5lirdbpkX9fVaATvxU
kqgEkstl9uh3L2W3yA2KgdP9VlPYGi2Z44DYsCwug8YKgNCN8hxOJND/s8k+oNiB
mtw4E3HgD3rjRerhtdfZhDP9vAfe5iUS7a2DwuiD+tYl6ld4g74=
=PcnA
-----END PGP SIGNATURE-----

--uxgcnuvhy2xifurm--
