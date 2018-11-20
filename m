Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F0CC04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B902087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP/X87zU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B902087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeKTUVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbeKTUVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:21:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F359C206BB;
        Tue, 20 Nov 2018 09:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542707585;
        bh=twOt4azuZD38jeCH+/v2IUdQgZCoy5rzkfOVjM5wPD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oP/X87zUsWivGgQkDm6BAnjYGO8ZNfTEVhTIkXhfMdpV1egZK4vg1K4VpTujuMEBt
         4nQjaSXNG1Plj5CnSEY2BEKe8W1xbzrdqkqpzWcpyCJDVOsFemXCYi8FmvmTUd8Op6
         92Q8Je35xhZZt94LqWYmF8lJyd3jqHuvS4eDfR98=
Date:   Tue, 20 Nov 2018 10:53:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kevin Dou <dkj0101@163.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>,
        Robert =?utf-8?B?V8SZY8WCYXdza2k=?= <r.weclawski@gmail.com>
Subject: Re: [PATCH] staging: rtl8188eu: core: coding style check
Message-ID: <20181120095303.GD8089@kroah.com>
References: <1542117978-22317-1-git-send-email-dkj0101@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542117978-22317-1-git-send-email-dkj0101@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 10:06:13PM +0800, Kevin Dou wrote:
> follow the linux coding style, rename the variable
> shortGIrate to short_gi_rate.
> 
> Signed-off-by: Kevin Dou <dkj0101@163.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_ap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

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

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
