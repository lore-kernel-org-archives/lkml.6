Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B25C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD3A20854
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550909100;
	bh=+coHBEf0TKHsHrehC+mM0ORzdrsGj1NSV5YFDUXj3Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mvRg95tppi0dNeTnqk9n5X/scPioV1JFiaiMTU4DyYQfFCIpjUEvw9AXttS9gtnfP
	 F9KtrA6Tkw5Nt8oeizoeAhRTGPJBThOsF366iq6xPFMznUv4K8PGB89mT2tvIrhb9O
	 3bgdu356KplQS5HvWJjCzfD+ZzLf2TPz/4is75HM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfBWIE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:04:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfBWIE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:04:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2A420684;
        Sat, 23 Feb 2019 08:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550909097;
        bh=+coHBEf0TKHsHrehC+mM0ORzdrsGj1NSV5YFDUXj3Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCGI43FBNctxyYcC2Cw9ORUIlT4HVmUkYl0E69VGxlyV9NYxSMnMPt95cs72t0LUN
         CZuzQ5cC/PZKxJXMKSm/a3dZmI0zWGcZls0HfZTTLjZKQPIZhiIMqyOC5HNsDJpKf+
         uo0fRP+6sfASod1alpdey2/fMpkpTzLQZfewfkZY=
Date:   Sat, 23 Feb 2019 09:04:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/32] 4.20.12-stable review
Message-ID: <20190223080454.GD2640@kroah.com>
References: <20190221125250.855065214@linuxfoundation.org>
 <20190222233219.GF25975@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222233219.GF25975@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:32:19PM -0800, Guenter Roeck wrote:
> On Thu, Feb 21, 2019 at 03:35:48PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.12 release.
> > There are 32 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb 23 12:52:26 UTC 2019.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 343 fail: 0

thanks for testing all of these and letting me know.

greg k-h
