Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF4CECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6242F2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6242F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbeITLv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 07:51:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35456 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731260AbeITLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 07:51:27 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D68A146501C4;
        Wed, 19 Sep 2018 23:09:43 -0700 (PDT)
Date:   Wed, 19 Sep 2018 23:09:42 -0700 (PDT)
Message-Id: <20180919.230942.1647513192306122153.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] e1000: remove set but not used variable
 'txb2b'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1537409078-2374-1-git-send-email-yuehaibing@huawei.com>
References: <1537409078-2374-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Sep 2018 23:09:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 20 Sep 2018 02:04:38 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/intel/e1000/e1000_main.c: In function 'e1000_watchdog':
> drivers/net/ethernet/intel/e1000/e1000_main.c:2436:9: warning:
>  variable 'txb2b' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
