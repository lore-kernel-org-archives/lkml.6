Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4601CECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 03:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C735220831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 03:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C735220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeJYLvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 07:51:17 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35521 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeJYLvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 07:51:16 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w9P3KGx9025766;
        Thu, 25 Oct 2018 05:20:16 +0200
Date:   Thu, 25 Oct 2018 05:20:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Joe Perches <joe@perches.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Fengguang Wu <fengguang.wu@intel.com>,
        David Miller <davem@davemloft.net>, wanghaifine@gmail.com,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        LKP <lkp@intel.com>, Philip Li <philip.li@intel.com>
Subject: Re: [PATCH] Change judgment len position
Message-ID: <20181025032016.GA25756@1wt.eu>
References: <20181024154729.5312-1-wanghaifine@gmail.com>
 <20181024.101028.1211941922121897721.davem@davemloft.net>
 <61d94f2a5563db4d6580c8385c3b93c8eeb3669a.camel@perches.com>
 <20181024204852.GA25509@1wt.eu>
 <49ec92564284b5beb0a151bce1d537b51340d0a8.camel@perches.com>
 <20181025011111.bhbstq5wtrwk26b5@wfg-t540p.sh.intel.com>
 <dda151c160e42aeb07d158d9c7cd4c1a3341ab5f.camel@perches.com>
 <20181025022027.GG32577@ZenIV.linux.org.uk>
 <4664b8b350ed35ee24746fd34fb0e600ced776a5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4664b8b350ed35ee24746fd34fb0e600ced776a5.camel@perches.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 07:41:52PM -0700, Joe Perches wrote:
> The Code of Conduct, if it exists at all, should apply
> to all of the kernel.
> 
> And no, as I have previously posted, I don't agree with
> it nor the method that was used to introduce it.
> 
> But it does exist.
> Its splatter affects us all.

Then just like any rule, start to use it as a guideline and not as
something extremely strict to apply to others. If someone feels
offended he can complain, there's no reason for suggesting that
maybe someone else could have felt offended, otherwise we'll end
up with a new code of thinking to explain how to think what others
could feel like...

Willy
