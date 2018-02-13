Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934484AbeBMJNv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:13:51 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:45204 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeBMJNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:13:46 -0500
Date: Tue, 13 Feb 2018 10:13:34 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] ARM: dts: sun[4-7]i: Remove
 "cooling-{min|max}-level" for CPU nodes
Message-ID: <20180213091333.rq4rtvvkwppn5ypu@flea.lan>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <4d489d040ec1fc3821d8e4bf31ffcc2eebfa41e1.1518166039.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4d4boujzcki57u7y"
Content-Disposition: inline
In-Reply-To: <4d489d040ec1fc3821d8e4bf31ffcc2eebfa41e1.1518166039.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4d4boujzcki57u7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 02:28:04PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
>=20
> Remove the unused properties from the CPU nodes.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--4d4boujzcki57u7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqCrD0ACgkQ0rTAlCFN
r3Smyg//QoNE7NIhBDcwyZ4ZhLCECasqLnAoCYZItq4CRCJ/FQ3imxHApe2RmK/W
MKAcMtsAiIfQlenLAocUVkG/KZ2al6p5vqjMp1xz+vV6WLOeBOOfhVnEpYEhWuYz
lJ/wlyULmzl1NQvCS+RB9y/VIbC8ppbjrzFpChBd0+4u6rA9bgS/0D41Z0bB7JNA
uyGT1vAX3y3gR7jxUAQz6YiDFOSi6E46M6j/QOSKzG+LLYtvLc5NaBv/GyyJUOPe
GCZkNyO+OMIZmRX7871wKlUwzkbsN5AIKd8V4GhmR3qmwzmK0JM2oSCkE/AoJVhq
ajOM4yKT8SnVuowSBPzvP4dtj7uthg0CiFlXqVvpVjgoTz+Q81p6HIjJvnqSiv38
8sem21Dii6M3sQgek4aV8s8gYMwODzyha2zP+oeq0SqeWfEKNXXNLsIJd9gYKyA3
3FpUPOxoSDusTa+aCfww8TRj1s9ALWFJVBpbleirxIqDOr40u/k40Nwlzp4rEAOY
DkrDbNpglmJ/HU/E10xFB7vAmUxggXT6RwBPdI5luZWnmpaWobATAs2RJ2WGdVWm
AHF5kiFec8BO7BSTqudHUeU9bXJiwm9/MzDOFt51B0DUyW7T/vs3HlhykrfsbfJa
p5ViZTApOwKXrj+bbm4EiRxiaoE4Y9wMbOGS2762azw2zzNTABw=
=T13h
-----END PGP SIGNATURE-----

--4d4boujzcki57u7y--
