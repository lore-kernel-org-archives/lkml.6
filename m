Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4495AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B20C21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545376191;
	bh=cHNZ4RGtvSeXdevCoJNQ7qxp1shoC3ws59s6BSguQl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TRgWYweGAAwv3kpfwRuBjFg52yNSr/ibd8kFfzGp5y87Ry/zge+V5Frfbo2hRAJ01
	 zYWSoN4OvEpGh2htYn7JgGi574TBsvOqeGiTYhpGr514mYtmVGAV8FbTcMmuIoPGu7
	 jyIjVGyVUf9Vkui14eKvaWeMb1JXmc2XOFsmv+6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbeLUHJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbeLUHJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:09:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B62218F0;
        Fri, 21 Dec 2018 07:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545376189;
        bh=cHNZ4RGtvSeXdevCoJNQ7qxp1shoC3ws59s6BSguQl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Em1OAldBbO68cBD0SsWwWCpbfcgt7rQOYuP4gJg4Mvy+i24rdrYF6GZBSpouOkXoZ
         dcvCnatmV1eRKY+kwT2w36U04Pf/uGFq2xO2RnpE9/2/P+BOOkS+NHFXjhzhguXy1X
         Yt2BRsROzsT/6LMNcwTBW1yZV2yiznDeMG1D5OHY=
Date:   Fri, 21 Dec 2018 08:09:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/67] 4.19.12-stable review
Message-ID: <20181221070946.GA19343@kroah.com>
References: <20181220085903.562090333@linuxfoundation.org>
 <b6ef5d5b-a8b1-fd82-cb8a-63604f7e8952@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ef5d5b-a8b1-fd82-cb8a-63604f7e8952@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 03:48:09PM -0700, shuah wrote:
> On 12/20/18 2:18 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.12 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Dec 22 08:58:49 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.12-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
