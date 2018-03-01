Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161680AbeCAUlr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:41:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161629AbeCAUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:41:45 -0500
Date: Thu, 1 Mar 2018 20:41:33 +0000
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 04/25] dt-bindings: sound: qcom: Add bindings for q6afe
Message-ID: <20180301204133.GP12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9pS2hy4/DrI8BQlq"
Content-Disposition: inline
In-Reply-To: <20180213165837.1620-5-srinivas.kandagatla@linaro.org>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9pS2hy4/DrI8BQlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:58:16PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

> +- but must contain the following property:
> +
> +- compatible:
> +- qcom,apr-svc-id
> +- qcom,apr-svc-name
> +- #sound-dai-cells

Property or properties?  It's a bit surprising that both the ID and the
name are mandatory, does the name actually get used for non-diagnostic
reasons?

--9pS2hy4/DrI8BQlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYZX0ACgkQJNaLcl1U
h9DVswgAgNJ4G1f96WfH9ZdNbYjqbFopiIHLA51w5qPJCavaMFl900adibi+E4Wd
I77+PJxyz5HuLtxuZi/ioi2rzhy7HVoPRx/laRpn+PgVE5fwtUfAIHCL4/tqBpA7
e/rqmW5dbv1H/OuG8sICw164RmcpSB+9IQ03IiJS+sfIP3qRv4ygPiP1353Ba7Jw
zBER6PLEQ2VL+ASqf/Bhdu4pLJfAUu9OgFoR+7DpK6AFskRaLFCsYqKs7w2y4LWk
1RcNXjflfvfwlXKO86oONrNcB8wiJSGp8gbRXLEDIG1ydJnr4hLLJ1hjkgl+HwTN
Ux/aViDUZMRPrqBWIm7mtDotwLUmvg==
=tDFr
-----END PGP SIGNATURE-----

--9pS2hy4/DrI8BQlq--
