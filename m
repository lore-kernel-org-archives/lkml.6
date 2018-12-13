Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFE020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFE020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeLMFnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:43:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:43:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A743C14B3D316;
        Wed, 12 Dec 2018 21:43:12 -0800 (PST)
Date:   Wed, 12 Dec 2018 21:43:12 -0800 (PST)
Message-Id: <20181212.214312.763693432759368677.davem@davemloft.net>
To:     biao.huang@mediatek.com
Cc:     robh+dt@kernel.org, honghui.zhang@mediatek.com,
        yt.shen@mediatek.com, liguo.zhang@mediatek.com,
        mark.rutland@arm.com, nelson.chang@mediatek.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com,
        andrew@lunn.ch
Subject: Re: [PATCH] net-next: stmmac: dwmac-mediatek: add module license
 info
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544668897-6947-1-git-send-email-biao.huang@mediatek.com>
References: <1544668897-6947-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 21:43:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>
Date: Thu, 13 Dec 2018 10:41:37 +0800

> Add MODULE_LICENSE info to fix this:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.o
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

Applied, thanks for fixing this properly.
