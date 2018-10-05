Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04E0C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F97213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F97213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeJEXHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:07:30 -0400
Received: from sauhun.de ([88.99.104.3]:40326 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:07:30 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id 827F12C7EC3;
        Fri,  5 Oct 2018 18:08:08 +0200 (CEST)
Date:   Fri, 5 Oct 2018 18:08:08 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] i2c: zx2967: use core to detect 'no zero length'
 quirk
Message-ID: <20181005160807.zq2kyfggeksbalf2@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rfpvimj7pxg33722"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rfpvimj7pxg33722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:13PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--rfpvimj7pxg33722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3jGcACgkQFA3kzBSg
KbbR4w//cpkcbNMbmv0DOiZRjAHX/HpmmF4E0rxmRFiX24rEvZrDxuh1M8ChlvE4
54fi6tf8X2qtKqybqbIcuoQlSNHjCV8eZLQBkl7umKUgCPSicmlxk44Bd1XzXqvf
DzZMzZSrexSN94SUYFlvqT7bK14fab460kaNl0pp3QCaQhtiNEi38xkTAdXWyO2R
aR1Jxw44E7jDGPNg49r+TjuDxU3Ju07WfVbXuRJ2T5SATuMNQKIDI5YnpyGi8XAq
SWZIRf8m5M4HUVa08JK3BQk5aSID9ADVXh3AwqN6FueRjaG7RF+ItiTNZ8JyvZff
ob6z/B7WZH33eHhuOm+cDMOiFjqtiqwrWhH10bfgGCCDEgVP8QKJTwLJvybmOxqx
sAChXiEWpDqOMpMQUynXbiBL9LDOX6AtL49U0c5eMvjTa8apF+AKXCTtYsZVynDG
T19rm2qEgpZqHx2CS7a0tWKSIP8OOhKuFEk9vsT0i0ZJJ2m4wwYFSt2rA0eNKr8v
/83n7jrCNvFu5Kg/avAipStx8RpcxwUYwueQ8gRELc9kx0XxJyaAyytYhgCir+jf
Td7VvtD8TBp4A6YSULHZf36cFNQkXcymHpxJmqI3dCn6Tjy831+4cV3FB2iPPW0V
qY6CUZahWGwzeZ8Wm2hdr4dQM0W/C4a4ASLJzvs1RRzZXtW9IY0=
=qAhN
-----END PGP SIGNATURE-----

--rfpvimj7pxg33722--
