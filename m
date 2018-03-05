Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeCEQHh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:07:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35170 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCEQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:07:36 -0500
Date: Mon, 5 Mar 2018 16:07:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: brgl@bgdev.pl, david@lechnology.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: regmap: Failed to create debugfs directory
Message-ID: <20180305160733.GM8588@sirena.org.uk>
References: <CAOMZO5DhpG+68CtrVR-nYbD3gjH5zoPiTqdz3NcUqSW5iJsOLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SEFvVLxbW/dEDtN8"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DhpG+68CtrVR-nYbD3gjH5zoPiTqdz3NcUqSW5iJsOLg@mail.gmail.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SEFvVLxbW/dEDtN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 03:28:37PM -0300, Fabio Estevam wrote:
> On Thu, Mar 1, 2018 at 3:19 PM, Fabio Estevam <festevam@gmail.com> wrote:

> > Running linux-next 20180301 on a imx6q-sabresd the following
> > regmap-debugfs warnings are seen:

> This only happens when the regmap name is 'dummy'.

> [    0.083651] vdd1p1: supplied by regulator-dummy
> [    0.084929] vdd3p0: supplied by regulator-dummy
> [    0.085974] vdd2p5: supplied by regulator-dummy
> [    0.110028] *****regmap name: dummy
> [    0.110090] (NULL device *): regmap*** Failed to create debugfs directory

Do we know what exactly is creating these debugfs entries?

--SEFvVLxbW/dEDtN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqda0QACgkQJNaLcl1U
h9A+pAf+K/mVVUEc/B1irf9JfOxtSv2wjvGC90dJUG1VbH/8FPy+INh2WeSHPEfd
NISkyronS6+ixQ7msaekqwmm7+G46GJ7mJxPwNSmQD/2PFs5GPJoZOQl7LWX4ESX
ZHtDElAPBk8LLItf/KQz2TmNdd5wId0vLKGjtWm6Ux3TcXJJ8mxvcWpivg8/Erp7
Kr4ruP9KH0ZhsvEBvI/27ouECRTN5Fu1/kgAprOfJVHT+0Nn+t7Pz60bIX1GC7DW
PG2JO3P2d0xqemvSpAGJ2tOIUFEHsEuORr4YRepKMxVKa2jAXgjvoSqgPzrlkvQj
rpoq5PNJQ4fUIAQu1BMAG8M0Mb3tnw==
=aVOG
-----END PGP SIGNATURE-----

--SEFvVLxbW/dEDtN8--
