Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F29C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB57620BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB57620BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeGKO13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:27:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbeGKO13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:27:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 05C27C3C;
        Wed, 11 Jul 2018 14:22:52 +0000 (UTC)
Date:   Wed, 11 Jul 2018 16:22:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <arigead@gmail.com>
Cc:     devel@driverdev.osuosl.org, kstewart@linuxfoundation.org,
        keescook@chromium.org, aastha.gupta4104@gmail.com,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 3/8] staging:rtl8192u: Correct spacing before and
 after parenthesis - Style
Message-ID: <20180711142250.GA3907@kroah.com>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
 <20180710150523.17384-4-johnfwhitmore@gmail.com>
 <20180711111349.GA28836@kroah.com>
 <20180711140935.GC26416@xux707-tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711140935.GC26416@xux707-tw>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:09:37PM +0100, John Whitmore wrote:
> On Wed, Jul 11, 2018 at 01:13:49PM +0200, Greg KH wrote:
> > On Tue, Jul 10, 2018 at 04:05:18PM +0100, John Whitmore wrote:
> > > Corrected coding style issues aroung opening and closed parenthesis. Spaces, or blank line, removed from after '(' or before ')'
> > 
> > Wrap your changelog text at 72 columns like your editor asked you to :(
> > 
> > I'll fix it up this time...
> 
> Oops sorry and thanks. I thought the magic number was 75 which I got from:
> 
> https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html

75 works as well :)

