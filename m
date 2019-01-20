Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE1C636A2
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FEB20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfATOOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 09:14:33 -0500
Received: from mout.gmx.net ([212.227.15.19]:35183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfATOOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 09:14:32 -0500
Received: from [192.168.123.67] ([84.118.159.3]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZ4Q-1ggOZu0iNq-00WVfb; Sun, 20
 Jan 2019 15:14:12 +0100
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI
 area
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
 <874lagpycx.fsf@FE-laptop>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <2c42946c-8bc1-d4cf-b6af-da54aba61c94@gmx.de>
Date:   Sun, 20 Jan 2019 15:14:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <874lagpycx.fsf@FE-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:avJxKY5a86HJ59dExVs8a/O5iMEuoocIJYZ1bRpIFicSkBhyPOp
 5BObaq6WT97pJQuFISCT0bU/oN5mtbJq2Qqwk761PnqtqJTnjTsTEMGJl9cDun+1rMh1n0B
 8Acx8HcwHTySHHRVZwZ//qxolS2fLgn9BSPRPjWLPonT/tZbgeVEJeUBLENNVx7aRrgDS+g
 SHoNa1RTAgL+2RP0SDxHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/b8H8fsvQWo=:9YFpUC4Ei2U9H+1E0CGbrM
 0Wapt/uwWn6MSjuo4KH2FO1JnqW75WiTk5lxaE4i7GuNlgRM9RMGON2qsT9zZQr3H6rFA7smw
 QWXyKurF49MQB0IizjyCX1sk6H7x3LCR7XL7OII1yZve+VTDrEL5wPSZGgjeM/29+jc9Gifaq
 neQOwVEyPUeAiNH5/wxO88oHvUSEjqLZdQkPOF14CCoB1RKNlvC44qyADaHN7pE39XKRM8a8s
 Rv5sr32p1REtoqnS2DB9hxaJOe7xwZn2eDksITKj62gXP60ndyK55AtrNyGdZQEh1VKAfOmhb
 4sxqB5uFQVxDdvuQgNDkqIeEKyHM8r3UpLj2Wz8Ct9lPkNEGjEcBfR9IeddkR8rJAvez6glQE
 z1/dd34YmUvnl5ptkSZZxFPCM3S3OZkY9+wbBQ42ta/EZsexger+uJZh799l17uBSFgIX6KBO
 LOZS/XRLRTSqNxt8q3MlRfR91BBtDpXOCXrVtVi2fJbPomc2bLmAGOabGsnhXgoB71wXnhdCw
 bT0FBGkFmf4RhIa7ynS9YXn7Gt/+3S6iZ3hR3uvTUGeEAtbiaiidPilspiWzcj9xxW4iHUEm4
 ejliXbHcuddY6Fkm9PqqDs2D1hysvAUIDNeu4hnF6axOXQBdzLPaBbCNgNkgA7BfC6LutmbIe
 cu+8p7ZVr2R2peaKo9+/ZOgBAqLLtLXn2dzMdOlkRNlPcOH91n8UdNqqt7mg6a5vC2EuubIso
 xFRoPzlRbYhbJvJ4B0mjjdbal8tx5xMhjxNvfq4O+4J0CBcr85XCvSNgWOzIQkv5qsnSWN/IP
 fNW0zCQQVVrptcET3kzDeJA6wM39pqTfKHT96L0KhjwQPORKHLcm0UtzKi1RO3nqMK9t8IEyt
 4fDG9HiuVW+DtilehCYrXj3bZadmPlPITcPjoFYmbGzdhWF+YtC5d85PH08SeWqAyo5wJtWsi
 fC+DOtp5rtg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 12:04 PM, Gregory CLEMENT wrote:
> Hi Heinrich,
>  
>  On ven., déc. 21 2018, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> 
>> The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
>> attempt to access it from Linux leads to an immediate crash.
>>
>> So let's make the same memory reservation as the vendor kernel.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> 
> Applied on mvebu/fixes
> 
> I added a comment about the use with a mainline /U-Boot
> 
> Thanks,
> 
> Gregory
> 
> 


Hello Greg,

please, consider

arm64: dts: marvell: armada-ap806: reserve PSCI area
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc2&id=132ac39cffbcfed80ada38ef0fc6d34d95da7be6

for backporting to v4.19.

This patch is needed to run Linux on the MACCHIATObin and other boards.

Best regards

Heinrich
