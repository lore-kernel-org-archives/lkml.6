Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C395EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0C421104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbZbc2Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0C421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeK1Bhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbeK1Bhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:37:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A0B20817;
        Tue, 27 Nov 2018 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543329577;
        bh=6eY6WYfK+/LgDhMwQjuPNTnnqXPCOCIVhAfvTsYHzIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbZbc2MjXd+tYxZAESLD2ubQ8AUpmePEwxxVTIOHPIU8iVR5FWjQuRhTe+5RAC28J
         I/JahCkvPdMYup+vLTdcDLh6umcnef5lEnhVAsmN9o4AHJvswLPCaMiavv92a9UrHI
         PTcJu4zNYlsJXhqPdyWLPBS+DsbYc4Bk61msY3iA=
Date:   Tue, 27 Nov 2018 15:39:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/70] 4.4.165-stable review
Message-ID: <20181127143935.GC10618@kroah.com>
References: <20181126105046.722096341@linuxfoundation.org>
 <9E1ED636-20E6-4FE9-8C96-915CA0599E9B@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9E1ED636-20E6-4FE9-8C96-915CA0599E9B@prjkt.io>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 03:26:32PM +0530, Harsh Shandilya wrote:
> On 26 November 2018 4:20:15 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.4.165 release.
> >There are 70 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Wed Nov 28 10:50:16 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.165-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.4.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> A rather painful merge into the Pixel 2 tree but I'm glad to report I
> have noticed no regressions over the past couple hours of testing.  -- 

What was tough about the merge?

Anyway, thanks for testing and letting me know.

greg k-h
