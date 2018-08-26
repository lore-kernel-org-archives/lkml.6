Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6962C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 00:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257B820A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 00:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257B820A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHZERU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 00:17:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60666 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeHZERU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 00:17:20 -0400
Received: from localhost (50-243-110-91-static.hfc.comcastbusiness.net [50.243.110.91])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1C268145F7071;
        Sat, 25 Aug 2018 17:36:42 -0700 (PDT)
Date:   Sat, 25 Aug 2018 17:36:41 -0700 (PDT)
Message-Id: <20180825.173641.1890220553842463695.davem@davemloft.net>
To:     Haiqing.Bai@windriver.com
Cc:     netdev@vger.kernel.org, jon.maloy@ericsson.com,
        ying.xue@windriver.com, zhenbo.gao@windriver.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: fix the big/little endian issue in tipc_dest
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1535014158-18578-1-git-send-email-Haiqing.Bai@windriver.com>
References: <1535014158-18578-1-git-send-email-Haiqing.Bai@windriver.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 25 Aug 2018 17:36:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiqing Bai <Haiqing.Bai@windriver.com>
Date: Thu, 23 Aug 2018 16:49:18 +0800

> Fixes: d06b2fa34f18 ("tipc: improve destination linked list")

Please fix this:

[davem@localhost net]$ git describe d06b2fa34f18
fatal: Not a valid object name d06b2fa34f18
