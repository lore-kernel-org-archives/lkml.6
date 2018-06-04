Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeFDKpv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:45:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54706 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeFDKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:45:50 -0400
Date: Mon, 4 Jun 2018 11:45:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com
Subject: Re: [PATCH] ASoC: dapm: delete dapm_kcontrol_data paths entry before
 freeing
Message-ID: <20180604104541.GB7536@sirena.org.uk>
References: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
X-Cookie: One Bell System - it works.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 11:53:34PM +0100, Srinivas Kandagatla wrote:

> Below is the kernel BUG with SLAB Poisoning

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
> -------------------------------------------------------------------------=
----
>=20
> Disabling lock debugging due to kernel taint
> INFO: 0xffff80003cf1c310-0xffff80003cf1c31f. First byte 0x10 instead of 0=
x6b
> INFO: Allocated in dapm_kcontrol_data_alloc.isra.37+0x34/0x2a8 age=3D6929=
 cpu=3D0 pid=3D50
>  __slab_alloc.isra.24+0x24/0x38
>  kmem_cache_alloc+0x190/0x1d8

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVGFQACgkQJNaLcl1U
h9DFlQf+KuP/lW/iPvlcjQ0oZp8RvCj0F1kfnQuRB5G/+5QM5yzH9aEVgIcK5JYq
lcWNVkYmd+c8wa8xyWDcObTGfJIzo5cVWqoau4VoemZspU7VgH74X/SSTcynZiTQ
LYoWZ6b6yIL3yfQUlbB65qxCkxFxza96Lug6keLwbsHiGCrO1yF/izzaE7MPswZV
oBHlJoEVG5VYpKxBc5BsqUSUVJRX1afbQ6F8iouUgGTttm6fLq5k4prfsojBg46G
uYHp4O3fNEAtkWR46h9XcogwlsGal4B/hEpZAcLdx89GTrh9192uwhcPaG+Ho2+R
Y+vuAJgm2G2wsDN4/wmIcOsN52CV2A==
=v59X
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
