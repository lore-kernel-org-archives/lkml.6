Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A53C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E1A215F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E1A215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeHOQGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:06:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbeHOQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:06:21 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BB95C3A;
        Wed, 15 Aug 2018 13:14:13 +0000 (UTC)
Date:   Wed, 15 Aug 2018 15:14:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180815131410.GA30892@kroah.com>
References: <20180814171520.883143803@linuxfoundation.org>
 <20180815061445.GC1253@kroah.com>
 <a8508ac4-b01d-e804-09f2-2e9311e7aecc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8508ac4-b01d-e804-09f2-2e9311e7aecc@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 05:20:28AM -0700, Guenter Roeck wrote:
> On 08/14/2018 11:14 PM, Greg Kroah-Hartman wrote:
> > On Tue, Aug 14, 2018 at 07:16:23PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.9.120 release.
> > > There are 107 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu Aug 16 17:14:53 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.120-rc1.gz
> > 
> > -rc2 is now out:
> >   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.120-rc2.gz
> > 
> 
> Heads up: We'll need (at least) one more fix for v4.{9,14,17}. I'll send out backports
> after testing.

Thanks for the fixes, I've queued them up and pushed out a -rc3 for
these 3 trees.

thanks,

greg k-h
