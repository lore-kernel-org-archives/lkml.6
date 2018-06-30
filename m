Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D9C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93A0256F7
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93A0256F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936883AbeF3LQX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 07:16:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754852AbeF3LQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 07:16:21 -0400
Received: from localhost (unknown [183.108.164.149])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4ABFA143A3494;
        Sat, 30 Jun 2018 04:16:19 -0700 (PDT)
Date:   Sat, 30 Jun 2018 20:16:15 +0900 (KST)
Message-Id: <20180630.201615.1561953485703310312.davem@davemloft.net>
To:     radhey.shyam.pandey@xilinx.com
Cc:     michal.simek@xilinx.com, joe@perches.com, andrew@lunn.ch,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/5] Fixes coding style in xilinx_emaclite.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 30 Jun 2018 04:16:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Date: Thu, 28 Jun 2018 18:41:45 +0530

> This patchset fixes checkpatch and kernel-doc warnings in
> xilinx emaclite driver. No functional change.
> 
> Changes from v2:
> -In 2/5 patch refactor if-else to make failure path return early.
> -In 2/5 patch coalesce the format onto a single line and add the
> missing space after the comma.

Series applied.
