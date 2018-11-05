Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB37C46464
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5146B22577
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5146B22577
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbeKFDdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:33:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59482 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbeKFDdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:33:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 40307144A04B7;
        Mon,  5 Nov 2018 10:12:10 -0800 (PST)
Date:   Mon, 05 Nov 2018 10:12:09 -0800 (PST)
Message-Id: <20181105.101209.563084010777423448.davem@davemloft.net>
To:     rdunlap@infradead.org
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        0xeffeff@gmail.com
Subject: Re: linux-next: Tree for Nov 5 (net/ipv6/af_inet6)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2ad190b3-0b0d-972b-2a6e-16abf4a81c5b@infradead.org>
References: <20181105165109.410358fd@canb.auug.org.au>
        <2ad190b3-0b0d-972b-2a6e-16abf4a81c5b@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 10:12:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 5 Nov 2018 08:21:28 -0800

> On 11/4/18 9:51 PM, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20181102:
>> 
>> Non-merge commits (relative to Linus' tree): 418
> 
> on i386 or x86_64:
> 
> ld: net/ipv6/af_inet6.o: in function `inet6_init':
> af_inet6.c:(.init.text+0x285): undefined reference to `ipv6_anycast_init'
> ld: af_inet6.c:(.init.text+0x376): undefined reference to `ipv6_anycast_cleanup'
> 
> 
> Full randconfig file is attached (for i386).

Jeff, please fix this.
