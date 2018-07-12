Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058A0208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058A0208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeGLUE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:04:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbeGLUE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:04:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9257DB14;
        Thu, 12 Jul 2018 19:53:56 +0000 (UTC)
Date:   Thu, 12 Jul 2018 21:53:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felix Siegel <felix.siegel@posteo.de>
Cc:     devel@driverdev.osuosl.org, John Joseph <jnjoseph@google.com>,
        linux-kernel@vger.kernel.org, Rob Springer <rspringer@google.com>
Subject: Re: [PATCH 3/4] staging: gasket: fix multi line comments style
Message-ID: <20180712195354.GB28761@kroah.com>
References: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
 <1531423694-22478-3-git-send-email-felix.siegel@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531423694-22478-3-git-send-email-felix.siegel@posteo.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:27:14PM +0200, Felix Siegel wrote:
> This patch fixes checkpatch.pl warnings:
> 
> WARNING: Block comments should align the * on each line
> Signed-off-by: Felix Siegel <felix.siegel@posteo.de>

So close, I need a blank line before the signed-of-by line :(

I'll go edit it by hand, but be more careful next time please...

thanks,

greg k-h
