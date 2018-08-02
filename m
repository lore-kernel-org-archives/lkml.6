Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5F0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D5A21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D5A21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbeHBTN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:13:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43216 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeHBTN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:13:58 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8F2AE1008E03A;
        Thu,  2 Aug 2018 10:21:54 -0700 (PDT)
Date:   Thu, 02 Aug 2018 10:21:53 -0700 (PDT)
Message-Id: <20180802.102153.321128130359100641.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com
Subject: Re: [PATCH net-next] rxrpc: Remove set but not used variable 'nowj'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <153319761338.28801.14787677585388434259.stgit@warthog.procyon.org.uk>
References: <153319761338.28801.14787677585388434259.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 02 Aug 2018 10:21:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Aug 2018 09:13:33 +0100

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> net/rxrpc/proc.c: In function 'rxrpc_call_seq_show':
> net/rxrpc/proc.c:66:29: warning:
>  variable 'nowj' set but not used [-Wunused-but-set-variable]
>   unsigned long timeout = 0, nowj;
>                              ^
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied.
