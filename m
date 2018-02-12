Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934727AbeBLMtG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:49:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBLMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:49:05 -0500
Date: Mon, 12 Feb 2018 12:48:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com
Subject: Re: [PATCH v2 0/9] add UniPhier audio system support
Message-ID: <20180212124858.GC12976@sirena.org.uk>
References: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
X-Cookie: What UNIVERSE is this, please??
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2018 at 06:25:27PM +0900, Katsuhiro Suzuki wrote:
> This series adds support for Socionext audio system for
> UniPhier LD11/LD20 SoCs. This driver supports I2S output
> for Line-In, Line-Out and S/PDIF output.

These look fine so I'll apply them however a patch series from
Morimoto-san (CCed) moving things to use components rather than
CODEC/platform/whatever driver types that was sent about the same time
has just gone in - the driver will require the same conversions.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqBjTkACgkQJNaLcl1U
h9B97Af/WZ98YjR9pqKv2q9x07O8um3kwXtYVGFUp3gFYX13OQZUW+sfFSg1q2YG
W7386wNTVqEYCyA7w2O024GFRc62ued4u2vjt0VlegFTkEt8xhc07DLEjvFamGwl
ve6DxpuOVwd9UTQxeuiq/xxQE6wtDXKjX/Xn0u9+Zc+2w0dQGyZCX0AE9jgb/dD5
vnsn7+3EPa8uip7x4Tnur8Y+aXJl9skenvuJ0jGIWgahclRKd/nXpNxxVHcwJmJc
ZGSD4fca4ORnPMaV2UDNavg+fnZIZet4uJaIBBHVP68N+Cn+htpOlxuVCdHj1UZz
J0vPIhagpoWOl7k843pQgtUROpmn7A==
=J7Qc
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
