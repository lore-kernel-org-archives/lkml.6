Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeCNQ0S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:26:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46136 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeCNQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:26:17 -0400
Date: Wed, 14 Mar 2018 09:26:09 -0700
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: uniphier: evea: add switch for changing source of
 line-in
Message-ID: <20180314162609.GV2186@sirena.org.uk>
References: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yC91f7qSViS67v3c"
Content-Disposition: inline
In-Reply-To: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yC91f7qSViS67v3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2018 at 09:39:00PM +0900, Katsuhiro Suzuki wrote:
> This patch adds mixer switch for changing audio source of line-in.
> We can choose one of LIN1, 2, 3, default is LIN1.

I'll apply for now but this should really be a DAPM control so that we
can power down things connected to the disconnected line inputs when
recording.

--yC91f7qSViS67v3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqpTSAACgkQJNaLcl1U
h9C9rQgAgmE9TKBiE3nsqvlGYbZvo9M7OHd5IBS4MzV1cE62LKFZtwiNPqlblh0B
ODHwTtnjoYe/wceENo1Wu039D3on8lZH0jIwidq63+LDRcIabSzG444HNzkNB5Wh
Cg0PErPsyO8D3TCLLmjsFoUIbrgqcPYPq0BaFwIABy5vm/BkbL9TtDYoSG27uwbL
U+dD1qtYxA/UJ/oEN3M8QfO3XqiSmrWxDrNrCoy5tvR8Oi4K86xg0GLFbdaGnNKk
E4HMxHtqfIAbZyFb9uHJcq2sYdvffKyhAhj9rKBaFU22VOgc9Ih0UkR+8TJLrbAE
3WMJZ4kz/Y2oJdAxwkp8ANRGpa9k6A==
=2NzJ
-----END PGP SIGNATURE-----

--yC91f7qSViS67v3c--
