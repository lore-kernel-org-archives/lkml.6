Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeFDLAZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:00:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50926 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeFDLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:00:24 -0400
Date: Mon, 4 Jun 2018 12:00:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com
Subject: Re: [PATCH] ASoC: dapm: delete dapm_kcontrol_data paths entry before
 freeing
Message-ID: <20180604110015.GD7536@sirena.org.uk>
References: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
 <20180604104541.GB7536@sirena.org.uk>
 <e37bf559-b040-db34-6273-d4f8ea1e2284@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <e37bf559-b040-db34-6273-d4f8ea1e2284@linaro.org>
X-Cookie: One Bell System - it works.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2018 at 11:55:10AM +0100, Srinivas Kandagatla wrote:

> I agree, Do you want me to resend the patch removing irrelevant sections in
> log?

I didn't actually apply yet so yes please.

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVG74ACgkQJNaLcl1U
h9AQ1gf8DBYRwcKrIj7qssKEass48R9qjvB6z6chkFIwZS31AYXNPBvfFxIqNpbP
N93H9yvYaAwCAuXIca9gsquvByz427etse9yOWqY11HVnJ5Jyby1KtTksc4N9xib
so/C/64xKWeA1y2CFgwg8drPznjEM8hs/8ptgKxsVi6gNvmt56H3+xJzxw8A7M0A
wpizIOgQyLFnsKJzlf/rFby/AldR4evSwNhsfRwBuOSNxcWVHf9EGFlP/TMG8w0z
gb1HkKaH40x6nns6Xpu74gwbudznofP/qvkMYSM2VWlBZQreZK8MM7ahyoGEt8h+
PUp2Ner7CDP/5OU0AnTkb6+AJlHkVA==
=Frk8
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
