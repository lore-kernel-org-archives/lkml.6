Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D99C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8E2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB8E2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHXAXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:23:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeHXAXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:23:30 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9D69792B;
        Thu, 23 Aug 2018 20:52:04 +0000 (UTC)
Date:   Thu, 23 Aug 2018 22:52:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/79] 4.4.152-stable review
Message-ID: <20180823205201.GB19509@kroah.com>
References: <20180823074918.641878835@linuxfoundation.org>
 <20180823163021.GA8669@roeck-us.net>
 <20180823165621.GA24633@kroah.com>
 <20180823172124.GB8669@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180823172124.GB8669@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:21:24AM -0700, Guenter Roeck wrote:
> On Thu, Aug 23, 2018 at 06:56:21PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 23, 2018 at 09:30:21AM -0700, Guenter Roeck wrote:
> > > On Thu, Aug 23, 2018 at 09:52:36AM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.4.152 release.
> > > > There are 79 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sat Aug 25 07:48:51 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Early feedback:
> > > 
> > > Building i386:tools/perf ... failed
> > > Building x86_64:tools/perf ... failed
> > > --------------
> > > Error log:
> > >   PERF_VERSION = 4.4.151.g6d0c34
> > > tests/parse-events.c: In function ‘test_event’:
> > > tests/parse-events.c:1629:3: error: implicit declaration of function ‘parse_events_print_error’
> > 
> > oops, forgot to drop that broken perf patch from 4.4 as well, now done,
> > sorry about that.
> > 
> 
> NP. Note that 3.18.y still has the cavium build error.

Ugh, forgot about that, will go drop that now...

thanks,

greg k-h
