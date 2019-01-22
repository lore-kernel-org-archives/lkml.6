Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381FAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE78520879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548154814;
	bh=4OalttqA8FfRTkoI8BA7XgZkcPkaXQAiGWwRBZyL0i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E388c9l4JiC3T/jo/BbktI5Jk0d06J3ie9vJgeKsmcZ4A6CxU/2WOTCbra9Tj0con
	 Og8nhpahUQz4U0tPhycSXQJsrY6GINyBtHBFyer2XP8RHM2hDGFseZBv9psKFUlufK
	 AKITRkjvXTGhnUwLrI0BKOLfipenIJJJ7f1WJVgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfAVLAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfAVLAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:00:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D259020870;
        Tue, 22 Jan 2019 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548154811;
        bh=4OalttqA8FfRTkoI8BA7XgZkcPkaXQAiGWwRBZyL0i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUK8w8VjsPqYdGNbSDzScxmxpDSaGfH766Cn10OdKtZcjf9SkOW/zlXi/8HPDWz3Y
         cYeKwWQcUYU6+GtUkMhbQ+xkMT5jLsn2JfA5A9gDIrqwvy1E4+eRhZ/0B++xt7VjN4
         mOUueOz6awgxCvGAQD9QIGnF/jhzdOOYg3SQt98s=
Date:   Tue, 22 Jan 2019 12:00:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wangbo <wdjjwb@163.com>
Cc:     linux-kernel@vger.kernel.org, wang.bo116@zte.com.cn
Subject: Re: [PATCH] uio:remove unneeded variable ret
Message-ID: <20190122110009.GA21034@kroah.com>
References: <1547034839-3493-1-git-send-email-wdjjwb@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547034839-3493-1-git-send-email-wdjjwb@163.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 07:53:59PM +0800, wangbo wrote:
> In uio_dmem_genirq_open the variable ret is unneededw,remove it now.

Minor typo in this sentence :(

> 
> Signed-off-by: wangbo <wang.bo116@zte.com.cn>

I need a "full" name for a patch to be able to be accepted.

thanks,

greg k-h
