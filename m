Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D4BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8C21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQlSiV1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A8C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJIU0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeJIU0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:26:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49B8213A2;
        Tue,  9 Oct 2018 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539090584;
        bh=NJ5xFm72KyUNI8+P3ngJehSnDXBykoaQ8H/iUNjDRsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQlSiV1w/C6FfGBdT4/ybpwoSmADtQu9gktPDF4M4gNUddgzuvqLA0PJtAr9D9cha
         SV1B+6UnZ/9dDIGlykYNL3huc8RUuYUkaQYh6fLIky1vf3csMi73WzryyWrwcQMeFX
         8YHzMK53H6ymkaOX6Lm61iqp4Gad1In7A9fA8K5U=
Date:   Tue, 9 Oct 2018 15:09:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     chrisadr@gentoo.org, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] STAGING/EMXX_UDC: Fixed all meaningful sparse errors.
Message-ID: <20181009130941.GB25423@kroah.com>
References: <1538810019-98403-1-git-send-email-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538810019-98403-1-git-send-email-carmeli.tamir@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 03:13:39AM -0400, Carmeli Tamir wrote:
> Fixed all meaningful sparse errors: 
> 1. Added static to udc_controller 
> 2. Added mising __iomem modifier to handle p_regs 
> 3. Added missing le16_to_cpu
> 
> Signed-off-by: Tamir Carmeli <carmeli.tamir@gmail.com>
> ---
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
