Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeFAPRP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:17:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57742 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeFAPRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:17:13 -0400
Date: Fri, 1 Jun 2018 17:17:01 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] arm: dts: sun: Add missing cooling device
 properties for CPUs
Message-ID: <20180601151701.sshwfdbflic6mybv@flea>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <eded393f4b508a1f377f9af6859a3b82a6787e1c.1527244201.git.viresh.kumar@linaro.org>
 <20180528084446.g24fphqqac2hi3rr@flea>
 <20180528105734.bkplm7tfaqsurdrn@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kyrkd2ck7f6qrool"
Content-Disposition: inline
In-Reply-To: <20180528105734.bkplm7tfaqsurdrn@vireshk-i7>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kyrkd2ck7f6qrool
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 28, 2018 at 04:27:34PM +0530, Viresh Kumar wrote:
> On 28-05-18, 10:44, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Fri, May 25, 2018 at 04:01:52PM +0530, Viresh Kumar wrote:
> > > The cooling device properties, like "#cooling-cells" and
> > > "dynamic-power-coefficient", should either be present for all the CPUs
> > > of a cluster or none. If these are present only for a subset of CPUs =
of
> > > a cluster then things will start falling apart as soon as the CPUs are
> > > brought online in a different order. For example, this will happen
> > > because the operating system looks for such properties in the CPU node
> > > it is trying to bring up, so that it can register a cooling device.
> > >=20
> > > Add such missing properties.
> > >=20
> > > Fix other missing properties (clocks, OPP, clock latency) as well to
> > > make it all work.
> > >=20
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >=20
> > The prefix should be sunxi and not sun, but it looks good to me
> > otherwise.
> >=20
> > Let me know what your preferred merge method is.
>=20
> Please pick it up directly and send it as part of your pull request.
> Do you want me to resend or can you fix the $subject ?

I just tried to apply it, and it failed. We have usually two different
PR for the H3 SoCs and the others. Could you split the H3 in a
separate patch (and fix the subject in the process?)

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kyrkd2ck7f6qrool
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsRY2wACgkQ0rTAlCFN
r3SrDA/+LL4BAKeV5gwtJH+GbspXsxJ5OqCeswBd20Cuw8XFn89xR/6p+BrYVvZP
24Hv2nd7mhVHW9DjtQ50Gugd6e2wiEk0FaxQPCPki3CViWwEqceWfKJvYzp9iLHT
We5xrLzr0+WHuRN1ngC9RIO2M2FR6acEJEIPghb7MlQ1V+cgYjaADjTIm4HQa8Ox
2fkrrrZZmxmICw+eaC1ZTbtVIL49dT0w+J5PtoMtuZwjyxXPUc51nmuHR2YD2JPF
QNXFJh12MeDTx5kex6b8FYr2j4EWp/lyjUG0UU4/FYqgCqxjqD8FI6aFNsBy0wVV
Nv8Hxt17jYOggl/m/e+bmntQGwl1u/V5v7TSJ3IOp6QqRuX8w1fGUs1d6PQ+6Dfh
0Nj7YwmoypOcBygWR/h6gquDw+YIOceGeq65oVReRFIn8ExMSFY0zms/JyYUDl5u
FjswzaJ3mR7n9ATlPvLdTIXHcNzbGLVRT8kjJdx/DGXSEoddCRdzGftlTt/+YXyD
0uG2396xwafRM+8g0PZeotuPJRO7hFi/U0bZmxuYH+ZDbY53o/yybciaSdyDo82L
AqZEAy59RKGk5/ZGuVn2am8GognKw8Akbn4YXBHtxmgKt3uIm/POW8V52tUHXzxT
QQvkdbME7Im3IoY1yPVoGWjk3/U0OpTMjQO6oOC4an6XAgEWwmU=
=6pOi
-----END PGP SIGNATURE-----

--kyrkd2ck7f6qrool--
