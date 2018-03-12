Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932617AbeCLHEm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:04:42 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45783 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeCLHEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:04:35 -0400
X-Google-Smtp-Source: AG47ELt9W9AEGgyxNqloS2DRwrwnraBe8QzqRAPZKeIwS0VzANEhEdXRscS+lEZRj8A7zjlyyhHc4g==
Date: Mon, 12 Mar 2018 08:04:30 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Dmitry Osipenko <digetx@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] clk: tegra: Mark HCLK, SCLK and EMC as critical
Message-ID: <20180312070430.GA23060@ulmo>
References: <699ce67980d71fd315085ea9785ee6213e0772cb.1515589507.git.digetx@gmail.com>
 <cbf3e9ff-f7e1-32c2-546d-85fd198c2a3b@gmail.com>
 <1487f4a9-d924-3366-c86a-f1bd33ebb1bf@gmail.com>
 <20180308144437.GJ3529@ulmo>
 <152061678678.13890.15810434310624804730@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <152061678678.13890.15810434310624804730@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 09:33:06AM -0800, Stephen Boyd wrote:
> Quoting Thierry Reding (2018-03-08 06:44:37)
> > On Thu, Mar 01, 2018 at 04:33:29PM +0300, Dmitry Osipenko wrote:
> > > On 15.01.2018 13:56, Dmitry Osipenko wrote:
> > > > On 10.01.2018 16:59, Dmitry Osipenko wrote:
> > > >> Machine dies if HCLK, SCLK or EMC is disabled. Hence mark these cl=
ocks
> > > >> as critical.
> > > >>
> > > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > >> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > > >> ---
> > > >>
> > > >> Change log:
> > > >> v2:     Fixed accidentally missed marking EMC as critical on Tegra=
30 and
> > > >>         Tegra124. Switched to a use of common EMC gate definition =
on Tegra20
> > > >>         and Tegra30.
> > > >>
> > > >> v3:     Dropped marking PLL_P outputs as critical, because seems t=
hey are
> > > >>         not so critical. Although, I still haven't got a definitiv=
e answer
> > > >>         about what exact HW functions are affected by the fixed-cl=
ocks.
> > > >>         Anyway it should be cleaner to correct the actual drivers.
> > > >=20
> > > > Stephen / Michael, would it be possible to schedule these patches f=
or 4.16? My
> > > > T20 and T30 devices aren't working without the 'critical clocks' pa=
tch. Things
> > > > happen to work with the opensource u-boot, but not with the proprie=
tary
> > > > bootloader. It's probably not a big deal that out-of-tree devices a=
re broken,
> > > > although would be nice to have one problem less.
> > >=20
> > > Guys, is there anything I could do to get these patches in linux-next?
> >=20
> > I've picked these up into the for-4.17/clk branch in the Tegra tree. I
> > already have that branch for the MBIST patches which are a dependency
> > for the for-4.17/soc branch.
> >=20
> > Stephen, Mike, let me know if you have any objections to carrying these
> > in the Tegra tree.
> >=20
>=20
> Are you going to send us a PR at some point?

Yes, I was going to let the patches cook a little in linux-next and send
a PR by the end of the week. Does that sound okay?

Thierry

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmJnkACgkQ3SOs138+
s6H3mw//cEDq818rOGjG8yG3hHJKUzIyIiUIt6tNUbUrAYaYUXtTr0FaetQwrV5C
KgZbnEsaNhGFpw5y9EMRNRB6f+0I9lCvz8euKC8HRtwaKzYlK4tMTzu/bXyU33Uk
qkQQMrtOaxTnONvjPEYJCkJavv5Ko0JrhYyJow5noMyYdmFzfukmneOHiDUdXzlo
g1NBkVk3yzgs3b6ToTdsS1ay+BySnp8RXW5ZVOOjEzTC6wEPdwEKMeAoRrdaq1Rg
zLHAU7hl1EDyfpAbMMHOEztgoyD404pqYqowMuibI6Hr8x5f6h6PS7tfSa0+p7U4
GZXhWrcVQy03h8hbFeUQobfdcFtEat5CfgajxZMfSUpYQCIuZGOHr50F/6lSybpu
t3qWDnus17EDCfzsD9+Uf1jwSUtm92DtbIrCur2vzwTy1ba/4awr85UrVQ/A/FkS
YkSYN8KIb4qMklS5hHq2xcKaWyO3L+5Xdn6mW9et4qm9M2/4kZe6pXrOYkbLCDWD
CMklSCe4EbNqJQXp79t6KgO8hfjGMTkKDIcdQRHtccis7WE/8W8LfN8UFr4bEsA5
XAmvRDPmUUPa2O2zwrtyoAfpNpOjqme7SQp+Gio3NQOvo+l6BoDXjAhJMYRwkfeC
1lm7Y7ofrX27Ov9yUcgKtyxgKxlQMFF56i+4acL+PaLvciMhSRA=
=oFsD
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
