Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA57C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 06:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F1820837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 06:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F1820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeIAKVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 06:21:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44050 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeIAKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 06:21:00 -0400
Received: from localhost (unknown [172.58.43.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 62C901433DAAF;
        Fri, 31 Aug 2018 23:10:11 -0700 (PDT)
Date:   Fri, 31 Aug 2018 23:10:10 -0700 (PDT)
Message-Id: <20180831.231010.204871445950059123.davem@davemloft.net>
To:     pavel@ucw.cz
Cc:     trivial@kernel.org, netdev@vger.kernel.org,
        sowmini.varadhan@oracle.com, santosh.shilimkar@oracle.com,
        ka-cheong.poon@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/rds: RDS is not Radio Data System
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180830102336.GA21063@amd>
References: <20180830102336.GA21063@amd>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 31 Aug 2018 23:10:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 30 Aug 2018 12:23:37 +0200

> Getting prompt "The RDS Protocol" (RDS) is not too helpful, and it is
> easily confused with Radio Data System (which we may want to support
> in kernel, too).
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

Applied.
