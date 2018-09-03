Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A58C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93A32075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93A32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeICJfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:35:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38370 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeICJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:35:13 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 208C41437516D;
        Sun,  2 Sep 2018 22:16:44 -0700 (PDT)
Date:   Sun, 02 Sep 2018 22:16:40 -0700 (PDT)
Message-Id: <20180902.221640.2061012272900735759.davem@davemloft.net>
To:     vakul.garg@nxp.com
Cc:     sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: Signed-off-by missing for commit in the net-next
 tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <DB7PR04MB4252FC3E1B9B2A56C5B81B268B0C0@DB7PR04MB4252.eurprd04.prod.outlook.com>
References: <20180903074043.65038277@canb.auug.org.au>
        <DB7PR04MB4252FC3E1B9B2A56C5B81B268B0C0@DB7PR04MB4252.eurprd04.prod.outlook.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Sep 2018 22:16:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vakul Garg <vakul.garg@nxp.com>
Date: Mon, 3 Sep 2018 05:08:08 +0000

> 
>> -----Original Message-----
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Sent: Monday, September 3, 2018 3:11 AM
>> To: David Miller <davem@davemloft.net>; Networking
>> <netdev@vger.kernel.org>
>> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel
>> Mailing List <linux-kernel@vger.kernel.org>; Vakul Garg
>> <vakul.garg@nxp.com>
>> Subject: linux-next: Signed-off-by missing for commit in the net-next tree
>> 
>> Hi all,
>> 
>> Commit
>> 
>>   c2ad647c6442 ("selftests/tls: Add test for recv(PEEK) spanning across
>> multiple records")
>> 
>> is missing a Signed-off-by from its author.
>> 
> 
> It is my fault to miss adding signoff.
> I am sorry about that.
> Please advise if I need to do something to fix it.

There is nothing you need to do, and since commits in my tree are immutable
once pushed out it cannot be fixed.
