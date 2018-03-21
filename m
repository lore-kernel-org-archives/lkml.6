Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbeCUB2N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:28:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40320 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeCUB2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:28:10 -0400
Date: Wed, 21 Mar 2018 09:28:03 +0800
From: Mark Brown <broonie@kernel.org>
To: Masanari Iida <standby24x7@gmail.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] linux-next: ASoC: mediatek: mt2701: Fix a typo in printk
Message-ID: <20180321012803.GR2186@sirena.org.uk>
References: <20180320123309.12333-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8tL1MfGjVkXqw1I1"
Content-Disposition: inline
In-Reply-To: <20180320123309.12333-1-standby24x7@gmail.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8tL1MfGjVkXqw1I1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2018 at 09:33:09PM +0900, Masanari Iida wrote:
> This patch fixes a spelling typo in printk

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches - the
"linux-next" here makes it easy to miss the patch.

--8tL1MfGjVkXqw1I1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqxtR8ACgkQJNaLcl1U
h9AmfAf+M+6SJQsSArxc3JdS73ZdHmTfBvuw0RnS0UixlpfoYK5FJWp/7KoRuJH1
YaSVRiG3kCS/4R9t/q2zDknOxm5Lr5ogRD0exdPc/Jm3UR12pSN1QaidapbbGm+e
F0RrJnT+KiNsR48pDlxak9B54Ffi5rz5ymkhxv+Ykc8+j6v+p6Xukb+PqMoZLLCS
hs/knoe0rH4QeYlG1EcEfIAFdN6EHZPGYoWV/zEu+ra8SA+J2Wl+gtFRi7986Oyh
GT8MncJPfNi3n9i+nJMACf5FImAesSOVDkErTZyLtE202PXv+NMAIDqVSZHSYGcY
0MRyT7LM3u0346PsMDiBErgM62Vvrg==
=E26G
-----END PGP SIGNATURE-----

--8tL1MfGjVkXqw1I1--
