Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id erKkJ579HVvgSAAAmS7hNA
	; Mon, 11 Jun 2018 04:42:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 63F96607A4; Mon, 11 Jun 2018 04:42:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 45FEE606FA;
	Mon, 11 Jun 2018 04:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45FEE606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbeFKEmC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 00:42:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37227 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeFKEmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 00:42:01 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fSEeU-0000Os-KE; Mon, 11 Jun 2018 06:41:58 +0200
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
References: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>
From: Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <a2c3f9c2-0c82-a9df-8ae6-b08a8423b132@pengutronix.de>
Date: Mon, 11 Jun 2018 06:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iPDzjAqulvdlORRS6c4TpbJGYXVfqPPT6"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iPDzjAqulvdlORRS6c4TpbJGYXVfqPPT6
Content-Type: multipart/mixed; boundary="vFlihA8LetR5Egt2HfyGeVsnZa4kIHP84";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Heiko Schocher <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)"
 <Yi.Zhu5@cn.bosch.com>
Message-ID: <a2c3f9c2-0c82-a9df-8ae6-b08a8423b132@pengutronix.de>
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
References: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>
In-Reply-To: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>

--vFlihA8LetR5Egt2HfyGeVsnZa4kIHP84
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,


On 07.06.2018 17:14, Jonas Mark (BT-FIR/ENG1) wrote:
> Hi Andy,
>=20
>>> The functionality bases on an external peripheral chip named Companio=
n.
>>> It offers two CAN interfaces, each has 8 prioritized transmit FIFOs a=
s
>>> well as one receive FIFO. Besides CAN, undisclosed additional functio=
ns
>>> can be accessed through the char device.
>>>
>>> A standard SPI interface with two additional lines for flow control i=
s
>>> used. The Companion chip is the SPI slave.
>>
>> Can remoteproc API be utilized here?
>=20
> So far I wasn't aware of the remoteproc API. It appears to me that is
> limited to power on/off and loading firmware in an AMP scenario. Here,
> the Companion has a fixed firmware in it. It must already be running
> quickly after power-up, even before the boot loader.

yes, remoteproc is not quite suitable for this task.

> Does remoteproc also contain a communication framework?

it is using VirtIO

> Do you mean rpmsg? Here, I do not see how we could benefit from it.

using same message format instead of inventing new one will be really
good step:
https://github.com/OpenAMP/open-amp/wiki/RPMsg-Messaging-Protocol
(less code duplicating same functionality)

Looks like every company trying to solve the same problem over and over
again. We have point to point link between two systems. Each system has
multiple functionalities/applications so we should be able to address
this functionality. So we end to some thing with source address and
destination address. In all protocols used for inter processor/chip
communication, the difference is only the layout of 3 common fields:
source, destination and size. In many cases the ISO/OSI layer model is
badly broken and

> Can you point me to an example where rpmsg is used over SPI?

RPMsg is just transport layer, 5 or 6 wire SPI is in this case Physical
layer with flow control support. Currently i'm not sure if VirtIO with
queue support do make sense here.

> Greetings,
> Mark


--vFlihA8LetR5Egt2HfyGeVsnZa4kIHP84--

--iPDzjAqulvdlORRS6c4TpbJGYXVfqPPT6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlsd/ZUACgkQdQOiSHVI
77TaMwf/X4Yl2Mi0EqVaL5X7z4/3gXNhpJxAohpOLwR+/Nks1SLGVANiarkzrDOg
Ojj6Ejrc2ycctLBPCOl83W/CfmlHN1py6bQN/WhvABa8ykRPmBctgQYOeIDtvwTy
bvKXziu25g7I4RDUw2I6OmHRe93LlHOv/bHTBScZrXsfwFlYbRzkKfy03Ih1qwf2
rUmjexMxUcXn8ud5cFXC0tJ2Qs72QUaZ7iYhp6Yww6fnCNg+rbwEBhDO2TBHQVtL
cO5TrvTJPrq0WNdX858zFtZqVQvz5IyUyrWAg1MjPoRoT+Edw1tLUc4pq/1x8pPZ
CC4D5U0KG7/eYNyinYh7dqpLYM2aJg==
=mEgW
-----END PGP SIGNATURE-----

--iPDzjAqulvdlORRS6c4TpbJGYXVfqPPT6--
