Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C37C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373E3222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550002689;
	bh=PhwvjkPM06ndIg54lIz/ayuDWJjQCcp4tu4DvxBK0w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PdA6cUQiixi6NsJVB8H8rm/5xt4v48i20wbwoeeRc4/4e36KxbzLlzOVPlqny0Tbu
	 9PoYulLIgUPx0ia7iVZuQk8UGG+yP12gWEKjkPm2ySXiE4zFEcazEOgBs4yF5Ny9vO
	 uJksKRaNtndo/zRe7ttGngBU0GN67LmGHd1iG7OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfBLUSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:18:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfBLUSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:18:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B341222C4;
        Tue, 12 Feb 2019 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550002686;
        bh=PhwvjkPM06ndIg54lIz/ayuDWJjQCcp4tu4DvxBK0w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5yIC3nVkpOqJrjmeEU97oOOsqRkEzqcSlY/G6pDLffUU5QeIZP3RN0Y3efIw/HOV
         wtdvmNsoy14ONCmREsChR7h8pOTvkPkULZAV1m6M5m2UmYYZO5KQyAuT/eGzgaYfFH
         krlcCF+avcX1siOc9hdejKzfbdENqKXkbaHFHKhw=
Date:   Tue, 12 Feb 2019 21:18:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.20.8
Message-ID: <20190212201804.GA11553@kroah.com>
References: <20190212201309.GA10672@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212201309.GA10672@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:13:09PM +0100, Greg KH wrote:
> I'm announcing the release of the 4.20.8 kernel.
> 
> All users of the 4.20 kernel series must upgrade.
> 
> The updated 4.20.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.20.y
> and can be browsed at the normal kernel.org git web browser:
> 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------
> 
>  arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts         |    2 
>  arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts               |    2 
>  arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts                 |    3 
>  arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts            |    2 

<snip>

Crap, my tag got messed up, so I've pushed it out again, and let me do
this release announcement again...

greg k-h
