Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEPU6k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:58:40 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44783 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeEPU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:58:38 -0400
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Gregory Clement <gregory.clement@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>, "Andrew Lunn" <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] pinctrl: mvebu: use correct MPP sel value for dev pins
Thread-Topic: [PATCH] pinctrl: mvebu: use correct MPP sel value for dev pins
Thread-Index: AQHT5aq9Nzq7OQNdhUGEkFPA3djjdw==
Date: Wed, 16 May 2018 20:58:35 +0000
Message-ID: <1ebc15b559d74ace9a1171548f79f978@svr-chch-ex1.atlnz.lc>
References: <20180507022555.31645-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdbAaMrHJ8TjJTtNyVtoOSRAEf2Z8gRthFH0ze4RyybBag@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GKwjJ5004770

On 17/05/18 00:55, Linus Walleij wrote:
> On Mon, May 7, 2018 at 4:25 AM, Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> 
>> The "dev" function is selected with the value 0x4 not 0x01.
>>
>> Fixes: commit d7ae8f8dee7f ("pinctrl: mvebu: pinctrl driver for 98DX3236 SoC")
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> Patch applied.
> 
> Does it need to go into fixes? Stable?

By "fixes" do you mean into 4.17? Yes please.

Stable would be good. Although all the boards I'm aware of rely on the 
pin configuration being done by the bootloader so I've not heard of 
anyone experiencing problems.
