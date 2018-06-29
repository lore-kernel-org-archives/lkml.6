Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED3C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC44F24D81
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC44F24D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967604AbeF2CHS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:07:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36484 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967540AbeF2CHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:07:16 -0400
Received: from localhost (unknown [42.29.28.56])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3D6881434E9F7;
        Thu, 28 Jun 2018 19:07:13 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:07:07 +0900 (KST)
Message-Id: <20180629.110707.939073651459188666.davem@davemloft.net>
To:     lipeng321@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com
Subject: Re: [PATCH net-next 00/11] net: hns3: a few code improvements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
References: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Jun 2018 19:07:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>
Date: Thu, 28 Jun 2018 12:12:18 +0800

> This patchset fixes a few code stylistic issues from
> concentrated review, no functional changes introduced.

Series applied to net-next, thank you.
