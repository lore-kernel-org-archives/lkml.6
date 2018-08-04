Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CCBC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FB72177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FB72177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbeHDXCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:02:18 -0400
Received: from sauhun.de ([88.99.104.3]:58792 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbeHDXCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:02:18 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id 2C25A684D92;
        Sat,  4 Aug 2018 23:00:19 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:00:18 +0200
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
Subject: Re: [PATCH v8 1/6] dt-bindings: i2c: Add binding for Actions
 Semiconductor Owl I2C controller
Message-ID: <20180804210018.h5kvmaq4krkjwco5@ninjato>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
 <20180801180232.23680-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="amvdwci5bn2mn3rj"
Content-Disposition: inline
In-Reply-To: <20180801180232.23680-2-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--amvdwci5bn2mn3rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 11:32:27PM +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Actions Semiconductor Owl I2C controller
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to for-next, thanks!


--amvdwci5bn2mn3rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmE94ACgkQFA3kzBSg
KbYHZw/8CiXZTbmNGLrJ5VL4Hjmb4Ww7ovcJknOoo8hO8PLA8k5oNb5LXokXVo2j
daOSclMNY61LiVSygux5FgG+9AblLVg6tIgzo0AoQxHz6hWiU6Dall89CsBzH+BN
6RlgLxNChRoUkGxVC9ZfiuIO5Vj3JtomhWoRzfYZY1w4Ar/Myn19ShzJOeCERPAm
ZOppKZM2VX0RvyOPzl5EMX8aCOHv9sCezMHGFXnSDwGCVdoRfu0bo54Ju4yY9spl
wH+Tl4s4WKFm8cGYuTKf6TfO/hdj8LoTXnuuMgBwSERsnmyGH2xgmQE3Eozo/Com
qpIR7tqkzgcPOVq/UZMXhTglGyb8wkkpLW3XC4HQdXkl+8u5wq9hURX87rY9UvxS
qVe0B+P5wLikxnf/xfDrzuYEviN3XTJo4DL3pFCWGL36sahQdXJQWQMJRVgo20cc
SI4zgvOUigfdSbyMFxQOQMAsmRVoDXjOKZ07HRUbjaEpD3+semKK13UC3q8cV1AT
7VVbgyYWCZPm9MS/8ofKisFYG4bIdUJYa1r+Jvnvs4QBfPyslj0Jko7EffP1eccS
TO8/+7rDgqNNZT1bv0LDtp6d6zUBWtcYPjS1VLXqa4iFO83h5G5xi7Ot820FXKpL
8Mo5HcMLk0Jc4Yiq8A5CN38qbXAs5qDD56wXlwJ+szhzzcUU9fE=
=c3kg
-----END PGP SIGNATURE-----

--amvdwci5bn2mn3rj--
