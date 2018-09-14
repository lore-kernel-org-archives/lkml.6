Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AB3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F7320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F7320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeINXlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:41:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeINXlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:41:10 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E68AC0A;
        Fri, 14 Sep 2018 18:25:28 +0000 (UTC)
Date:   Fri, 14 Sep 2018 20:25:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/197] 4.18.8-stable review
Message-ID: <20180914182526.GB20957@kroah.com>
References: <20180913131841.568116777@linuxfoundation.org>
 <20180914144848.GA19364@roeck-us.net>
 <20180914145054.GA19514@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914145054.GA19514@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 07:50:54AM -0700, Guenter Roeck wrote:
> On Fri, Sep 14, 2018 at 07:48:48AM -0700, Guenter Roeck wrote:
> > On Thu, Sep 13, 2018 at 03:29:09PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.18.8 release.
> > > There are 197 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Sep 15 13:17:57 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 139 pass: 139 fail: 0
> > Qemu test results:
> > 	total: 221 pass: 221 fail: 0

I was wondering what caused the numbers to drop :)

> No wait that was 3.18. Here are the results for 4.18:
> 
> Build results:
> 	total: 137 pass: 137 fail: 0
> Qemu test results:
> 	total: 318 pass: 318 fail: 0
> 
> Sorry for the confusion.

No problem at all.  Thanks for testing all of these and letting me know.

greg k-h
