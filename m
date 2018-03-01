Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162007AbeCAV24 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:28:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55536 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161792AbeCAV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:28:54 -0500
Date: Thu, 1 Mar 2018 21:28:44 +0000
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 10/25] ASoC: qcom: q6asm: Add support to memory map
 and unmap
Message-ID: <20180301212844.GU12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="niUlcCfh/sMBwTxc"
Content-Disposition: inline
In-Reply-To: <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--niUlcCfh/sMBwTxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:58:22PM +0000, srinivas.kandagatla@linaro.org wrote:

> +	num_regions = is_contiguous ? 1 : periods;
> +	buf_sz = is_contiguous ? (period_sz * periods) : period_sz;

Please write normal if statements, it's much easier to read.

> +	buf_sz = PAGE_ALIGN(buf_sz);

I don't understand what this is doing, buf_sz is a length not an address
so why are we attempting to align it?

--niUlcCfh/sMBwTxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYcIwACgkQJNaLcl1U
h9BM0wf7BJhu/GsY5odkp6NACTy4X6ZG7hEyKG7kzoSlcdOkp2LTimDfQXjM6WUi
T/uWJuO2pUeR5tXp3nVZbjeyeeEjhBbNyBtxcBZFHtkh0mUyKoYxSsYJxanLcXDg
Pdgl1BWCXrNQIhyhleHidL8McBKUmz08ecsuO0aPRn52dRM0ZwIqNPcVzwpW2/t9
8YsDK6uH1wtM2G9cI6dIJCW5aKoAs7SU+jd+HiPm4PWP6df76nucNKesoFnB9qvd
4fpOubTMrCqn/f7JazBLlLT+6l1BJToHbxEBNIm9Xg7edElwxhPGUILOF5CbAgKa
RfpEpX/inf0urcCjJsgdF4AUYfHVQg==
=xWCm
-----END PGP SIGNATURE-----

--niUlcCfh/sMBwTxc--
