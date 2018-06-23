Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58DDC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57824C3A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B57824C3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeFWPQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:16:16 -0400
Received: from sauhun.de ([88.99.104.3]:57564 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeFWPQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:16:14 -0400
Received: from localhost (KD106181193149.au-net.ne.jp [106.181.193.149])
        by pokefinder.org (Postfix) with ESMTPSA id F2A0056430D;
        Sat, 23 Jun 2018 17:16:10 +0200 (CEST)
Date:   Sun, 24 Jun 2018 00:16:06 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        kramasub@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: Fix default clock-freq for
 qcom,geni-i2c
Message-ID: <20180623151605.kyycbeema55trj7w@ninjato>
References: <20180613175011.217585-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ivrb7mvwhvohmbnu"
Content-Disposition: inline
In-Reply-To: <20180613175011.217585-1-dianders@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ivrb7mvwhvohmbnu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:50:11AM -0700, Douglas Anderson wrote:
> In an early version of the I2C patch that was posted to the list the
> default I2C frequency (if none was specified) was 400 kHz.  There was
> debate on the list and we decided that it would be more consistent
> with the rest of i2c if we defaulted to 100 kHz.  ...but we never
> updated the bindings.  Let's fix this.
>=20
> NOTE: since the i2c driver itself hasn't actually landed yet and the
> SoC here is very new it seems terribly unlikely that anyone was
> relying on the old 400 kHz number, so I'll assume this is an OK
> "incompatible" device tree change.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--ivrb7mvwhvohmbnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsuZDEACgkQFA3kzBSg
Kbbhuw/7B/7/vIwCaTj1MqUvwjHVbteIrjemXNc+JPPtKQ2HHmVgoD5Vx5T45odY
TCcCpcAARHPYE9yPFiR+kz9x6GF74tI9UV/Ej8FilSn7gcb8aZIP1uMnMmUf/QH9
F2O5EA+ym1CawGM2Ah1t6Yv7O4QQkLf7WLCRW+KZbiuBb+rqwAvSjjubJ9QBpZbQ
0c6ZXNY6anUOocaBB6Dz7Nd6DULruewjnn7B2kaVK3sV+59xUuNABIChZQLhVGQD
TG3d0jXlG+ggO3BKrOlkvVdIb1aFQ1o4VjdDPMG2ydVbqVbH0fmdnL1E9CdRErmi
LKtybI9ewySMpeerPw5Jaa+fwg1dn0colMRODwCOChuNMBYvjkuK2eTlIbwE5nU2
ch9/GjoTKcNth44sEu/xAc6573ghgxEf/zPxD2oisInPpXMC3GfYlT5UXOtLInCu
03xR6240Bc0CqQnHNpikEvVlR6BfVdibPgtksQ038revRoJPPF9OjUnuosysFdNm
SLnEbPpO4mW7XJ4rBb8E4hCoHkOqp3DgKobA8Cj55IBRwq3aC42XWlsB54wfH38e
dVYXq3dvNqd/HtIKgwcXy1HdZpFRG1q/AV4ivOF5tNBIsJjwtc903ZdisRZygxWO
mn+a64gCIcnaabypw8Ow4prOuBpqFMxk6q8upjL9IB5Rn0qXR9w=
=uNZX
-----END PGP SIGNATURE-----

--ivrb7mvwhvohmbnu--
