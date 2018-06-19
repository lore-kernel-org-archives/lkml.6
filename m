Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9D7C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DA520836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DA520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbeFSWzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:55:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49542 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753872AbeFSWzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:55:48 -0400
Received: from localhost (unknown [61.102.160.116])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B9DE51435F3F2;
        Tue, 19 Jun 2018 15:55:46 -0700 (PDT)
Date:   Wed, 20 Jun 2018 07:55:45 +0900 (KST)
Message-Id: <20180620.075545.1903230763984075455.davem@davemloft.net>
To:     radhey.shyam.pandey@xilinx.com
Cc:     andrew@lunn.ch, michal.simek@xilinx.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Fixes coding style in xilinx_emaclite.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Jun 2018 15:55:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Date: Mon, 18 Jun 2018 17:20:05 +0530

> This patchset fixes checkpatch and kernel-doc warnings in
> xilinx emaclite driver. No functional change.

Such cleanups are only appropriate for net-next, which is closed at this
time.
