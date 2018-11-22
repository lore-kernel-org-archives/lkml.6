Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A8AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0220865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="apc879QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA0220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392937AbeKVTCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKVTCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:02:47 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A08520864;
        Thu, 22 Nov 2018 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542875064;
        bh=vc0AjpKAJ1Cq65NZCC72ylRstYJZyzbvOOQR6L2u7/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apc879QOlQAAUd/Dj3BZmg1fLkCQ1WxZ/t1PC/bhcsi0DDB6Ao2Ew/eiSyIfa5QSj
         Vu02NqlWjc/7JprTv4Sp+EYfuZecJfvYJdsXX7DdiXDglbuEaxfy+WWaNbMFzf5Rju
         osRuzBYCi4bJU8YrbPLMORYs7BrLl21b1rbaTX7Q=
Date:   Thu, 22 Nov 2018 09:24:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
Message-ID: <20181122082418.GA20605@kroah.com>
References: <20181121183147.869199006@linuxfoundation.org>
 <5F36AF54-5ADE-47D8-B0F8-01CD0DBAEDDD@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F36AF54-5ADE-47D8-B0F8-01CD0DBAEDDD@prjkt.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:45:42PM +0530, Harsh Shandilya wrote:
> On 22 November 2018 12:35:36 AM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.19.4 release.
> >There are 42 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Fri Nov 23 18:31:31 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.4-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.19.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions.

Wonderful, thanks for testing and letting me know.

greg k-h
