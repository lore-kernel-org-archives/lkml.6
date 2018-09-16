Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C6ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 05:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927B220883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 05:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927B220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeIPLQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 07:16:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeIPLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 07:16:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AD8FE910;
        Sun, 16 Sep 2018 05:54:25 +0000 (UTC)
Date:   Sun, 16 Sep 2018 07:54:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pablo Pellecchia <pablo9891@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] :Staging :Wlan-ng Fixed coding style issues
Message-ID: <20180916055423.GA20936@kroah.com>
References: <20180916042326.22178-1-pablo9891@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916042326.22178-1-pablo9891@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 01:23:26AM -0300, Pablo Pellecchia wrote:
> Fixed coding style issues on wlan-ng directory.
> 
> Changes include:
> 	- Parenthesis alignment
> 	- Wrong casting issues
> 	- Adding comments
>     - Lines ending with '('
> 
> Signed-off-by: Pablo Pellecchia <pablo9891@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c   | 40 +++++++++++++++++-------------------
>  drivers/staging/wlan-ng/hfa384x.h    |  5 +++--
>  drivers/staging/wlan-ng/p80211conv.c |  2 +-
>  drivers/staging/wlan-ng/prism2mgmt.c | 28 ++++++++++++-------------
>  4 files changed, 37 insertions(+), 38 deletions(-)

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
