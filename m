Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCF1C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EA721104
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT4oKYpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EA721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeKTST5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:19:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTST4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:19:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69DB206BA;
        Tue, 20 Nov 2018 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542700331;
        bh=/HmuO+VhgeyvPhsV6rxwTtr1aGnRbbG4BdtPMAsZAiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sT4oKYpBsE+5PWDbsz2HrdZqal+lIyBNcZaJ+BstkgNxoUA810KAKuiFTjrGAUUhH
         dIdhlc/wqSSJg7kb+HQs8Qkbd+C3COtNOmt0m9+urlM1eXp+c3Qni3UsOUZ8PvqqQo
         s/4ETUxksTDJvMYHD9J3BHrxQnuM3/cMfD38yuOY=
Date:   Tue, 20 Nov 2018 08:52:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/205] 4.19.3-stable review
Message-ID: <20181120075209.GG15276@kroah.com>
References: <20181119162616.586062722@linuxfoundation.org>
 <9998C846-1FD9-4825-8848-F8CC06FA0476@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9998C846-1FD9-4825-8848-F8CC06FA0476@prjkt.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:44:31PM +0530, Harsh Shandilya wrote:
> On 19 November 2018 9:55:07 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.19.3 release.
> >There are 205 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Wed Nov 21 16:24:55 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.3-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.19.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> >
> Compiled and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions.

Great!  thanks for testing and letting me know.

greg k-h
