Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA44BC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE6F219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE6F219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHFCSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 22:18:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42428 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeHFCSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 22:18:40 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 83DD4128F4E91;
        Sun,  5 Aug 2018 17:12:15 -0700 (PDT)
Date:   Sun, 05 Aug 2018 17:12:14 -0700 (PDT)
Message-Id: <20180805.171214.1083281848605802821.davem@davemloft.net>
To:     yangbo.lu@nxp.com
Cc:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        richardcochran@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2, 3/3] ptp_qoriq: support automatic configuration for ptp
 timer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180801100554.36634-3-yangbo.lu@nxp.com>
References: <20180801100554.36634-1-yangbo.lu@nxp.com>
        <20180801100554.36634-3-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 Aug 2018 17:12:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Wed,  1 Aug 2018 18:05:54 +0800

> This patch is to support automatic configuration for ptp timer.
> If required ptp dts properties are not provided, driver could
> try to calculate a set of default configurations to initialize
> the ptp timer. This makes the driver work for many boards which
> don't have the required ptp dts properties in current kernel.
> Also the users could set dts properties by themselves according
> to their requirement.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Dropped module_param.

Applied.
