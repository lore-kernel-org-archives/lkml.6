Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeD0JhH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:37:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38944 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757538AbeD0JhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:37:04 -0400
X-Google-Smtp-Source: AB8JxZoEkDn/Pwk2MSgEiFe6xNpcjsnNwR9zLYz8O9FfJslcL3l6YegCWI2nfmWrba62J7J3Pns7Uw==
Date: Fri, 27 Apr 2018 11:37:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/15] memory: tegra: Remove unused headers inclusions
Message-ID: <20180427093701.GJ30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <1edd1ed575d21c96f0810bd226bee4b5c315f3db.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
In-Reply-To: <1edd1ed575d21c96f0810bd226bee4b5c315f3db.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:30PM +0300, Dmitry Osipenko wrote:
> Tegra210 contains some unused leftover headers, remove them for
> consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra210.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied, thanks.

Thierry

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7z0ACgkQ3SOs138+
s6Hllg//ZX+RWT8FJZSERsHG6imOoJK72rHBIyms3I9Cwy64Dw4Hh2o1WYD39QrK
1cE9JVp4Z08bm8Wd3/Ev/h58hTxYoEBhQ/lEr5tHuRGsEff837gzTig4Gqft71Qu
mUBnTrGaJhXwsOhgXDfa3ANAMyJ9RoqMOfUexMXmZ8yIR+zmUtXvLwcAejsBxlEN
9pBFepB5Mpo3k9AuhXWbxieZ/ME3PLVBYxB86dvPBPG6hf5fAWvrcyxr9DVQOWvH
72m36vqmgcUbBMMR+PVP5WiC87ktSWSppKm1EVqxmUz96jMGpn0cWg+x0dlKCZTJ
nHdSnnCojnkK3F5H11L3KuOl7ysWys7b9S2ri33TGf5OvhS9CaORFdWZxwVV27Ht
XbEOtSOXued8nwI+wxEqLXZR6/toW+lmnuEVfI1618gHEp51EZHIjRzweBICmvUf
IHOFnpq9fEwYBdQ7cUb4wU5s/RJt4EpTb0oNDhTcgMtoSIRxdIhHQt8EFJgwWXCR
23S3ZfupIUVQVRKsjXw77C/2rU3Iemb14TckYIGx14t2KrtTY3vq7pIqr2D8YGfo
g1wWlvAGRMu00ysidvnwPml5I/9LUatJ0VdDPIpzO0M1ZQGf8KsQ1vuCv8sc/l/V
ZHICbHa7KE9NnBNq1dFkeQkaVHKJ1UT/YyoysOypo2/Zh9h9roA=
=7eYM
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
