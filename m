Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF88C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E097213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E097213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJCRxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:53:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCRxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:53:09 -0400
Received: from localhost (h126.142.139.40.ip.windstream.net [40.139.142.126])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6350BA48;
        Wed,  3 Oct 2018 11:05:15 +0000 (UTC)
Date:   Wed, 3 Oct 2018 04:05:14 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH v2 01/15] platform: goldfish: pipe: Move the file-scope
 goldfish_interrupt_tasklet variable into the driver state
Message-ID: <20181003110514.GA12267@kroah.com>
References: <20181002231024.58408-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002231024.58408-1-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 04:10:22PM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> This is a series of patches to move mutable file-scope variables
> into the driver state. This change will help to introduce another
> version of the pipe driver (with different state) for the older
> host interface or having several instances of this device.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> Changes in v2:
>  - Updated the commit message.

I only received 3 emails in this series.  Always resend them all.

thanks,

greg k-h
