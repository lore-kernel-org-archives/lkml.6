Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE089C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9539A2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwMqbd4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9539A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeK3S0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeK3S0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:26:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C442082F;
        Fri, 30 Nov 2018 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543562274;
        bh=l4SH1OvHft8qxThiPZKJEJaIOODJAZJefWhwcGW7yyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwMqbd4boHfDNmkJKC8I2ajyTn2mQZxDJPUW8gppAfke2qBBo8nSrlyglJ+MYITPQ
         Te4vEXwLhFyIBbjkVLVlO6xP5ijPW4zOrRWo7WakCxc9MbF19q30n2GRQ/UFO4rpWh
         QyA9Oi1siUjP1Y1uQ5LR23GX/3G4fydVUtqhpw/A=
Date:   Fri, 30 Nov 2018 08:17:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/110] 4.19.6-stable review
Message-ID: <20181130071752.GB1044@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <AD3AEAAF-47C7-4EFA-81CC-6E5686143854@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AD3AEAAF-47C7-4EFA-81CC-6E5686143854@prjkt.io>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:54:48AM +0530, Harsh Shandilya wrote:
> On 29 November 2018 7:41:31 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.19.6 release.
> >There are 110 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sat Dec  1 13:58:54 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.6-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.19.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions.

Thanks for testing these and letting me know.

> P.S. My GCC loving friend Gabe said hi :p

People love gcc?  :)

greg k-h
