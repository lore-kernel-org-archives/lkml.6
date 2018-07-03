Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A341C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319B42443A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319B42443A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeGCJQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:16:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38308 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeGCJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:16:11 -0400
Received: from localhost (unknown [220.83.184.29])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F1800108A8B58;
        Tue,  3 Jul 2018 02:16:09 -0700 (PDT)
Date:   Tue, 03 Jul 2018 18:16:06 +0900 (KST)
Message-Id: <20180703.181606.586574677884045550.davem@davemloft.net>
To:     deepa.kernel@gmail.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: Re: [PATCH 2/6] sparc: Make thread_info.h available directly
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180703054422.12089-3-deepa.kernel@gmail.com>
References: <20180703054422.12089-1-deepa.kernel@gmail.com>
        <20180703054422.12089-3-deepa.kernel@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 03 Jul 2018 02:16:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Mon,  2 Jul 2018 22:44:18 -0700

> linux/compat.h was including this indirectly for
> asm/compat.h dependencies.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
