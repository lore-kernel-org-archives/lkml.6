Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC69C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F278720852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F278720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935830AbeFRLGV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:06:21 -0400
Received: from sauhun.de ([88.99.104.3]:48294 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933895AbeFRLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:06:18 -0400
Received: from localhost (OFScd-05p9-223.ppp11.odn.ad.jp [182.158.75.223])
        by pokefinder.org (Postfix) with ESMTPSA id 1832354006A;
        Mon, 18 Jun 2018 13:06:14 +0200 (CEST)
Date:   Mon, 18 Jun 2018 20:06:11 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 00/11] Split i2c_lock_adapter into i2c_lock_root and
 i2c_lock_segment
Message-ID: <20180618110610.cwvkke6klc46kzvz@ninjato>
References: <20180615101506.8012-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m2cccclcdv7g6rv4"
Content-Disposition: inline
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m2cccclcdv7g6rv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I suggest that Wolfram takes this series through the I2C tree
> and creates an immutable branch for the other subsystems. The

I'd prefer this, too. Are the other subsystem maintainers fine with
that?

I am very positive on the series. I just have one comment which I just
posted. It looks good in general.


--m2cccclcdv7g6rv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsnkiEACgkQFA3kzBSg
KbaHRg/+LIDv2KYrGb+WRGPsvVW8pckrYy46rfvncOf6y84rD6/fOb6yBmh8d/X9
knn6/6n6qCSkRIsEGt2qiGN0/wi+SscJ1sSYb8nFwe2vaYFkwpGLAutys9o6Y7nZ
rmqnfcnEVIyY6w5eN2ZEZymToscwjRHmf8s4LOe8QvPTf9FSP22ZxAg0LdwRZCAZ
588k6cUKFmd0XpCrW/1EvbMPxAz58T0gZDAJ6M1MLJiZZvK8PKAwl21kXeFW9/PY
rkpjcpz6MsBik3OGw83YW3ZzrQ48XqrnknkNFt7/CP+TcCUI7wRuCAjuNPW0Nstr
HzUKry57BfEA2G//GZxKmjSzy8ZGuLu6UBgl81cJsjnw93FAsbNlsJBRxWT5PRZS
2ZELyjwtDoQOchXnwFz6JdssbjYp6KvbAEL7osl9lAiMf+DpNmkbwATkMWwAlHVp
bPtuKxueH0ABWwuUVu6Xzxh4hVVQxBE2MvlVzVmNLv5gTx7XMISJM+8GZ5pjR5iv
f2Jh7pRuzPfyk8GD7GMbIn4b0MOlX3xR2nBVT9jS5t0rtQAUouSJ0BhPIZO6HH/s
J62e1enNni++DfR6pLZKaLT5xILgLCoZv9CRw1saX+86RvsX8vFrNt9B3RCTeUJu
/c4IVYf52xA+CxviyqcZqYDjYrrirHMP2LjRclvMyPBzsE/wy/E=
=HnqL
-----END PGP SIGNATURE-----

--m2cccclcdv7g6rv4--
