Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F40ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656A520875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656A520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbeGXNGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:06:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbeGXNGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:06:47 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2E102CB0;
        Tue, 24 Jul 2018 12:00:30 +0000 (UTC)
Date:   Tue, 24 Jul 2018 14:00:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Railton <mark@markrailton.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers: Staging: pi433: remove unsused case
Message-ID: <20180724120027.GA23059@kroah.com>
References: <20180721121758.7480-1-mark@markrailton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721121758.7480-1-mark@markrailton.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 01:17:58PM +0100, Mark Railton wrote:
> Removed a commented out case statement
> 
> Signed-off-by: Mark Railton <mark@markrailton.com>
> ---
>  drivers/staging/pi433/rf69.c | 3 ---
>  1 file changed, 3 deletions(-)

Where is patch 1/2 of this series?

And this patch doesn't apply at all, what tree did you make it against?

Please fix up and resend.

thanks,

greg k-h
