Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755938AbeCHPN1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:13:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53004 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbeCHPNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:13:25 -0500
Date: Thu, 8 Mar 2018 16:13:22 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: sunxi: mc-smp: Split out SoC-specific device
 node lookup sequence
Message-ID: <20180308151322.pz5p26r6bdyngxok@flea.lan>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-5-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kp4ihnhg32prhomx"
Content-Disposition: inline
In-Reply-To: <20180308150012.19045-5-wens@csie.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kp4ihnhg32prhomx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 11:00:12PM +0800, Chen-Yu Tsai wrote:
> The multi-cluster SMP code maps the address spaces of several hardware
> control blocks. The device nodes for them are SoC-specific. To help with
> supporting other SoCs to re-use this code, these bits should be split
> out to a separate function tied to the enable-method string.
>=20
> This patch splits out and groups the device node lookup sequence, and
> adds new data structures to have the newly created function tied to
> the enable method string. This structure can also be used to encode
> other differences between the SoCs.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kp4ihnhg32prhomx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqhUxEACgkQ0rTAlCFN
r3Si6g/+PiEOy4bSG1Vv+GHsBt+wlcyM7Z0ifEhSi4D5d3PgQpUxJjf9q+DOvSTH
GUqya/nqBd2xlXX2pGAMQQE4oivMAm+iT/oVBx4vmwDHVgKAjhei0y9LFftxiV4R
rTO7dtYayEDFhrzWPJgAqvlXJl9dYTNSvez8Bfc+NLFK2dCk8Edj8f0fZwZig5aO
daP5wsWyAwl7lTX4Q0Ym0MEpPZYY2uODsfl5zwbNfSo7hWEb4AzTYYF2JkUIBY88
Wqd0wMYOqDQMteykvJesOPdR+7SgAppaDueELkIuzjCWYoy2A7So5AHR0Vaj8MQo
GR79kW2OVI8ybnCTmd5CwIhq3yZDKjB00BxvU75URQ4QExbG4bYDBjIS8e/8OiXf
1dw07vTQmOIWI/GaaZxNU++4JDg0Y5JwIu6/nlzdPcMP156BkUmYBBBS7kNkKpMW
legQ0xpYR0Jtn5+/QV24o+0ue/kUCNKynq2h3ALOin/PWLEdG+RCDzxSTqQrYtVB
TTSNdsL62JfPVkdR96cTm6cBpAMtyI6PdOLaluidwwyUQNN+BnkON99BSx+PA5mq
Dur32iTjuGPq/b+8H8p6yvX//hdP4X5l7QinsRZDLKPPAdNhnNMFlcpwy6tHN3bY
/osY8i7H5PLBpX3loka5TAl0VERcE6vPMuYZzbE7AoE+2kYtPyQ=
=L9Mb
-----END PGP SIGNATURE-----

--kp4ihnhg32prhomx--
