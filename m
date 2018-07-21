Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A0EECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38C220856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38C220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeGVASV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:18:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46504 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeGVASU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:18:20 -0400
Received: from localhost (unknown [172.58.43.158])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1686C12173D88;
        Sat, 21 Jul 2018 16:23:52 -0700 (PDT)
Date:   Sat, 21 Jul 2018 16:23:50 -0700 (PDT)
Message-Id: <20180721.162350.1052424044584055730.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next] tipc: make some functions static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180719091659.20248-1-yuehaibing@huawei.com>
References: <20180719091659.20248-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Jul 2018 16:23:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 19 Jul 2018 17:16:59 +0800

> Fixes the following sparse warnings:
> 
> net/tipc/link.c:376:5: warning: symbol 'link_bc_rcv_gap' was not declared. Should it be static?
> net/tipc/link.c:823:6: warning: symbol 'link_prepare_wakeup' was not declared. Should it be static?
> net/tipc/link.c:959:6: warning: symbol 'tipc_link_advance_backlog' was not declared. Should it be static?
> net/tipc/link.c:1009:5: warning: symbol 'tipc_link_retrans' was not declared. Should it be static?
> net/tipc/monitor.c:687:5: warning: symbol '__tipc_nl_add_monitor_peer' was not declared. Should it be static?
> net/tipc/group.c:230:20: warning: symbol 'tipc_group_find_member' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
