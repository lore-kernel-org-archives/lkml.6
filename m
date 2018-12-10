Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7DEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5762082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5762082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeLJTz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:55:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43568 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeLJTz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:55:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8D58314739E68;
        Mon, 10 Dec 2018 11:55:25 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:55:25 -0800 (PST)
Message-Id: <20181210.115525.1254317204526284186.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     pabeni@redhat.com, idosch@mellanox.com, ktkhai@virtuozzo.com,
        lucien.xin@gmail.com, petrm@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipvlan: Remove a useless comparison
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210112538.16324-1-yuehaibing@huawei.com>
References: <20181210112538.16324-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 10 Dec 2018 11:55:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 10 Dec 2018 19:25:38 +0800

> Fix following gcc warning:
> 
> drivers/net/ipvlan/ipvlan_main.c:543:12: warning:
>  comparison is always false due to limited range of data type [-Wtype-limits]
> 
> 'mode' is a u16 variable, IPVLAN_MODE_L2 is zero,
> the comparison is always false
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
