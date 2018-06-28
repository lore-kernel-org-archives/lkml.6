Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC9726C6F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC9726C6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeF1Eol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:44:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeF1Eok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:44:40 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 98E3F89B;
        Thu, 28 Jun 2018 04:44:39 +0000 (UTC)
Date:   Wed, 27 Jun 2018 21:44:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: condemn myself to MAINTAINERS
Message-Id: <20180627214438.6fd16516e36b6651f604d4f4@linux-foundation.org>
In-Reply-To: <2b13e28cea3a62bb57eb24a164772ea46a9fb6d3.camel@perches.com>
References: <20180627194840.GA18113@avx2>
        <99aa610d5052b986dca67daaa7e102a57096bd42.camel@perches.com>
        <20180627181300.49a572fe9fd28694e9102f5f@linux-foundation.org>
        <2b13e28cea3a62bb57eb24a164772ea46a9fb6d3.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 21:18:34 -0700 Joe Perches <joe@perches.com> wrote:

> On Wed, 2018-06-27 at 18:13 -0700, Andrew Morton wrote:
> > On Wed, 27 Jun 2018 18:05:35 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> > > On Wed, 2018-06-27 at 22:48 +0300, Alexey Dobriyan wrote:
> > > > I know I'll regret it.
> > > 
> > > This wasn't applied back in February?
> > 
> > Well I thought it was, but I can't find such a patch anywhere.
> 
> https://patchwork.kernel.org/patch/10196137/

Ah, OK.  You asked a question so I took a pass, awaiting the reply
which never came.

> btw:
> 
> Isn't your mail archive the seed file for the new lkml archive?
> https://www.kernel.org/lore.html

I believe so.

> Maybe there are gaps there too?

Not many.  A few perhaps, where I fat-fingered things or where mail
server glitches happened.  But gaps will be few.

