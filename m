Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE87C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F268C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F268C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeLMFk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:40:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47156 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeLMFk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:40:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3047114B3CFD5;
        Wed, 12 Dec 2018 21:40:55 -0800 (PST)
Date:   Wed, 12 Dec 2018 21:40:54 -0800 (PST)
Message-Id: <20181212.214054.1923431319770488052.davem@davemloft.net>
To:     biao.huang@mediatek.com
Cc:     robh+dt@kernel.org, honghui.zhang@mediatek.com,
        yt.shen@mediatek.com, liguo.zhang@mediatek.com,
        mark.rutland@arm.com, nelson.chang@mediatek.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com,
        andrew@lunn.ch
Subject: Re: [v7, PATCH 0/2] add Ethernet driver support for mt2712
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 21:40:55 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>
Date: Thu, 13 Dec 2018 09:56:11 +0800

> Changes in v7:
> Add MODULE_LICENSE info in driver.

Biao, I said I need a "fixup" patch, not the whole series again.

I've already applied your patches, and you need to send me a small
fix on top.

This shows that you are not generating your patches against my
net-next tree properly.  If you were, you would see that I applied
your changes already.
