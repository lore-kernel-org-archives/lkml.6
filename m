Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E32C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF4F2080D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfBAFoO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:44:14 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:45877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfBAFoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:44:14 -0500
Received: from mail.ebs-systart.com ([24.134.95.109]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MV5G4-1gh9tf0JPC-00S5RV; Fri, 01 Feb 2019 06:44:01 +0100
Received: from CLIENT08.ebs-systart.intranet by [192.168.1.201] (MDaemon PRO v18.5.1) 
        with ESMTPSA id md50000251727.msg; Fri, 01 Feb 2019 06:43:59 +0100
X-MDArrival-Date: Fri, 01 Feb 2019 06:43:59 +0100
X-Authenticated-Sender: m.bittner@ebs-systart.com
X-Return-Path: m.bittner@ebs-systart.com
X-Envelope-From: m.bittner@ebs-systart.com
Date:   Fri, 01 Feb 2019 06:43:58 +0100
From:   Michael Bittner <m.bittner@ebs-systart.com>
Subject: AW: [PATCH v3 0/5] Add Oxalis board support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        shawnguo@kernel.org
cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        amit.kucheria@linaro.org
In-Reply-To: <20190201032817.GA3008@Mani-XPS-13-9360>
Message-ID: <209ab7e9.1d4b9f1.197c0e38.52d9@ebs-systart.com>
X-Priority: 3
Organization: EBS-SYSTART GmbH
X-Mailer: MDaemon Connector 5.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:JDCO4xFHA+rypI5+Wm65UPzGL8vA0S3b5QDd4TLYztPt0tzutrL
 zsYUH1x0NcqFQeWoZCdWbSWem5sC1/Vf/zAmld8EVdRIZ+O6CUMXuH4L5c55klqtk11T7J6
 iRTZRHfLDJK5rSVO23D0OBA9tuDwbYK8x+nzHm3ZrhZ744aclpQFnK785nHhypW/uKpFaxp
 G22PXeBiZcios/DlXPYRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cq0Kt2UxxOs=:wMlSJ4XJy6sW31C63SqxlZ
 V2S5GksA+dZLRGdkD2Xnj3D3iUnbMIJAL0zfq+8b+0Aq+SPzy0gBlYqsxWVBikYMzMhknjP82
 T0ZeT7p+0TJHxyLX2lVKjwNR1cTo+JpXNoJY6Qphax1wCF+SJ/bZO+ghdnHmEqimgioXXa8Rk
 pg1ExXAV98LRDywq3Klz7K6Iq9MTxq6jn7FU6vvgliCMACiLasE5NMt8WRHaqGFZs2a+c2bQ1
 6aiBNe1/x2lBDbqOb3lKuF2HWVIg3Z/t+J4Oq1F/Twu1FBJAQmhvODZrYFZTLfQVWIV54/8fp
 WQJCKHYejI9VxiEP6qVTYpJisrItIC9B2ihrOToU2+2j4tyN4y/68dYjCtDwNELXY+kYHCTAu
 Z+sjYdKe7yTN4g9zdO3NDBeg3u/BSHev9Y9V7iLwZBvCQyKdu35uN7j7WOq9tZHbeW5okxjW1
 5XcGNLekYyqXla9qA+5MTastXbTfWfHPQmi3Kj8/M7MeS0nOJxGrcOueOc/5AkaRYHWDSF6Ui
 CtVgrEEqO8iLwrD+6+4QEJdpNNNjrmI8M2pfZxCiSIy8XYFqWPkn7mzK9WOYx+B+7VQHRsxhR
 Yj7JHseGKus4CYlrqImqqoyQLa0fiqDUHlhlGlczYqMSF5ODYd2YqihozCx7IYf10E7s3hKZ6
 ES4vInn+6xDqktAVl37UHVaeP3JCEwXzIJJU1NtAhj1Vpo3dlubwKoxgCUy5D8WbxZJZMORfd
 XM+LLmYr9Km4TJ989Q7ZtAlHsu28UTRW0Q7OmmFYX0tkjSPnvKzKGt9NQnZrJw0a/UaXTNG6I
 MeWp88T
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello @all,

in the meantime all interfaces are supported. Following a short overview.

> * RAM: 2GB (!) DDR3L
> * PMU: NXP VR5100
> * Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, 
> * mSATA 3.0
> * Connectivity: 2x Ethernet
> * miniPCIe
> * SD Card
> * USB: 2x USB3.0
> * I2C x 2: 2x 96Boards Expansion Connector
> * UART x 2: 1 x Terminal and 1x 96Boards Expansion Connector
> * SPI: 1x 96Boards Expansion Connector
> * GPIOs 

The first 96Board Community Header Board will be available in March, this is currently in production.
I will put the schematics online soon. If you have any information missing please let me know. 

Best regards,
Michael

--
Tel.: +49 (0)8142/30505-0
Fax: +49 (0)8142/30505-50
Mail: m.bittner@ebs-systart.com
Internet: www.ebs-systart.com

EBS-SYSTART GmbH
Industriestraße 33a
D-82194 Gröbenzell

Amtsgericht München, HRB 70338, UST-IdNr. DE128221970
Geschäftsführer: Michael Bittner


-----Ursprüngliche Nachricht-----
Von: Manivannan Sadhasivam [mailto:manivannan.sadhasivam@linaro.org] 
Gesendet: Freitag, 1. Februar 2019 04:28
An: shawnguo@kernel.org
Cc: leoyang.li@nxp.com; robh+dt@kernel.org; linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; a.tropschug@ebs-systart.com; m.bittner@ebs-systart.com; amit.kucheria@linaro.org
Betreff: Re: [PATCH v3 0/5] Add Oxalis board support

On Tue, Jan 22, 2019 at 09:51:42AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds Oxalis board support. This board is one of the
> 96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
> of the key features of this board:
> 
> * SoC: NXP Layerscape LS1012A
> * RAM: 1GB DDR3L
> * PMU: NXP VR5100
> * Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
> * Connectivity: 2x Ethernet
> * USB: 2x USB3.0
> 
> More information about this board can be found in 96Boards product
> page: https://www.96boards.org/product/oxalis/
> 
> Ethernet and SPI flash are not supported yet!
> 
> Thanks,
> Mani
> 

Hi Shawn,

Any update on this patchset?

Thanks,
Mani

> Changes in v3:
> 
> * Fixed LS1012A and LS1021A bindings
> * Added missing devicetree compatibles for LS1021A based boards
> * Added Rob's Reviewed-by tag for Vendor prefix patch
> 
> Changes in v2:
> 
> As per Rob's review:
> 
> * Adopted the Oxalis board binding to JSON format.
> * Sorted the EBS-SYSTART vendor prefix alphabetically.
> * Used the generic node name for audio codec.
> 
> Manivannan Sadhasivam (5):
>   dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based
>     boards
>   ARM: dts: Add devicetree compatibles for LS1021A based boards
>   dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
>   dt-bindings: arm: fsl: Add devicetree binding for Oxalis
>   arm64: dts: freescale: Add devicetree for Oxalis
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 11 ++-
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts   |  1 +
>  arch/arm/boot/dts/ls1021a-qds.dts             |  1 +
>  arch/arm/boot/dts/ls1021a-twr.dts             |  1 +
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
>  7 files changed, 111 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
> 
> -- 
> 2.17.1
> 

