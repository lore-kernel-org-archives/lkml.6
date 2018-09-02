Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAFBC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 15:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AA620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 15:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AA620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeIBTSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 15:18:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeIBTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 15:18:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 096B7CA8;
        Sun,  2 Sep 2018 15:02:11 +0000 (UTC)
Date:   Sun, 2 Sep 2018 17:02:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nitin Gupta <nitin.gupta981@gmail.com>
Cc:     ldv-project@linuxtesting.org, devel@driverdev.osuosl.org,
        Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: SKylake Edac support in linux 2.6.32.696 kernel build
Message-ID: <20180902150209.GA25883@kroah.com>
References: <CAB3_1NuNyrBYx2M1iKOYb+rTRXW+p1gB-1VTaBymVBvRHvDSMA@mail.gmail.com>
 <20180831161450.GB26043@kroah.com>
 <CAB3_1Ns_Zg0FLn4Yo2kOMtZVQvh-mNeGUqGOe2Hi5HEXJqXQBw@mail.gmail.com>
 <20180831194727.GA8631@kroah.com>
 <CAB3_1Nv2P7uh6ypy4RXQXejeJ9PpF2KWdFK3V5OPHq_+4rANAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3_1Nv2P7uh6ypy4RXQXejeJ9PpF2KWdFK3V5OPHq_+4rANAw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 03:45:01PM +0530, Nitin Gupta wrote:
> Hi Greg
> 
> i am working on some project which is having huge changes and working
> on kernel-2.6.32-131.696
>  it will be very difficult to back port them into 4.8 .

Why 4.8?  That too is a totally unsupported kernel version.

Anyway, randomly pulling in a driver from a newer by many years, if not
almost a decade old (2.6.32 was released in 2009), is a very difficult
task, and usually almost impossible to go that far back.  That is not
how Linux is developed or meant to be worked with at all.

You are _really_ on your own here, only do this if you _really_ know
what you are doing.  Even then, I would not recommend you do this, as
you are guaranteeing to create a monstrosity that only you can support,
for forever, on your own.

good luck!

greg k-h
