Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E6A20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E6A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeIHCdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:33:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53322 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbeIHCdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:33:46 -0400
Received: from localhost (unknown [207.32.164.225])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C9A0E147B789D;
        Fri,  7 Sep 2018 14:50:48 -0700 (PDT)
Date:   Fri, 07 Sep 2018 14:50:48 -0700 (PDT)
Message-Id: <20180907.145048.132302042564688282.davem@davemloft.net>
To:     igor.stoppa@gmail.com
Cc:     madalin.bucur@nxp.com, igor.stoppa@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] freescale: ethernet: remove unnecessary unlikely()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180907172318.29014-1-igor.stoppa@huawei.com>
References: <20180907172318.29014-1-igor.stoppa@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Sep 2018 14:50:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Stoppa <igor.stoppa@gmail.com>
Date: Fri,  7 Sep 2018 20:23:18 +0300

> Both WARN_ON() and WARN_ONCE() already contain an unlikely(), so it's not
> necessary to wrap it into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

Applied.
