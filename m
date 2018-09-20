Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1909EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE5A2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE5A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbeITJjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:39:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34050 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeITJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:39:44 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EFEFA146CC8FD;
        Wed, 19 Sep 2018 20:58:27 -0700 (PDT)
Date:   Wed, 19 Sep 2018 20:58:25 -0700 (PDT)
Message-Id: <20180919.205825.1038224413795888359.davem@davemloft.net>
To:     zhongjiang@huawei.com
Cc:     ubraun@linux.ibm.com, jwi@linux.ibm.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, Ariel.Elior@cavium.com,
        everest-linux-l2@cavium.com, grygorii.strashko@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: Re: [RESEND PATCH 0/5] net: Use FIELD_SIZEOF directly instead of
 reimplementing its function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1537356734-51676-1-git-send-email-zhongjiang@huawei.com>
References: <1537356734-51676-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Sep 2018 20:58:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>
Date: Wed, 19 Sep 2018 19:32:09 +0800

> The issue is detected with the help of Coccinelle.

Series applied, thank you.
