Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D169BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85352208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGa4vBoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85352208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeFNGmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752765AbeFNGmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:42:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371D0208CB;
        Thu, 14 Jun 2018 06:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528958573;
        bh=952a7zewhQwc3UX+Vh5vvahSfthqdp4bW7St1GDj0uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGa4vBoA9I1YVQ0GFk5jX3Tj/Jqdbtyba/pcrHsMKaf9LCiGJNJvTZhcjfQHbkGgH
         2hxf2/Hcj2AQvfC9iP22pkpsFJZ0L2xL43DOZBJRENcuIVWkgWa0KQW1xHu6DhhQeJ
         WlgeQSlNbApZb4GT80+FxGWRiApt+7K4qvzO7qmY=
Date:   Thu, 14 Jun 2018 08:42:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Parth Y Shah <sparth1292@gmail.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fixed a checkpatch error
Message-ID: <20180614064229.GA12429@kroah.com>
References: <b34abe879f77c55d29ef8a2b1cd9aa0e09ee2a3b.camel@perches.com>
 <1528957966-24707-1-git-send-email-sparth1292@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528957966-24707-1-git-send-email-sparth1292@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:02:46PM +0530, Parth Y Shah wrote:
> ERROR: code indent should use tabs where possible
> 
> Here, spaces are replaced by a tab in 2 lines.
> 
> Signed-off-by: Parth Y Shah <sparth1292@gmail.com>

Your subject line needs work, please see how other subject lines are
composed for this subsystem.

Also note, please do not use anything but the drivers/staging/ area of
the kernel for beginning "I'm going to do checkpatch cleanups" type of
"learning to get changes into the kernel" work.  That is a great place
to start with this, not in other subsystems where you might have
reviewers who do not care so much about whitespace cleanups like this.

So please learn the process there, and when you have it all working
well, then you could move on to other subsystems and areas of the
kernel, like this one, if you want to.

thanks,

greg k-h
