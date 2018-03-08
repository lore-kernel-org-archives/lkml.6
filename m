Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933827AbeCHOon (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:44:43 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33115 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeCHOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:44:41 -0500
X-Google-Smtp-Source: AG47ELuPB3VLJeq5PBTHYZ29HWg9fMOjxxdqf3xvwGaVkigUg5KdKaGAyVTHmyB8AGc6jMqOq5fFLg==
Date: Thu, 8 Mar 2018 15:44:37 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] clk: tegra: Mark HCLK, SCLK and EMC as critical
Message-ID: <20180308144437.GJ3529@ulmo>
References: <699ce67980d71fd315085ea9785ee6213e0772cb.1515589507.git.digetx@gmail.com>
 <cbf3e9ff-f7e1-32c2-546d-85fd198c2a3b@gmail.com>
 <1487f4a9-d924-3366-c86a-f1bd33ebb1bf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2uG6jHjFLimDtBY"
Content-Disposition: inline
In-Reply-To: <1487f4a9-d924-3366-c86a-f1bd33ebb1bf@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2uG6jHjFLimDtBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 04:33:29PM +0300, Dmitry Osipenko wrote:
> On 15.01.2018 13:56, Dmitry Osipenko wrote:
> > On 10.01.2018 16:59, Dmitry Osipenko wrote:
> >> Machine dies if HCLK, SCLK or EMC is disabled. Hence mark these clocks
> >> as critical.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >> ---
> >>
> >> Change log:
> >> v2:     Fixed accidentally missed marking EMC as critical on Tegra30 a=
nd
> >>         Tegra124. Switched to a use of common EMC gate definition on T=
egra20
> >>         and Tegra30.
> >>
> >> v3:     Dropped marking PLL_P outputs as critical, because seems they =
are
> >>         not so critical. Although, I still haven't got a definitive an=
swer
> >>         about what exact HW functions are affected by the fixed-clocks.
> >>         Anyway it should be cleaner to correct the actual drivers.
> >=20
> > Stephen / Michael, would it be possible to schedule these patches for 4=
=2E16? My
> > T20 and T30 devices aren't working without the 'critical clocks' patch.=
 Things
> > happen to work with the opensource u-boot, but not with the proprietary
> > bootloader. It's probably not a big deal that out-of-tree devices are b=
roken,
> > although would be nice to have one problem less.
>=20
> Guys, is there anything I could do to get these patches in linux-next?

I've picked these up into the for-4.17/clk branch in the Tegra tree. I
already have that branch for the MBIST patches which are a dependency
for the for-4.17/soc branch.

Stephen, Mike, let me know if you have any objections to carrying these
in the Tegra tree.

Thanks,
Thierry

--J2uG6jHjFLimDtBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhTFUACgkQ3SOs138+
s6HkiQ/+O0EfjH6ZS4NOtc7o8vllzUKFMVlWp/b/GfzgQYT9Pab3GAgJhR0HxFN9
zmKxaO5MxiWZnD4PNR5J9ZpApe5oDMt7lmOHoa7VeuXQCqVvC3Ykf4NbR8YAZ9Cd
O4i8dsSqeU7QRpplvCkYiRauWRfl09NZiPtn60xHXQyFwE5r/k2ZXcmYrP2mkKjU
fgbIYJBNixxCtCsa/hjAVegi2woWy+3YdygIdo/buDtNUAQsLEX4QmFnbFmie0Lt
+O9nDeTCfRh05Bq3MrC55lC6UrKyNy012Sdf//fgTlyF0eDVlkqWiN+4yHhvpSMO
PpS3aiAekYod0RfxVmfRseNO26e7Mu+9QlyxY9EEgDs+RY6Nv5pTny3b606K5b6w
dtTnJmzX3jVYEiRGl1I5efCKwf1VuinyF9e/uEArI+BzK6yefIqsMzsZo76LZWSs
y2db0ra4E9astiyShVjEy5F14yq9R59XGZ8wemYNLyjkJwqM15bnBDFtxKDY7+O1
UcvczgBwRzjaYZOj3OHHeQnk68IBwgieHDHhr9srloox00usLqkgqlz/JdZ6Q1IM
pq7Bys6L3MZv9X0H1Se6ie8kuJMLKOea5r8VnHZDiZSDF6glm1Bk8RF9eGukcPnn
xkrQKwbqVK+jBPa5fGWSR4fdM9Cm+WMDj4PQ+6yZrZprVBSpf6A=
=rzzQ
-----END PGP SIGNATURE-----

--J2uG6jHjFLimDtBY--
