Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D24A21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfACTFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:05:55 -0500
Received: from sauhun.de ([88.99.104.3]:55134 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfACTFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:05:54 -0500
Received: from localhost (p54B3379A.dip0.t-ipconnect.de [84.179.55.154])
        by pokefinder.org (Postfix) with ESMTPSA id D87952E3614;
        Thu,  3 Jan 2019 20:05:52 +0100 (CET)
Date:   Thu, 3 Jan 2019 20:05:52 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V3] i2c: tegra: Fix Maximum transfer size
Message-ID: <20190103190552.tspqarvalqxlz7yu@ninjato>
References: <1546472423-31366-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xvcagbsjzare2ch3"
Content-Disposition: inline
In-Reply-To: <1546472423-31366-1-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xvcagbsjzare2ch3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:40:23PM -0800, Sowjanya Komatineni wrote:
> Tegra194 supports maximum 64K Bytes transfer per packet.
> Tegra186 and prior supports maximum 4K Bytes transfer per packet.
>=20
> This patch fixes this payload difference between Tegra194 and prior
> tegra chipsets using separate i2c_adapter_quirks.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

  CC      drivers/i2c/busses/i2c-tegra.o
drivers/i2c/busses/i2c-tegra.c:171: warning: Function parameter or member '=
quirks' not described in 'tegra_i2c_hw_feature'


--xvcagbsjzare2ch3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuXRAACgkQFA3kzBSg
KbYMHA/+LnD+R8d8bIvoJv5o1QHm/gDf8I5+0TUCFWzj0TLrn4cvN1OM0k6O0O0K
CB/uCvCdKvpDKxMxXPC+v8TdzVK9EYJyPrS9LeXaPYHTxGuTzsiy6MPhpO4ScPWc
ELpQILlgXoU+ShA06eKcgp35rmEySZQiedKuGv/U927TbZO13glHLizFhwfRVpBl
XmWg3Hdiqljt816BLWupSI7kLt16bdbdgzEz2nPA1JzjKtsn0zimDQd7rcDuIkOw
iCP8TmlkNE6CGrcA94mi1V+EWIWjBZ0ajYoc1rMoEA80O0gKgZRwxUpupY9YCioV
mlp8fcvc34A2iw6q9hXcjr0ZPwTMTp56JwxpQqa97Yd9haaoZ7d4pXsTMTSQAOZK
I7c4T6K5pM4Tmdp2doqa7/tAdU4VOGIMUAxqjh/BDQqb5B+/afV/RziYKX0NXf4m
u3B00hfmogXLE/Lx5TxL08hROVCjV507jHcqwszrW07OkAfafz/D4BZfAmFERYh5
P7zJIoJyvbDDhXzqfw7BuNsujJep7bv41GpTASHtnnYyk2MOXJk9OSZkUc2xpsXC
ISvO3WFQnfW1+YUYFzdt/ODFOjgYwkk5RF4+76VrNUKz6aWFZfybnowXvBpg+61j
3Ub6NhuA6IQPyqL8KhtXyqTItQrmOToDL9mduWq4ehXdCwbLhnM=
=v9r4
-----END PGP SIGNATURE-----

--xvcagbsjzare2ch3--
