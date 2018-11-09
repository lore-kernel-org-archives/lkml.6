Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7823A20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7823A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeKJI7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:59:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60952 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeKJI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:59:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 44C5B14BF6737;
        Fri,  9 Nov 2018 15:17:10 -0800 (PST)
Date:   Fri, 09 Nov 2018 15:17:09 -0800 (PST)
Message-Id: <20181109.151709.1128248834308208677.davem@davemloft.net>
To:     jian.w.wen@oracle.com
Cc:     netdev@vger.kernel.org, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen/netfront: remove unnecessary wmb
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181109065359.14900-1-jian.w.wen@oracle.com>
References: <20181109065359.14900-1-jian.w.wen@oracle.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 09 Nov 2018 15:17:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Wen <jian.w.wen@oracle.com>
Date: Fri,  9 Nov 2018 14:53:59 +0800

> RING_PUSH_REQUESTS_AND_CHECK_NOTIFY is already able to make sure backend sees
> requests before req_prod is updated.
> 
> Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>

Applied to net-next.
