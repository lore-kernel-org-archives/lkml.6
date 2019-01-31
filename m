Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16379C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEF4218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfAaRhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:37:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33480 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfAaRhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:37:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DD52014F85B0C;
        Thu, 31 Jan 2019 09:37:44 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:37:44 -0800 (PST)
Message-Id: <20190131.093744.1600285273131737456.davem@davemloft.net>
To:     herbert@gondor.apana.org.au
Cc:     bvanassche@acm.org, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/test_rhashtable: Make test_insert_dup()
 allocate its hash table dynamically
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190131120826.l4xd3vfonwmldudd@gondor.apana.org.au>
References: <20190130184230.225631-1-bvanassche@acm.org>
        <20190131120826.l4xd3vfonwmldudd@gondor.apana.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 31 Jan 2019 09:37:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 31 Jan 2019 20:08:26 +0800

> On Wed, Jan 30, 2019 at 10:42:30AM -0800, Bart Van Assche wrote:
>> The test_insert_dup() function from lib/test_rhashtable.c passes a
>> pointer to a stack object to rhltable_init(). Allocate the hash table
>> dynamically to avoid that the following is reported with object
>> debugging enabled:
 ...
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
 ...
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks everyone.
