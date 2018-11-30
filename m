Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD65C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CCF2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CCF2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeK3LJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:09:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37880 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeK3LJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:09:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AA43514E2F93A;
        Thu, 29 Nov 2018 16:01:52 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:01:51 -0800 (PST)
Message-Id: <20181129.160151.275667577437770356.davem@davemloft.net>
To:     pavel@ucw.cz
Cc:     dmitry.bezrukov@aquantia.com, igor.russkikh@aquantia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: default-y for Aquantia AQtion USB to 5GbE (in -next)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181129234432.GA25059@amd>
References: <20181129234432.GA25059@amd>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Nov 2018 16:01:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 30 Nov 2018 00:44:32 +0100

> In -next we have new driver, and it is default-y.
> 
> I'm pretty sure that's a no-no.
> 
> Can someone please fix it?

Done.
