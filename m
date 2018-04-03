Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeDCPj3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:39:29 -0400
Received: from sauhun.de ([88.99.104.3]:43330 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeDCPj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:39:27 -0400
Date: Tue, 3 Apr 2018 17:39:25 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] i2c: i2c-stm32f7: Add DMA support
Message-ID: <20180403153925.lg37rezuvs6hefks@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-6-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y4m7u7dns5mivz3x"
Content-Disposition: inline
In-Reply-To: <1521650940-11651-6-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y4m7u7dns5mivz3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +#define STM32F7_I2C_DMA_LEN_MIN			0x1
...

> +	if (i2c_dev->dma && f7_msg->count >= STM32F7_I2C_DMA_LEN_MIN) {

Are you using DMA for every message with a length >= 1? The setup of
that might be more expensive than the DMA gain, if so.


--y4m7u7dns5mivz3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDoC0ACgkQFA3kzBSg
KbaRGQ//Us4GEynp2Xb4y6E2hTmv8kAhqvPGPAy/IUzs5dqlYuw29ZQNJ/K/kPBS
ud7NW4RQMBYbQiWQGNPINvoR3h/QthDwOhUT7DNA1IgJ0Jvmybvr96aTtuE5YUn5
A81ZKV6AdpdXH+GVRHOetMfNWxc747Jwy250YnlUen3WkMiiJhUHYb39l0W4zL1g
Iqzgp8khAKRgO7M5yZ4FieCKFA9lrL6vAYNDxcj8+Tb9h/ffR0vZwRGYc0TnpK0p
YmIYCDVBIptuoHcin7AMgGPNwn2WrzSOxzdlqkZKFWaBfvDfIJOv49zADLSt1NGT
42/Vs7ErMDLPU1kor/78XDK6P/AinKQ60bEsGccWY2buNeWbPdXn8AL5TlwMPWhh
NCTrWwj4X1O/bagULaxZBa9GukjuTRTuq/pRUU2h2kgxEyx32w74/nIKMcEzioJW
STRd95Ir8DPAT/L+G/stJ0V4tgaKqy0BJIYb9o0i9vHU7wrSvVn+rTE8cA/BAW5H
q60HlC//jG72vMMFmqNdvwAydYYgT8fumok5fxrM7efwfTspORta8+xxPeNi00GN
IQCx4xW5ggXdy/tttfxPEDI/b+BxpEeMyNiocNlW4bChEbPJbeVPCNPwrmHnJzv3
RFlK1jwNaIQ9HyP8QQKV0Lgg5se5Z5U2jvj2WB+5dLMTmKwXk3w=
=y6a8
-----END PGP SIGNATURE-----

--y4m7u7dns5mivz3x--
