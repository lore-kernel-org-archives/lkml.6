Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACDCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB572086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB572086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeIZAzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:55:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeIZAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:55:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95D0B107B;
        Tue, 25 Sep 2018 18:46:26 +0000 (UTC)
Date:   Tue, 25 Sep 2018 20:46:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     sehro rautenkranz <sehro@sehro.org>
Cc:     Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: dgnc: Fix Kconfig help header and text
Message-ID: <20180925184623.GA16455@kroah.com>
References: <a62c2d41-5ae6-26a1-3c0e-01893a8ca8a0@infradead.org>
 <20180925162225.19227-1-sehro@sehro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925162225.19227-1-sehro@sehro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:22:24AM -0600, sehro rautenkranz wrote:
> Replace Kconfig help header and text to match other modules. Issue found
> my checkpatch.
> 
> Spacing adjusted to match Documentation/process/coding-style.rst. Issue
> reported by rdunlap@infradead.org. (try 2)

The "try 2" needs go to below the --- line.

Also, you need to properly version your patches so that I have a clue
as to which is the "latest" one.

> Signed-off-by: sehro rautenkranz <sehro@sehro.org>

You forgot Randy's Reported-by.

Also, properly Capitalize your name.

v3?

thanks,

greg k-h
