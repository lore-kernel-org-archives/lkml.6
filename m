Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AF5204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AF5204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeGIMEv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:04:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeGIMEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:04:49 -0400
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0BAFECFD;
        Mon,  9 Jul 2018 12:04:48 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:04:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <arigead@gmail.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        aastha.gupta4104@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 03/12] staging:rtl8192u: Remove blank lines before '}'
 and after '{' characters
Message-ID: <20180709120445.GD5196@kroah.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
 <20180707145513.15325-3-johnfwhitmore@gmail.com>
 <20180708153811.GA29737@kroah.com>
 <20180709092953.hte2evscogprubr3@xux707-tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709092953.hte2evscogprubr3@xux707-tw>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:29:54AM +0100, John Whitmore wrote:
> On Sun, Jul 08, 2018 at 05:38:11PM +0200, Greg KH wrote:
> > On Sat, Jul 07, 2018 at 03:55:04PM +0100, John Whitmore wrote:
> > > Coding style change to simply remove the unrequired spaces before a closing
> > > brace or before an opening brace.
> > 
> > That would be good, but that's not what this patch does :(
> > 
> > It removes lines, not spaces, as the subject line said.  You also fix up
> > an indentation as well.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Just for clarification, before I assume something and make a mistake, I'm
> wondering about this patch set. I got auto notification to say that patches 1,
> 2, 4, & 6 had been accepted and merged with staging-next. And I got this email
> to explain why patch number 3 wasn't up to scratch.
> 
> But that leaves 5, 7, 8, 9, 10, 11 & 12. I'm assuming that they didn't apply
> and I that I can resubmit them with a fixed up patch number 3. That seems
> logical to me so I'll work on that basis for the moment. Thought I'd better
> check, before I confuse people, with an erroneous assumption.

Yes, that is correct.

thanks,

greg k-h
