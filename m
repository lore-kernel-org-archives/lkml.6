Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D60AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490692443A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490692443A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933358AbeGCJSA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:18:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeGCJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:17:58 -0400
Received: from localhost (unknown [37.171.46.72])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83969F22;
        Tue,  3 Jul 2018 09:17:56 +0000 (UTC)
Date:   Tue, 3 Jul 2018 11:17:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 3.18 35/85] parisc: Move setup_profiling_timer() out of
 init section
Message-ID: <20180703091750.GA4005@kroah.com>
References: <20180701153122.365061142@linuxfoundation.org>
 <20180701153123.756542422@linuxfoundation.org>
 <18c43f1b-fb29-97a0-883a-d71fd2de80c5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c43f1b-fb29-97a0-883a-d71fd2de80c5@gmx.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 06:29:54PM +0200, Helge Deller wrote:
> Hi Greg,
> 
> On 01.07.2018 18:01, Greg Kroah-Hartman wrote:
> > 3.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Helge Deller <deller@gmx.de>
> > 
> > [ Upstream commit 01f56832cfb6fcc204e7203f46841b6185ebd574 ]
> 
> I wonder how this patch and patch #22 ([PATCH 3.18 22/85] parisc: drivers.c: Fix section mismatches)
> reached the stable trees?
> I haven't tagged upstream commit 01f56832cfb6fcc204e7203f46841b6185ebd574 or 
> b819439fea305a0bfd6ca23a7994fd1a8847c0d8 for backport.
> 
> Anyway, I'd suggest not to apply both.
> I haven't tested them in those old kernels....

Ok, both now dropped, thanks.

greg k-h
