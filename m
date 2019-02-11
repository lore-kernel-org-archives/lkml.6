Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8C7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D48218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfBKNDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:03:25 -0500
Received: from sauhun.de ([88.99.104.3]:54372 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfBKNDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:03:24 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 9C33F2E3542;
        Mon, 11 Feb 2019 14:03:22 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:03:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V18 6/6] i2c: tegra: add i2c interface timing support
Message-ID: <20190211130322.2kpoky3scnqnxulw@ninjato>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
 <1549652382-5476-6-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4bkye3humppkadhv"
Content-Disposition: inline
In-Reply-To: <1549652382-5476-6-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bkye3humppkadhv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 10:59:42AM -0800, Sowjanya Komatineni wrote:
> This patch adds I2C interface timing registers support for
> proper bus rate configuration along with meeting the I2C spec
> setup and hold times based on the tuning performed on Tegra210,
> Tegra186 and Tegra194 platforms.
>=20
> I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
> and Tegra I2C controller design uses them as a part of internal
> clock divisor.
>=20
> I2C_INTERFACE_TIMING_1 register contains the setup and hold times
> for start and stop conditions.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Are you aware that we also have DT bindings for various I2C timing
values? They are usually board dependent and not so much SoC dependent.
Please check here:

Documentation/devicetree/bindings/i2c/i2c.txt

(Oops, I noticed 'i2c-sda-hold-time-ns' is missing from the docs. Will
fix that ASAP)

Just saying. The patch here is fine for me. DT support could be added
later, if you want that.


--4bkye3humppkadhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhcpkACgkQFA3kzBSg
KbbhlA/9FCo0jVarCrynNCdeB35XuleWof72pbNGpxamQ9xuXJDge95ebprLP2GK
wQEe8JTJjcjjsPLhPWUBhEsRKVGQiS3mX3r96+jJkx/q43NyW+dMT/KE24QdO1Y7
xHnrHdpwJcCLUwzlsHfyNCSWNkR/mXtjCOjI/5oeUmojIn4rGs2n+ML1RAYX3SaV
KweLIpJmDzh5SSDo7rDq28sa4qrn3RTBm6tqKDu5v39neIN4OCVpv2tFIhRcqqFe
YtFrfBnnSPqTHTwCZQsyreiYu2V0yhSQqWxgCfE9dHlv1vGG5RPuM6hld/3Iv9q0
eaaEQzzmQD8cuJxoRp7Hq0Chyur+T66fq8D8EZxkQMUcfVo/jyPBm5ZYwRDebKxO
6d/5RkfyUspYK+2XxVuppdZSheEtq3DQxm6agEMuBN12pI6473FX99U1EyVtDxzi
utrVVF0pghKJhPOJ8aOLX3i35OE2/PijKgyyoWdCrmd1qktAzw7d8PWVL/BUDVgg
I1yAh931HvmGwyCdn4QLlvoBBd9Kjm9B7jPE95vo66mHD3xODqnQF0gooUpGUoxh
6PL0kpkIG7mMShLXPRK8ncS6ZBaPDCfBjcs3w6np/wEtR2xVoclaMquExwJpMxI7
lFVNCavrRTz9KY5qVfP1RQdjWzI5zIZ/ycjc7CgWlwY8zFELSmY=
=9Y5V
-----END PGP SIGNATURE-----

--4bkye3humppkadhv--
