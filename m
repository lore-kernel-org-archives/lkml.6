Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeFEHL5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:11:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39067 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbeFEHL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:11:56 -0400
Date: Tue, 5 Jun 2018 09:11:39 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm: dts: sunxi: Add missing cooling device
 properties for CPUs
Message-ID: <20180605071139.osu2pgpg3ychdxln@flea>
References: <20180601151701.sshwfdbflic6mybv@flea>
 <d894f425b7c32bce4dc4a982db8f4dface2db31d.1528173943.git.viresh.kumar@linaro.org>
 <a313ec0be4104494de319e8318e05614fb97b2fd.1528173943.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g37vwftiwjlvzocz"
Content-Disposition: inline
In-Reply-To: <a313ec0be4104494de319e8318e05614fb97b2fd.1528173943.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g37vwftiwjlvzocz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 10:17:49AM +0530, Viresh Kumar wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
>=20
> Add such missing properties.
>=20
> Fix other missing properties (clocks, OPP, clock latency) as well to
> make it all work.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied both, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--g37vwftiwjlvzocz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsWN6oACgkQ0rTAlCFN
r3RYNBAAhAy9CYd+HioBknOi0g02dQTivylpf7IQXq/OvfawoEfYs2MF11HoLGZc
F+TjUgg722eZAqbsnEUpLFfjQr77bR5AZrjek3/rm/vS8ah48xIHAI8ODNHXk1U1
Qehh4slf9Qeblbo1rdlpJCmu/O1UT3cNUc4CfB+lHzWlN7CcH6CZosV8ZkzIOmPN
Y6W2F0EdQt4Rr7HDenxu8r8N62/HrLANqB8khrduUHeq0SBUSUDLVPe+/ql7Ay5Q
BaYVPDD8I3hjLEXuE7yRY9/lvBrA0U8nWORt6Ezt7orH0nhrhKmPJbgHd7q02Av+
b82HbYEcR5lVrMECuLmqeWEYVB/oeVFxZ7plsQczVUzuVTUfVc2DBx7gDmrV/oUX
6ItUrlGUoyeqjYlI/ITa/8WLvk0c79eUOreHeAtM0BFD1fPKb8sx0w4v+zeingk+
h6xmhUcSncSpA17hw/G/lAsJLMJMFnUnFB59/xC8PF++w3utRqSqlo2lqutcgrqV
9lIsem+TDuuhMVkcqoU+BrqhJBOcFOrk6WgATXPs9SbnPiMDjJWGNuWg26o3jRAR
v4R25wOV6h6ZCRUAmhiuZzRjyCtYJGoe3BuHSYE/4hD88gCbQwmKbY8IWRHDydrF
Xboroz/plM4F1vclt91Z9e6VSIWFKPgDmoSZtq6bIM8xEGZILKU=
=8AIo
-----END PGP SIGNATURE-----

--g37vwftiwjlvzocz--
