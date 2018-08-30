Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113A7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C7720647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C7720647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeH3Glh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:41:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39914 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbeH3Glh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:41:37 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 43B82108F8649;
        Wed, 29 Aug 2018 19:41:45 -0700 (PDT)
Date:   Wed, 29 Aug 2018 19:41:44 -0700 (PDT)
Message-Id: <20180829.194144.750729092398811481.davem@davemloft.net>
To:     robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, sebastian.hesselbarth@gmail.com,
        nbd@openwrt.org, john@phrozen.org, sean.wang@mediatek.com,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com, w-kwok2@ti.com,
        m-karicheri2@ti.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: Convert to using %pOFn instead of
 device_node.name
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180828154433.5693-4-robh@kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
        <20180828154433.5693-4-robh@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Aug 2018 19:41:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Aug 2018 10:44:30 -0500

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - fix missing brackets in netcp

Applied to net-next.
