Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D32ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1566420657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0yBx7bCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1566420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeKAUfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbeKAUfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:35:21 -0400
Received: from localhost (unknown [95.99.172.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B20F20657;
        Thu,  1 Nov 2018 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541071968;
        bh=6YOHArewp9AQOM5PQzQwjrJBgRv1pLKHZVFZBOcCknk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0yBx7bCpPhAqBi/7uwsS4WgbAiA8mmoKQdfL58uhRgHBIZA4IX2rDBMkSt5jdUV++
         Qeh5arzxozEvHdaQnp6nk31i7ZHpz8YFwB0HIDn6LmItYmwbh2IdPpEJWfWPuPBFzY
         PPr2Y+1ddO9/B2XJCvC2uy3rFcwRRePFl1yyzBio=
Date:   Thu, 1 Nov 2018 12:33:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Addition of the I3C subsystem in 4.20 (5.0)?
Message-ID: <20181101113330.GB11109@kroah.com>
References: <20181101063523.26bdbe28@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101063523.26bdbe28@bbrezillon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 06:35:23AM +0100, Boris Brezillon wrote:
> Hello Greg, Linus,
> 
> Greg, I didn't get your feedback on v10 of the i3c patchset [1] where I
> was asking if you'd agree to have this framework merged in 4.20 (I know
> you were busy with the 4.19 release and after that the Kernel Summit, so
> that's not a surprise), so I'm sending this PR. It's really not an attempt
> to bypass you, more like a ping that, if positively acknowledged, might
> lead to inclusion of the I3C framework in 4.20 (5.0?) :-).
> 
> Please let me know if you're opposed to the idea.
> 
> Regards,
> 
> Boris
> 
> [1]https://lkml.org/lkml/2018/10/26/552 

The last set of patches was sent way too late for this -rc cycle so I
was going to review them again once 4.20-rc1 was out.

Also you do not have an ack from the DT maintainers yet, which would be
required as well, right?

So I don't think this can be merged just yet, sorry.

greg k-h
