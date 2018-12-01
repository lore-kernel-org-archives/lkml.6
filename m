Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10091C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA60D20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzSZBFCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA60D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeLATfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeLATfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 14:35:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7E120834;
        Sat,  1 Dec 2018 08:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543652630;
        bh=HFy5HCChk41Zn8otDB5MRjepfm8gucupO5C7nFycH1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzSZBFCPx/VNORcQM7KPlhURi1lQ0PNwgOoqCjFAfwlpzUIJ/6Np5pfLv+2xyWigR
         f6bDJ3jHfFz81YmPXFCOFGTHH6ZmhqOAIist3V+5IfUFyK3c/X74K2EHeRSF/sFEUA
         My1oPxnNu53hqykGB3vOpDOuAj4j/NPtJI/CXiCI=
Date:   Sat, 1 Dec 2018 09:23:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/110] 4.19.6-stable review
Message-ID: <20181201082348.GA23804@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181130222945.GE13361@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130222945.GE13361@roeck-us.net>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:29:45PM -0800, Guenter Roeck wrote:
> On Thu, Nov 29, 2018 at 03:11:31PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.6 release.
> > There are 110 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Dec  1 13:58:54 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.19.5-107-g048192f:
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 337 pass: 337 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.

greg k-h
