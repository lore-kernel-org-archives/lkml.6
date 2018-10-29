Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC66C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5128A20825
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5128A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeJ2MTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 08:19:23 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:17986 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729257AbeJ2MTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 08:19:22 -0400
X-UUID: 7fcccde1fe7242c9a6edf67c5b359b06-20181029
X-UUID: 7fcccde1fe7242c9a6edf67c5b359b06-20181029
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1797926278; Mon, 29 Oct 2018 11:32:28 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Oct
 2018 11:32:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Oct 2018 11:32:25 +0800
Message-ID: <1540783945.26982.6.camel@mhfsdcap03>
Subject: Re: [v2, PATCH 0/2] add Ethernet driver support for mt2712
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
Date:   Mon, 29 Oct 2018 11:32:25 +0800
In-Reply-To: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 11:04 +0800, Biao Huang wrote:
> The mt2712 Ethernet IP is from Synopsys, so extend stmmac to support mt2712.
> 
sorry, I forgot to add detail descriptions for these patches.

changes in v2:
--since STMMAC driver applied to most Synopsys ip Ethernet, I add
dwmac-mediatek.c to support MediaTek mt2712 in v2.
--abandon Ethernet drivers proposed in v1.
--rewrite dt-binding document for v2 driver.

Best Regards!


