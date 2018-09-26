Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12683C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC856208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC856208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeIZMoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:44:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51846 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeIZMoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:44:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11EB61032;
        Wed, 26 Sep 2018 06:33:22 +0000 (UTC)
Date:   Wed, 26 Sep 2018 08:33:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/235] 4.18.10-stable review
Message-ID: <20180926063320.GB6587@kroah.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180925204818.GD13170@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925204818.GD13170@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:48:18PM -0700, Guenter Roeck wrote:
> On Mon, Sep 24, 2018 at 01:49:46PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.10 release.
> > There are 235 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Sep 26 11:30:01 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 137 pass: 137 fail: 0
> Qemu test results:
> 	total: 318 pass: 317 fail: 1
> Failed tests: 
> 	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> 
> The failed test is the result of a crash in devicetree unittest code. 
> It affects all branches. Nothing to worry about; fix is being worked on.

Thanks for testing all of these and letting me know.

greg k-h
