Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BD1C169D4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBAC2243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GohbJXgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBAC2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeKMG2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeKMG17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:27:59 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3526D2243E;
        Mon, 12 Nov 2018 20:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542054788;
        bh=XDIwqxFW55NH1veF8CVxhs3aCFUErP8ll0WND7LOwrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GohbJXgDAxsDsRtVWkkpOupfrJ1BA6Y5fEbDk6S+A6SkvQdGjHG9sJYFUKAcsOpQs
         7rsjiUovX0jX/OUDm30Vjvtd4bubdi+NZZrThzrvrQG62i2yZzRGHD8jPLTwIyjJMZ
         LKKFxMNPIRkt00ecf2UaF/rnHJcuxJGuv91PpCmg=
Date:   Mon, 12 Nov 2018 12:33:08 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robert Deal <robert.edward.deal@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] help conform gasket page table to style
Message-ID: <20181112203308.GA6239@kroah.com>
References: <20181110034849.GA18111@rdeal-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110034849.GA18111@rdeal-VirtualBox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:48:49PM -0500, Robert Deal wrote:
> Formating arguments in gasket_page_table.c functions to conform to
> the kernel style.
> 
> This is my first patch and I apologise in advance if this email and or patch
> is not correct, or if i sent it to the wrong maintainers.

No need to put this paragraph in the middle of the changelog text :)

Also, use scripts/get_maintainer.pl, it will tell you who to send it to,
including what mailing list(s).

And finally, fix up your subject: line to look more like the same way
the other patches are for this file.

Can you fix that all up and resend it?

thanks,

greg k-h
