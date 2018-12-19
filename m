Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1630121871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeLSFnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:43:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49330 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSFnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:43:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9DFBF12640956;
        Tue, 18 Dec 2018 21:43:45 -0800 (PST)
Date:   Tue, 18 Dec 2018 21:43:44 -0800 (PST)
Message-Id: <20181218.214344.703245035605109815.davem@davemloft.net>
To:     biao.huang@mediatek.com
Cc:     robh+dt@kernel.org, honghui.zhang@mediatek.com,
        yt.shen@mediatek.com, liguo.zhang@mediatek.com,
        mark.rutland@arm.com, nelson.chang@mediatek.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com,
        andrew@lunn.ch
Subject: Re: [v2, PATCH 0/2] add ethernet binding and modify ethernet
 driver for mt2712
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1545112096-22737-1-git-send-email-biao.huang@mediatek.com>
References: <1545112096-22737-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 21:43:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>
Date: Tue, 18 Dec 2018 13:48:14 +0800

> changes in v2 as comments from Sean:
> 1. fix typo.
> 2. use capital letters for RMII/MII/RGMII in driver and bindings.
> 
> v1:
> This new series is the result of discussion in:
> http://lkml.org/lkml/2018/12/13/1007
> http://lkml.org/lkml/2018/12/14/53
> 
> 1. ethernet binding file move to this series.
> 2. remove fine tune property in device tree
> 3. remove fine tune flow in ethernet driver
> 4. set rgmii timing according to the value in device tree,
> and don't care whether phy insert internal delay  or not.

This series doesn't apply cleanly to the net-next tree.
