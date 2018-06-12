Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34B68C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5F92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/hjXRIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5F92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934295AbeFLRqO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933244AbeFLRqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:46:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAB120660;
        Tue, 12 Jun 2018 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528825572;
        bh=s6LXHoj6cAlfFq86OfTu8XcTuIOimqe5ICgTU3lPkXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/hjXRIZgmbf62obRPobUjCSSkWIyL7kYpuvX9Jp6JLYFs858JVGxIyzrKvHXJ4Q4
         fuFStUNr2gFr1fPvvIMrjWxW0psRLhFUsSNfxsRSfTOoC2wS8zX431c32XNggpyigR
         LmQ/wVwGMvueqihzlcUNvq0mqPosh/zQldGy+0wc=
Date:   Tue, 12 Jun 2018 19:45:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/31] 4.9.108-stable review
Message-ID: <20180612174550.GA12806@kroah.com>
References: <20180612164620.797338191@linuxfoundation.org>
 <20180612171035.GA31286@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612171035.GA31286@localhost>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:10:35AM -0700, Nathan Chancellor wrote:
> On Tue, Jun 12, 2018 at 06:46:03PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.108 release.
> > There are 31 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jun 14 16:46:09 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.108-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled with -Werror, and installed on to my OnePlus 6.
> 
> No initial issues noticed in dmesg or general usage.

Great, thanks for the quick testing and letting me know.

greg k-h
