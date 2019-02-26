Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8214CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F7A21852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfBZUbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:31:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59466 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:31:51 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0179314F24082;
        Tue, 26 Feb 2019 12:31:50 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:31:48 -0800 (PST)
Message-Id: <20190226.123148.2025630912555867905.davem@davemloft.net>
To:     leoyang.li@nxp.com
Cc:     ioana.ciornei@nxp.com, roy.pledge@nxp.com,
        ruxandra.radulescu@nxp.com, laurentiu.tudor@nxp.com,
        horia.geanta@nxp.com, brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CADRPPNSRpbD_dUZYJC4-SwudNk2JTPCug3T6g4dTYMBDQeeu7w@mail.gmail.com>
References: <20190224.220653.256212672271785631.davem@davemloft.net>
        <VI1PR0402MB280056BBF62A86E1703C549BE07A0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
        <CADRPPNSRpbD_dUZYJC4-SwudNk2JTPCug3T6g4dTYMBDQeeu7w@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Feb 2019 12:31:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 26 Feb 2019 13:03:17 -0600

> On Mon, Feb 25, 2019 at 1:01 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>>
>> > Subject: Re: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
>> >
>> > From: Ioana Ciornei <ioana.ciornei@nxp.com>
>> > Date: Sat, 23 Feb 2019 08:48:42 +0000
>> >
>> > > The first two patches enable cache stashing and configure the core
>> > > cluster destination per software portal while the third patch is the
>> > > one configuring the amount of stashing on a queue.
>> >
>> > Should I merge this series in via my networking tree?
>>
>> Even though it would be really good to have this on the networking tree as soon as possible, I am afraid that patch 2/3 is not going to apply cleanly because it touches the same areas of code that some other patches on Leo's tree are.
> 
> Hi David,
> 
> What shall we do if we want to get this in the 5.1?  Since the change
> on the ethernet driver is pretty small, can I get your ACK on that
> patch and merge the series through my tree?

Sure.

Acked-by: David S. Miller <davem@davemloft.net>
