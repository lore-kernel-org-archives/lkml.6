Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754879AbeDWLu6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:50:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51552 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeDWLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:50:56 -0400
Date: Mon, 23 Apr 2018 12:50:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: sean.wang@mediatek.com, rjw@rjwysocki.net, khilman@baylibre.com,
        ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
Message-ID: <20180423115043.GD19834@sirena.org.uk>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
 <20180423100318.GA19834@sirena.org.uk>
 <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
X-Cookie: I think, therefore I am... I think.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 12:11:01PM +0200, Matthias Brugger wrote:

> On 04/23/2018 12:03 PM, Mark Brown wrote:
> > On Mon, Apr 23, 2018 at 02:42:44PM +0800, sean.wang@mediatek.com wrote:
> >> From: Sean Wang <sean.wang@mediatek.com>

> >> Similar to the readx_poll_timeout() macro calling ktime_* and using=20
> >> ktime_t type, which is declared in <linux/ktime.h>. So, make

> > I'm missing patch 2 here - what's the story, are there any dependencies?

> You can find the second patch here:
> https://patchwork.kernel.org/patch/10356237/

So it looks like there is a dependency here...?

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrdyJMACgkQJNaLcl1U
h9DMMgf+Mq4XuE2uTjJ3RczmwV7XtbZbOyfz9skBzZlxHIMLgev1gD4PsrI5xDiC
tSdlZKU7hE7+K+h2ZQ+LT95qpf4V8xK39zALPjqy+24FJuNkfKG6kb1AROqta+dX
LQ5dlTIz0xmLfZ7zkCOWmm0oyeCbc/k/d9nW815ULWk0vRTOgjUmVShy9ARpj3z7
YZGijwLH2MEaMFr7LBmk+SJiYvsmkSY5/Ie5umu3VWiHta7r05tmcI/kg9ugggt1
CwUk3T3s787dJLoVvhFPJVdRgG+2SL0ciDq2WkI4geMZ5EWuj0d6zY4I5AYEJ7sD
gL0OnsG348CnPSKl6TWMfb4wfiCWcQ==
=oz9q
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
