Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE373ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A74F208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A74F208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeGPJBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:01:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbeGPJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:01:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 183B7CFD;
        Mon, 16 Jul 2018 08:34:43 +0000 (UTC)
Date:   Mon, 16 Jul 2018 10:34:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver =?iso-8859-1?Q?H=FCbers?= <oliver.huebers@web.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de,
        Vanessa Borgmann <nessa.x@web.de>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] staging: mt7621-pci: Fix coding style issues
 reported by checkpatch
Message-ID: <20180716083441.GA7903@kroah.com>
References: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
 <1531489266-20410-2-git-send-email-oliver.huebers@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531489266-20410-2-git-send-email-oliver.huebers@web.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 03:41:04PM +0200, Oliver Hübers wrote:
> From: Vanessa Borgmann <nessa.x@web.de>
> 
> Fix errors: space errors, braces
> Fix warnings: comment warnings
> 
> Signed-off-by: Oliver Hübers <oliver.huebers@web.de>
> Signed-off-by: Vanessa Borgmann <nessa.x@web.de>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 230 ++++++++++++++++----------------
>  1 file changed, 112 insertions(+), 118 deletions(-)

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
