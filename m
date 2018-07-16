Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024FDECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61B5208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61B5208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeGPPcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:32:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44899 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727385AbeGPPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:32:38 -0400
X-UUID: ec92db3b0ecd4ff7b378cd28f5efdf04-20180716
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 464972308; Mon, 16 Jul 2018 23:04:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 16 Jul 2018 23:04:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 16 Jul 2018 23:04:36 +0800
Message-ID: <1531753476.7842.1.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] arm64: dts: mt7622: update a clock property for
 UART0
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 16 Jul 2018 23:04:36 +0800
In-Reply-To: <a4f0c6db-b88f-4c54-827a-e160bebae62b@gmail.com>
References: <2ff39c40ef6bc3054667e63c785a1d28527b5ddf.1531209126.git.ryder.lee@mediatek.com>
         <b96deaa9f54a0ae3f62ec30d858be7abd1ed873f.1531209126.git.ryder.lee@mediatek.com>
         <a4f0c6db-b88f-4c54-827a-e160bebae62b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2018-07-16 at 15:55 +0200, Matthias Brugger wrote:
> Hi Ryder,
> 
> On 10/07/18 09:55, Ryder Lee wrote:
> > The input clock of UART0 should be CLK_PERI_UART0_PD.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> Can you provide a "Fixes" tag with the commit id of the commit that broke this?
> 
> Thanks,
> Matthias

I've sent a new one with a "Fixes" tag.

Ryder
> 
> > ---
> >  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > index 8cdec52..4caa9b4 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > @@ -367,7 +367,7 @@
> >  		reg = <0 0x11002000 0 0x400>;
> >  		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> >  		clocks = <&topckgen CLK_TOP_UART_SEL>,
> > -			 <&pericfg CLK_PERI_UART1_PD>;
> > +			 <&pericfg CLK_PERI_UART0_PD>;
> >  		clock-names = "baud", "bus";
> >  		status = "disabled";
> >  	};
> > 


