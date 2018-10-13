Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D290C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3AA20652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xUKSnVK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3AA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJMOSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeJMOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:18:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC4F205C9;
        Sat, 13 Oct 2018 06:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539412940;
        bh=LoPwKaIg52nenh3ahtO2eUtrrp/11ljrmu5lD0iQszE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUKSnVK+I/xtGwuEEO86Qxmgx2aswaXGFtsRUjWgV4/8DIbtj/ZaGuM8C1s8msn7Y
         NUPcQobw87t9Pji8la1Rnq7Y6KNcUVbwXq9W9CGnHvHxk5B05W4JinDwAuz+htLZ9s
         x7XlTOhti5Bmm+nhMpYWB0NPT8mipmmBBvIrK24s=
Date:   Sat, 13 Oct 2018 08:42:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
Message-ID: <20181013064217.GB28177@kroah.com>
References: <20181011152549.500488630@linuxfoundation.org>
 <20181012202452.GA30665@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012202452.GA30665@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 01:24:52PM -0700, Guenter Roeck wrote:
> On Thu, Oct 11, 2018 at 05:33:01PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.124 release.
> > There are 120 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v3.18.123-122-gfaa00f6cbce8:
> 
> Build results:
> 	total: 138 pass: 138 fail: 0
> Qemu test results:
> 	total: 221 pass: 221 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Great, thanks for testing all of these and letting me know the issues.

greg k-h
