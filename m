Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59154ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231F6208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231F6208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=online.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbeGLUzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:55:31 -0400
Received: from mout01.posteo.de ([185.67.36.141]:49075 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732523AbeGLUzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:55:31 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9BC76212DD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 22:44:14 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41RSbK2xw7z9rxR;
        Thu, 12 Jul 2018 22:44:13 +0200 (CEST)
Date:   Thu, 12 Jul 2018 22:44:13 +0200
From:   Felix Siegel <felix.siegel@online.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felix Siegel <felix.siegel@posteo.de>, devel@driverdev.osuosl.org,
        John Joseph <jnjoseph@google.com>,
        linux-kernel@vger.kernel.org, Rob Springer <rspringer@google.com>
Subject: Re: [PATCH 3/4] staging: gasket: fix multi line comments style
Message-Id: <20180712224413.cdc2714ee779bf7eaeabccc6@online.de>
In-Reply-To: <20180712195354.GB28761@kroah.com>
References: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
        <1531423694-22478-3-git-send-email-felix.siegel@posteo.de>
        <20180712195354.GB28761@kroah.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 21:53:54 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 12, 2018 at 09:27:14PM +0200, Felix Siegel wrote:
> > This patch fixes checkpatch.pl warnings:
> > 
> > WARNING: Block comments should align the * on each line
> > Signed-off-by: Felix Siegel <felix.siegel@posteo.de>
> 
> So close, I need a blank line before the signed-of-by line :(
> 
> I'll go edit it by hand, but be more careful next time please...
> 
> thanks,
> 
> greg k-h


Sorry, I'll look out for it next time.
Strange though, they were all added with format-patch -s.

Regards,
Felix
