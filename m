Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D74C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126D421564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126D421564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeHXQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:34:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeHXQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:34:28 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00CEFBAE;
        Fri, 24 Aug 2018 12:59:53 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:59:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Matthias B." <matthias@winterdrache.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to report kernel panic in 4.4.x
Message-ID: <20180824125950.GA29673@kroah.com>
References: <20180824142408.6340d052@ninja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824142408.6340d052@ninja>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:24:08PM +0200, Matthias B. wrote:
> Hallo,
> 
> 4.4.147 is the last kernel of the 4.4.x series that boots for me. All
> subsequent versions panic on boot. How do I report this bug? 
> If I'm supposed to use https://bugzilla.kernel.org/ I don't know what
> to fill into the fields. I don't even know if the longterm kernel falls
> under "Mainline" or some other tree.

It depends on what the panic looks like :)

Any hints?  You can post it here if you want.

Also, if you can run 'git bisect' to track it down to the commit that
causes the problem, that is even better, as we can cc: all of the people
on that patch to get help from.

thanks,

greg k-h
