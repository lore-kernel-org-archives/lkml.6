Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA7AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5A52154E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5A52154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbeHBTWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:22:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43350 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbeHBTWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:22:53 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F07361008E54F;
        Thu,  2 Aug 2018 10:30:46 -0700 (PDT)
Date:   Thu, 02 Aug 2018 10:30:46 -0700 (PDT)
Message-Id: <20180802.103046.887546792433574184.davem@davemloft.net>
To:     maninder1.s@samsung.com
Cc:     shuahkh@osg.samsung.com, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com, pankaj.m@samsung.com, a.sahrawat@samsung.com,
        v.narang@samsung.com
Subject: Re: [PATCH 1/1] selftest/net: fix protocol family to work for IPv4.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2~HCQZjTEZd0101301013epcas5p3C@epcas5p3.samsung.com>
References: <CGME20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2@epcas5p3.samsung.com>
        <20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2~HCQZjTEZd0101301013epcas5p3C@epcas5p3.samsung.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 02 Aug 2018 10:30:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maninder Singh <maninder1.s@samsung.com>
Date: Thu,  2 Aug 2018 15:27:27 +0530

> use actual protocol family passed by user rather than hardcoded
> AF_INTE6 to cerate sockets.
> current code is not working for IPv4.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>

Applied.
