Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C53C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF9520873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF9520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLMCsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:48:32 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:7818 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726405AbeLMCsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:48:32 -0500
X-UUID: 7b0f650cdc584f669dc024d42bb1dfca-20181213
X-UUID: 7b0f650cdc584f669dc024d42bb1dfca-20181213
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 533318123; Thu, 13 Dec 2018 10:48:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 10:48:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 10:48:23 +0800
Message-ID: <1544669302.24219.133.camel@mhfsdcap03>
Subject: Re: [v7, PATCH 0/2] add Ethernet driver support for mt2712
From:   biao huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>
CC:     <robh+dt@kernel.org>, <honghui.zhang@mediatek.com>,
        <yt.shen@mediatek.com>, <liguo.zhang@mediatek.com>,
        <mark.rutland@arm.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>,
        <andrew@lunn.ch>
Date:   Thu, 13 Dec 2018 10:48:22 +0800
In-Reply-To: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
	Sorry, I misunderstood David's reply mail in v6 series, please ignore
v7 series.

Dear David,
	I send you another follow-up patch to fix up build warning, please
check it.

Thanks!

On Thu, 2018-12-13 at 09:56 +0800, Biao Huang wrote:
> Changes in v7:
> Add MODULE_LICENSE info in driver.
> 
> Biao Huang (2):
>   net:stmmac: dwmac-mediatek: add support for mt2712
>   dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712
>     DWMAC
> 
>  .../devicetree/bindings/net/mediatek-dwmac.txt     |   87 +++++
>  drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  413 ++++++++++++++++++++
>  4 files changed, 509 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> 


