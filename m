Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93439C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E8A214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E8A214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeIWGTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 02:19:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52502 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeIWGTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 02:19:24 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:b5c5:ae11:3e54:6a07])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F173D1478398E;
        Sat, 22 Sep 2018 17:23:56 -0700 (PDT)
Date:   Sat, 22 Sep 2018 17:23:56 -0700 (PDT)
Message-Id: <20180922.172356.2290660830752717495.davem@davemloft.net>
To:     haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc:     netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v2,0/3] hv_netvsc: Support LRO/RSC in the
 vSwitch
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
References: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 22 Sep 2018 17:23:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Fri, 21 Sep 2018 18:20:34 +0000

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The patch adds support for LRO/RSC in the vSwitch feature. It reduces
> the per packet processing overhead by coalescing multiple TCP segments
> when possible. The feature is enabled by default on VMs running on
> Windows Server 2019 and later.
> 
> The patch set also adds ethtool command handler and documents.

Series applied, thank you.
