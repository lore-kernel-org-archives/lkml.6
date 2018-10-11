Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E7C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF5E2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF5E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeJLCfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:35:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60834 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeJLCfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:35:14 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 167F812DE580F;
        Thu, 11 Oct 2018 12:06:43 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:06:42 -0700 (PDT)
Message-Id: <20181011.120642.1884317415368072192.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     oliver@neukum.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] net: cdc_ncm: use tasklet_init() for tasklet_struct
 init
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181011130332.25710-1-ben.dooks@codethink.co.uk>
References: <20181011130332.25710-1-ben.dooks@codethink.co.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Oct 2018 12:06:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 11 Oct 2018 14:03:32 +0100

> The tasklet initialisation would be better done by tasklet_init()
> instead of assuming all the fields are in an ok state by default.
> 
> This does not fix any actual know bug.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to net-next.
