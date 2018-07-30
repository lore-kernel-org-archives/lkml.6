Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A8716256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D1720870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D1720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeG3SDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:03:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60810 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:03:40 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A9187108B3CFE;
        Mon, 30 Jul 2018 09:27:55 -0700 (PDT)
Date:   Mon, 30 Jul 2018 09:27:54 -0700 (PDT)
Message-Id: <20180730.092754.336274643884774209.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     derek.chickles@caviumnetworks.com,
        satananda.burla@caviumnetworks.com,
        felix.manlunas@caviumnetworks.com,
        raghu.vatsavayi@caviumnetworks.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] liquidio: remove redundant function
 cn23xx_dump_iq_regs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180730110341.1656-1-yuehaibing@huawei.com>
References: <20180730110341.1656-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 09:27:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 30 Jul 2018 19:03:41 +0800

> There are no in-tree callers of cn23xx_dump_iq_regs.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
