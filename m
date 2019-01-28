Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB348C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B72171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfA1S41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:56:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48386 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1S40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:56:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1887814EFCE7B;
        Mon, 28 Jan 2019 10:56:26 -0800 (PST)
Date:   Mon, 28 Jan 2019 10:56:25 -0800 (PST)
Message-Id: <20190128.105625.1531145408099541707.davem@davemloft.net>
To:     lkundrak@v3.sk
Cc:     sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] benet: remove broken and unused macro
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190128161740.16129-1-lkundrak@v3.sk>
References: <20190128161740.16129-1-lkundrak@v3.sk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 28 Jan 2019 10:56:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 28 Jan 2019 17:17:40 +0100

> is_broadcast_packet() expands to compare_ether_addr() which doesn't
> exist since commit 7367d0b573d1 ("drivers/net: Convert uses of
> compare_ether_addr to ether_addr_equal"). It turns out it's actually not
> used.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied to net-next.
