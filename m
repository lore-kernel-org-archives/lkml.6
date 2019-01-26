Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3EBC282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF2218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548490680;
	bh=1fUCDVTx5Gg3iHn5iEZhqJB1cUOIl6jKLziiCcCMobk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GnEnlnhIdGmVLAUpLsFjcUnSWa9qdMBJt9VgWlhBnmyambjbAZs3FSjIkTS4PzqpR
	 sS7/OEIPtiknEGHjwn4tR3uh+i/14AtxQopXICIbASnG5W2h4pHGlUgaBy9YPh3nxq
	 WOMnoW/kiM6eytmre3NuL5ZJnDNGQS7klGgMDfJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfAZIR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfAZIR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 03:17:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BBDD218B0;
        Sat, 26 Jan 2019 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548490678;
        bh=1fUCDVTx5Gg3iHn5iEZhqJB1cUOIl6jKLziiCcCMobk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEBOLmnPcM7/zzbFuAkS7fAMom42zFQuHfFFV96QA38G2mxO7DQjgH8SZv59SRob4
         JlDepaq/I9j3DOX7/+9IQEl7b2evXpJNLJAmELBcWMxywCPIiA9GFtfznWfQw/hQka
         H/Foy/Hqv3sIK4FOOWD/s40CfTRic4HVrZTXJ+iA=
Date:   Sat, 26 Jan 2019 09:17:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/127] 4.20.5-stable review
Message-ID: <20190126081755.GC31782@kroah.com>
References: <20190124190211.984305387@linuxfoundation.org>
 <20190125232047.GF27619@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125232047.GF27619@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 03:20:47PM -0800, Guenter Roeck wrote:
> On Thu, Jan 24, 2019 at 08:19:06PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.5 release.
> > There are 127 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Jan 26 19:01:19 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 343 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
