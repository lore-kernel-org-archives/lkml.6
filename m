Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25229ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B923421523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B923421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389991AbeIUTmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:42:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIUTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:42:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E3D3FAB;
        Fri, 21 Sep 2018 13:53:44 +0000 (UTC)
Date:   Fri, 21 Sep 2018 15:53:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] UBIFS fixes for 4.19-rc4
Message-ID: <20180921135342.GA13900@kroah.com>
References: <3383200.5o9oegka29@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3383200.5o9oegka29@blindfold>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:33:15AM +0200, Richard Weinberger wrote:
> Greg,
> 
> The following changes since commit ae596de1a0c8c2c924dc99d23c026259372ab234:
> 
>   Compiler Attributes: naked can be shared (2018-09-20 15:23:58 +0200)

Wow, bold move, new patches with less than 24 hours in your tree.  That
means linux-next didn't see them :(

> are available in the Git repository at:
> 
>   git://git.infradead.org/linux-ubifs.git tags/upstream-4.19-rc4

Now pulled, but really, don't you think that they should at least go
through 0-day first?  Maybe no one runs ubifs on mainline kernels...

thanks,

greg k-h
