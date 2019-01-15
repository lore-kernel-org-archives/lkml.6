Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C22E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbfAOVzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:55:52 -0500
Received: from sauhun.de ([88.99.104.3]:53666 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbfAOVzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:55:52 -0500
Received: from localhost (p54B332B9.dip0.t-ipconnect.de [84.179.50.185])
        by pokefinder.org (Postfix) with ESMTPSA id 8262E2C9D2D;
        Tue, 15 Jan 2019 22:55:50 +0100 (CET)
Date:   Tue, 15 Jan 2019 22:55:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabio.estevam@nxp.com, leoyang.li@nxp.com
Subject: Re: [PATCH] i2c: imx: defer probing on dma channel request
Message-ID: <20190115215549.sepj7rmpqmtlxwbw@ninjato>
References: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4k6sn2i42q7o326p"
Content-Disposition: inline
In-Reply-To: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4k6sn2i42q7o326p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 15, 2019 at 04:03:32PM +0200, Laurentiu Tudor wrote:
> If the dma controller is not yet probed, defer i2c probe.
> The error path in probe was slightly modified (no functional change)
> to avoid triggering this WARN_ON():
> "cg-pll0-div1 already disabled
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb=
0"
>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

I just applied this series to i2c/for-next:

http://patchwork.ozlabs.org/project/linux-i2c/list/?series=3D85099&state=3D*

I haven't checked carefully but maybe it fixes/changes your issue? If
not, your patch most likely will need a rebase on top of the above.

Thanks,

   Wolfram


--4k6sn2i42q7o326p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+VuUACgkQFA3kzBSg
KbY/xA//dY9GghhTgU9Ej+l+O1rAOHeUxYTJCWoZ4iUqpPdikDeUeTfMtNAxkpq1
G5XDZqktjN2SuWGbkGZmc2RJ5V5nNq7sMkwr0JxJwF82ViieNiorQB9ZMfor49x2
HZoiCsDVSUU91AbjGdbabffzYgFjylqTS3u1xUPae+MCWfcfOoNLpqfcxNo+qwqg
OQ7SaHwdWSDnkJv+aHXPZzg7O7IdWlDP9+TWRCOVfIWxfv96iZVFXEg7utuztuwj
nSuWRv0lNliAiA8OfcO59791J9aqSrHbD5it15KftdFZBMef/+JD9nLFlTPQnRXo
9KsZ1SNHo2otE6rWwoRID3fmTu7baccvmoCpllR3gn5ARSKeqqp2uf4zdSC5nkwD
d4b3AOppV9ZrPgiG9gzTH/zHFFcKGvkQZuW31Jg24/Dy0gcVyCEEhgR6b4Fc6vYR
qM7Vf+UdewNvdPOyYAAeK0h/xPdzLqyP9TJpQiumypH2eK8JGWmiMwjkfGp3bLUj
7vOfXcvRxLbp4LWXvvcEgwPddBfMTmLeNHGNCmppUUTFH9KsBG6okkskjFGw89kT
1HlwB3XsubRf/onryTWZ0CtZByn7Y+LWje/Pnh4RigSXc4Le/4tW5e/3xHrv3R6C
cHnUg216K+XEtPl9JfCwxjGoPvUPcWox7SJ6NvK4Pb1Nn46CEeU=
=xrXd
-----END PGP SIGNATURE-----

--4k6sn2i42q7o326p--
