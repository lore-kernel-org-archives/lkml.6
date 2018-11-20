Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47EDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8857F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8857F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeKTNXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:23:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57228 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbeKTNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:23:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B473414D5D736;
        Mon, 19 Nov 2018 18:57:01 -0800 (PST)
Date:   Mon, 19 Nov 2018 18:57:01 -0800 (PST)
Message-Id: <20181119.185701.1053620131675920213.davem@davemloft.net>
To:     joe@perches.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [resend PATCH for 3rd time] rxrpc: Neaten logging macros and
 add KERN_DEBUG logging level
From:   David Miller <davem@davemloft.net>
In-Reply-To: <322d852e776daacb811063031257124dd8949921.camel@perches.com>
References: <35831b4769a0415ae7b975e88badb3033dbfe82d.1522176274.git.joe@perches.com>
        <60269865c424b9fa853e22c68c0376a60bfbb171.camel@perches.com>
        <322d852e776daacb811063031257124dd8949921.camel@perches.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 19 Nov 2018 18:57:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Mon, 19 Nov 2018 12:35:52 -0800

> When enabled, the current debug logging does not have a KERN_<LEVEL>.
> Add KERN_DEBUG to the logging macros.
> 
> Miscellanea:
> o Remove #define redundancy and neaten the macros a bit> 
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> v3: Remerge into -next, with new file/patch offsets

David, please review and integrate this.
