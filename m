Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98299C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6581C20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6581C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeLLXlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:41:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41300 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeLLXlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:41:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E6393149B2E87;
        Wed, 12 Dec 2018 15:40:59 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:40:59 -0800 (PST)
Message-Id: <20181212.154059.943420976868382142.davem@davemloft.net>
To:     biao.huang@mediatek.com
Cc:     robh+dt@kernel.org, honghui.zhang@mediatek.com,
        yt.shen@mediatek.com, liguo.zhang@mediatek.com,
        mark.rutland@arm.com, nelson.chang@mediatek.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com,
        andrew@lunn.ch
Subject: Re: [v6, PATCH 0/2] add Ethernet driver support for mt2712
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181212.152114.107710423985118689.davem@davemloft.net>
References: <1544607332-29921-1-git-send-email-biao.huang@mediatek.com>
        <20181212.152114.107710423985118689.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 15:41:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 12 Dec 2018 15:21:14 -0800 (PST)

> From: Biao Huang <biao.huang@mediatek.com>
> Date: Wed, 12 Dec 2018 17:35:30 +0800
> 
>> Changes in v6:
>>  modifications according to comments from Rob/Andrew/Sean:
>>  1. use delay_ps instead of delay stage.
>>  2. add comments in driver to avoid confusion.
>>  2. rewrite set_delay function.
>>  3. modify binding document for properties: tx-delay-ps/rx-delay-ps/pericfg etc.
> 
> Series applied to net-next, thank you.

Please send me a follow-up patch to fix this:

WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.o

Thank you.
