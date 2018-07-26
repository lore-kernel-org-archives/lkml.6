Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD501C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727882083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727882083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeGZRsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:48:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbeGZRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:48:36 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BB70612DE65E2;
        Thu, 26 Jul 2018 09:31:01 -0700 (PDT)
Date:   Thu, 26 Jul 2018 09:30:57 -0700 (PDT)
Message-Id: <20180726.093057.1929847552946394944.davem@davemloft.net>
To:     tli012345@163.com
Cc:     thomas.lendacky@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangpengpeng@higon.com
Subject: Re: [PATCH] net: fix amd-xgbe flow-control issue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180726064516.56740-1-tli012345@163.com>
References: <20180726064516.56740-1-tli012345@163.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 09:31:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tli012345@163.com
Date: Thu, 26 Jul 2018 14:45:16 +0800

> From: tangpengpeng <tangpengpeng@higon.com>
> 
> If we enable or disable xgbe flow-control by ethtool ,
> it does't work.Because the parameter is not properly
> assigned,so we need to adjust the assignment order
> of the parameters.
> 
> Signed-off-by: tangpengpeng <tangpengpeng@higon.com>

Applied with -fixes tag added and queued up for -stable.
