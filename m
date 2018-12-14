Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC31C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF869206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeLNTDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:03:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59242 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbeLNTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:03:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3BFB714DF1AA7;
        Fri, 14 Dec 2018 11:03:10 -0800 (PST)
Date:   Fri, 14 Dec 2018 11:03:09 -0800 (PST)
Message-Id: <20181214.110309.1172531312891958180.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
Cc:     edumazet@google.com, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        soheil@google.com, ycheng@google.com
Subject: Re: [PATCH 4.14 12/89] tcp: Do not underestimate rwnd_limited
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181214143614.GA29266@kroah.com>
References: <20181214142621.GA28340@kroah.com>
        <CANn89iKnuwQAybYEtXwvRFfQ8Rp8VihO16bVucAjDn1GRBtv9w@mail.gmail.com>
        <20181214143614.GA29266@kroah.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 11:03:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 14 Dec 2018 15:36:14 +0100

> On Fri, Dec 14, 2018 at 06:29:54AM -0800, Eric Dumazet wrote:
>> I ack it, I guess David had this queued already.
>> 
>> No big deal, that is only for tcp_info instrumentation accuracy.
> 
> If this is already queued for the next round of stable patches, and it's
> not a major issue, I'll just wait and take it when it shows up in a week
> or so.

Turns out I actually didn't have it queued, so Greg if you could toss
this into your trees now it would save me a bunch of coordinating and
work.

Thanks!
