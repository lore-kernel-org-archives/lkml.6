Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7ADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245C421928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436846AbfBNR3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:29:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57040 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfBNR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:29:12 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F24D14D6018E;
        Thu, 14 Feb 2019 09:29:11 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:29:10 -0800 (PST)
Message-Id: <20190214.092910.1703693713951434356.davem@davemloft.net>
To:     huang.zijiang@zte.com.cn
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        lipeng321@huawei.com, liuyonglong@huawei.com,
        yuehaibing@huawei.com, keescook@chromium.org, wangxi11@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn
Subject: Re: [PATCH] net: hns: Fix object reference leaks in
 hns_dsaf_roce_reset()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1550126505-28394-1-git-send-email-huang.zijiang@zte.com.cn>
References: <1550126505-28394-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Feb 2019 09:29:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Zijiang <huang.zijiang@zte.com.cn>
Date: Thu, 14 Feb 2019 14:41:45 +0800

> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> 
> Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>

Applied, thank you.
