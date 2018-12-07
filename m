Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D61C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D780120838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D780120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLGFoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 00:44:06 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:7862 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725952AbeLGFoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 00:44:06 -0500
X-UUID: d8ebf40d5dd2418b8e511b6b63ee64b3-20181207
X-UUID: d8ebf40d5dd2418b8e511b6b63ee64b3-20181207
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <guochun.mao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 615148597; Fri, 07 Dec 2018 13:44:01 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 13:44:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Dec 2018 13:43:59 +0800
Message-ID: <1544161439.8955.3.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH 2/4] mtd: spi-nor: mtk-quadspi: use ofpart for
 parsing partitions
From:   Guochun Mao <guochun.mao@mediatek.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 7 Dec 2018 13:43:59 +0800
In-Reply-To: <20181206153610.26db522c@bbrezillon>
References: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
         <6cca6844f426d4ad4e7c878420b363cfb34499aa.1543472168.git.ryder.lee@mediatek.com>
         <20181206153610.26db522c@bbrezillon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 15:36 +0100, Boris Brezillon wrote:
> On Thu, 29 Nov 2018 14:29:54 +0800
> Ryder Lee <ryder.lee@mediatek.com> wrote:
> 
> > From: Guochun Mao <guochun.mao@mediatek.com>
> > 
> > Replace mtd_device_register with mtd_device_parse_register for
> > parsing partitions and add ofpart support.
> 
> What's the problem with the default partition parser table [1]?
> 
> [1]https://elixir.bootlin.com/linux/latest/source/drivers/mtd/mtdpart.c#L793

No problem here.
This patch can be dropped.
Please help review others.

Thanks.


