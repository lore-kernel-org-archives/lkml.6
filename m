Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE013C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE232177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE232177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeHDXCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:02:23 -0400
Received: from sauhun.de ([88.99.104.3]:58816 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbeHDXCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:02:22 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id C6E60684D94;
        Sat,  4 Aug 2018 23:00:24 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:00:24 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, afaerber@suse.de, linus.walleij@linaro.org,
        linux-i2c@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
Subject: Re: [PATCH v8 5/6] i2c: Add Actions Semiconductor Owl family S900
 I2C driver
Message-ID: <20180804210024.epnf3smqviqsm2jj@ninjato>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
 <20180801180232.23680-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vf523s55nlts2uct"
Content-Disposition: inline
In-Reply-To: <20180801180232.23680-6-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vf523s55nlts2uct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 11:32:31PM +0530, Manivannan Sadhasivam wrote:
> Add Actions Semiconductor Owl family S900 I2C driver.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--vf523s55nlts2uct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmE+gACgkQFA3kzBSg
KbYa4g//cPkcT5fKX2mp0X2Khf0reksDtd4fbsjjVJA+PsrRTsgRxHdbJeUkmDiN
8Aj0AWzkH4TG3Uo+vTlUB1foZFa4F1PRBtlpqXM5unqpNjVccpeo+5X6Af1xklUU
30Yj7OXLQ2tP9VMHsbU9YH1Srs38zVXKxIp5mj7urj3tujS4rUOlX19cR5wpn89h
rVJGyXQuO8Enjs1LnOdSZa0syIAizuxnO6HK6do0aw7Ov+RCuqAcJrgfaJNQmQh1
t7nE5AK+Of86juERQrU1iUgZz+JvIUMfk0rcz+tHJ4wQ7byYjsrh9Y4ifeX9v63R
uZ7NGmWjGoBr3FQL2f3EoN4gOERfHpCkuprQX+7p84w4oatIKqQn+fA7QM6l/2EW
qRFLs5zA9N0HPO8FRXANzXve52GUA+L4p1F+FwaSDPPi9Kam3EQmwrB+jTHermOD
Kj8aLsI7vG5UcmkLyKcVt3Qn3MjJjnTWbNsV2/nfNuGTark7G+7rFQIoy7l9BPwM
hQ15NKQebDA3ci5wyCOYIWov5V5i/87REIhe8GVjl13a4AsbdAbgWikDStXCqi8m
5r7ZIkG6oms1xOmkZD6kbNjHF2yjfjlqUsIIbIYMcpfEeFj0Fm+F+5mKQJP82pvq
BXrJp/XstWHSSgAIzzTcWFYh24u6YBiNFwrSu9nKxM3zFgVIzrA=
=Eb4a
-----END PGP SIGNATURE-----

--vf523s55nlts2uct--
