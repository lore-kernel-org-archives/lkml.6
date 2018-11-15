Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61D8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A198D208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A198D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbeKPEOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:14:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43418 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbeKPEOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:14:08 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 849DD145E746A;
        Thu, 15 Nov 2018 10:05:17 -0800 (PST)
Date:   Thu, 15 Nov 2018 10:05:14 -0800 (PST)
Message-Id: <20181115.100514.102337102967411094.davem@davemloft.net>
To:     sabyasachi.linux@gmail.com
Cc:     khandual@linux.vnet.ibm.com, jrdr.linux@gmail.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com
Subject: Re: [PATCH] arch/sparc: Use kzalloc_node
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAJr6mf0GLRQiu-FBjQfWmvJsAPQLsY8XH_aacgHUmxz=yts-Wg@mail.gmail.com>
References: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
        <CAJr6mf0GLRQiu-FBjQfWmvJsAPQLsY8XH_aacgHUmxz=yts-Wg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 15 Nov 2018 10:05:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Thu, 15 Nov 2018 23:23:42 +0530

> On Sat, Nov 3, 2018 at 10:54 AM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
>>
>> Replaced kmalloc_node + memset with kzalloc_node
>>
>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> 
> Any comment on this patch?

Just too busy to get to it and am at plumbers this week.

Will try to look at it next week.
