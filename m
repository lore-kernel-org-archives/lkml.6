Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDFBOq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:14:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeDFBOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:14:45 -0400
Date: Fri, 6 Apr 2018 02:14:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: hch@lst.de, thomas.lendacky@amd.com, tglx@linutronix.de,
        dwmw2@infradead.org, joro@8bytes.org, jdmason@kudzu.us,
        konrad.wilk@oracle.com, torvalds@linux-foundation.org, mulix@mulix.org,
        peterz@infradead.org, iommu@lists.linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, Vinod Koul <vinod.koul@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi (commit
 6e4bf5867783)
Message-ID: <20180406011418.GE12349@sirena.org.uk>
References: <20180405205657.GA1788@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20180405205657.GA1788@light.dominikbrodowski.net>
X-Cookie: Last week's pet, this week's special.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 10:56:57PM +0200, Dominik Brodowski wrote:
> Christoph,
>=20
> unfortunately, commit 6e4bf5867783 breaks sound on my Dell XPS13, see the
> dmesg diff between fec777c385b6 and 6e4bf5867783:

Adding Vinod and Pierre from Intel in case they have any ideas here.
Which model of XPS13 is this (2015?)?

> -sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
> -haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/Intc=
PP01.bin failed with error -2
> -haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not ava=
ilable(-2)
> -haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info=
: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b67=
72b23c7c983ce9dcb18a19
> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mappin=
g ok
> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapp=
ing ok
> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapp=
ing ok
> -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapp=
ing ok
> -broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mappin=
g ok
> -input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwe=
ll-audio/sound/card1/input15
> +broadwell-audio broadwell-audio: ASoC: CPU DAI System Pin not registered

> So it seems that sst-acpi is unhappy with this patch. Any ideas?

> Thanks,
> 	Dominik

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrGyekACgkQJNaLcl1U
h9CJoAf/TS90luzysqHpT36oUysr/MHhMQwatcObYyEFVwhYzJfWy3B0HlpFmh6A
nNsqRFbXDA8K6s7e4vewIKkke/v9lezzsuTFn5UYemwZinJzl5+LUSHWC6bmXHwt
4TKdW36F8BSD2s4nXaxxo1U+bqrtoR6h1UtvRJao4lLhbJ8pY08dK9m8BJx4ozzu
3rwb2RcZsoV+5aTJmYW3Iq4S9i5cbhBpsMo4EfKM8fM3Rf/vsHhp8o/ZErvyt8py
TSw8MoyUPwNqLxswlV5tZf6wFZ92/YI8vbMOJoeRmJEFi3xOX1AV3HQQXw62jbe5
U6I1OT9IpZcE+/kSgiEX7/CgJ6L0Lw==
=6dLs
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
