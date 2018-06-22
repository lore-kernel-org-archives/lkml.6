Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31170C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504B208F7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504B208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFVHUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:20:10 -0400
Received: from muru.com ([72.249.23.125]:48668 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeFVHUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:20:08 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2E58C80C5;
        Fri, 22 Jun 2018 07:22:53 +0000 (UTC)
Date:   Fri, 22 Jun 2018 00:20:05 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: v4.18-rc1 on droid 4: very bad CPU performance
Message-ID: <20180622072005.GF112168@atomide.com>
References: <20180621121542.GA4836@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621121542.GA4836@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180621 12:18]:
> Hi!
> 
> V4.18 is slower than it should be.
> 
> user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> | wc -c
> 10044291
> 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> user@devuan:~$ uname -a
> Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> 19:26:37 CEST 2018 armv7l GNU/Linux
> 
> That bzip should take 12 seconds, not minute.
> 
> Any ideas? Do you see it, too?

I've noticed firefox is super slow.. Git bisect time?

Regards,

Tony


