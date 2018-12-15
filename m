Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C84C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1B2206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeLOKFC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:05:02 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:48688 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:05:01 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id D3F0D67A7DC;
        Sat, 15 Dec 2018 11:04:55 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 15 Dec
 2018 11:04:55 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Sat, 15 Dec 2018 11:04:55 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: AW: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Topic: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Index: AQHUkKVtG6It8sv/EE6xXPNZqAZcLKV4GW2AgARFkACAAPregIACPlr7
Date:   Sat, 15 Dec 2018 10:04:55 +0000
Message-ID: <937b0f34e3eb485aaae45cd649cdeb4f@kontron.de>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
 <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
 <1ad93cdf-7ba1-ff49-f330-6bbd0f6c6972@kontron.de>,<20181214004251.GA15775@dragon>
In-Reply-To: <20181214004251.GA15775@dragon>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: D3F0D67A7DC.A275E
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        devicetree@vger.kernel.org, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Dec 13, 2018 at 09:45:04AM +0000, Schrempf Frieder wrote:
>> + Shawn, Sascha
>>
>> On 10.12.18 17:31, Schrempf Frieder wrote:
>> > Hi FSL/ARM maintainers,
>> >
>> > On 10.12.18 17:26, Schrempf Frieder wrote:
>> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>> >>
>> >> We have prepared a new driver for the FSL QSPI controller that works under
>> >> the SPI framework. The current devicetrees are broken because they use an
>> >> inconsistent scheme for assigning the reg properties.
>> >>
>> >> As, in contrast to the current driver, the new driver will use the reg
>> >> properties to select the correct chip, we need to fix them.
>> >>
>> >> We also add spi-[tx/rx]-bus-width to make sure the full buswidth will be used
>> >> and while at it clean up and remove some unused properties.
>> >
>> > could you please consider these devicetree patches for v4.21?
>>
>> Any chance to get this merged? Otherwise we would need to postpone the
>> new driver even further.
>
>As it came up a little bit late (the same day I sent pull request for
>4.21), I was considering it as 4.22 material.  But as you mentioned that
>the series is non-intrusive, I can try to send it to arm-soc folk for
>4.21 merge window, and then that will be their call.  But before I do
>it, I need you to double confirm that the series will not break anything
>that is already working.

I can confirm, that the series does only remove or add properties to the
devicetree, that are currently not used by the driver. Therefore it won't break
anything.

Thanks,
Frieder

>
>Shawn
>
>>
>> All the changes to the devicetrees in this series are non-intrusive and
>> uncritical, anyway.
>>
>> Thanks,
>> Frieder
>>
>> >
>> > We have the new FSL QSPI driver under the SPI framework ([1]) ready, but
>> > we need some small fixes to the devicetrees that are currently broken.
>> >
>> > As the new driver depends on these changes (mainly the change to the reg
>> > properties) and it is not possible to add compatibility for the old
>> > bindings, it would be really nice to have them in v4.21, so we can queue
>> > the driver for v4.22 or whatever the next release will be called.
>> >
>> > Please also see [2] for some more explanation.
>> >
>> > Thanks,
>> > Frieder
>> >
>> > [1] https://patchwork.ozlabs.org/cover/1007641/
>> > [2] https://patchwork.ozlabs.org/patch/922817/#1925445
>> >
>> >>
>> >> Frieder Schrempf (5):
>> >>     arm64: dts: Remove unused properties from FSL QSPI driver nodes
>> >>     ARM: dts: Remove unused properties from FSL QSPI driver nodes
>> >>     ARM: dts: imx6sx-sdb: Fix the reg properties for the FSL QSPI nodes
>> >>     arm64: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
>> >>     ARM: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
>> >>
>> >>    arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 8 ++++++--
>> >>    arch/arm/boot/dts/imx6sx-sdb.dts                   | 8 ++++++--
>> >>    arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 2 ++
>> >>    arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        | 5 ++---
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
>> >>    arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
>> >>    8 files changed, 28 insertions(+), 12 deletions(-)
>> >>
>> > ______________________________________________________
>> > Linux MTD discussion mailing list
>> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
>> >
