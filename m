Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E37C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7441A2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeKRG7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:59:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeKRG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:59:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF00814700FAD;
        Sat, 17 Nov 2018 12:41:36 -0800 (PST)
Date:   Sat, 17 Nov 2018 12:41:36 -0800 (PST)
Message-Id: <20181117.124136.272914481117335020.davem@davemloft.net>
To:     julietk@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, tlfalcon@linux.vnet.ibm.com,
        mwb@linux.vnet.ibm.com, tyreld@linux.vnet.ibm.com
Subject: Re: [PATCH] net/ibmnvic: Fix deadlock problem in reset
From:   David Miller <davem@davemloft.net>
In-Reply-To: <25faa351-51d3-3aeb-a1c9-e8d3259604dd@linux.vnet.ibm.com>
References: <25faa351-51d3-3aeb-a1c9-e8d3259604dd@linux.vnet.ibm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 17 Nov 2018 12:41:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Your patch is completely corrupted by your email client.

Please fix this.

Then, email a test patch privately to yourself.

Please do not post your patch to this mailing list again until you can
successfully apply the test patch you email to yourself in the step
above.

Thank you.
