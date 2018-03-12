Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbeCLSUs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:20:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeCLSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:20:47 -0400
Date: Mon, 12 Mar 2018 11:20:30 -0700
From: Mark Brown <broonie@kernel.org>
To: codekipper@gmail.com
Cc: maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v2 1/6] ASoC: sun4i-i2s: Add slot width override
Message-ID: <20180312182030.GN2186@sirena.org.uk>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-2-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VnOTrGv5LmZxna7m"
Content-Disposition: inline
In-Reply-To: <20180312155753.9478-2-codekipper@gmail.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VnOTrGv5LmZxna7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 04:57:48PM +0100, codekipper@gmail.com wrote:

> Some codecs require a different amount of a bit clocks per frame
> than what is calculated by using the sample width. Use a slot
> width override property to provide this mechanism.

If this is a CODEC requirement we should really be working this out from
the CODEC rather than adding a DT property on the I2S controller, or at
the very least putting this in the machine drivers.  The generic drivers
already have support for mclk-fs and there's an operation set_bclk_ratio()=
=20
for them to use though we don't have a DT binding for that yet.

--VnOTrGv5LmZxna7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmxO4ACgkQJNaLcl1U
h9CVtQf/Vxp7jVhu8gdF97IjSkSeLrpYv7gpjDD1Lx4CwA4nX0ZHIQrGbRH1vVQj
isw+xD96BY3zQAw6lBMsVhK94R/dWoAHafA35gjxE3Vfgi3YGncCw5SMV3u812K6
71vRpptZnUaCIRIPl44ulKrjboHC7/4QAk6FwtJPs/yFin3dKz9yMpYULryiFqR0
uXxVCVYbTRwFlCG38AEALoP6K3kRYt2OriNxENykHWp+iBiAtoSIIYfEKSjkW2t4
BRkSRZG/fEQ5Us6NpdebeLwbP3xp7N2iX50pMy2olUgL+MItMa2pIQz5ngl9w9IQ
ItZSuQWb5BubZ1lJwkcUZo4Z2ZEPVg==
=jGrF
-----END PGP SIGNATURE-----

--VnOTrGv5LmZxna7m--
