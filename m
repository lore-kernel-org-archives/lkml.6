Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68316C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF4521A8F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF4521A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeGDKvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:51:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50182 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbeGDKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:51:49 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id ed34b3e95326cd13; Wed, 4 Jul 2018 12:51:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     cgxu519 <cgxu519@gmx.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/power: cast PAGE_SIZE to int when comparing with error code
Date:   Wed, 04 Jul 2018 12:50:24 +0200
Message-ID: <1745546.7bUhTGqjo6@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0gpBShiR5oQawfrLh_fMBK7EqfPbT4TBeNDjn6Kkou_7A@mail.gmail.com>
References: <20180625053058.25206-1-cgxu519@gmx.com> <0a812d02-d85d-f685-6e7f-f4dfe22f9629@gmx.com> <CAJZ5v0gpBShiR5oQawfrLh_fMBK7EqfPbT4TBeNDjn6Kkou_7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 2, 2018 9:14:03 AM CEST Rafael J. Wysocki wrote:
> On Mon, Jul 2, 2018 at 3:10 AM, cgxu519 <cgxu519@gmx.com> wrote:
> > Hi Rafael,
> >
> > Could you have a look at this simple patch?
> 
> I've done that already and I'm going to apply it.

Applied now, thanks!

