Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE67C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905B021748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905B021748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeI1LMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:12:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1LMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:12:46 -0400
Received: from localhost (unknown [89.248.140.14])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E77E6BC8;
        Fri, 28 Sep 2018 04:50:55 +0000 (UTC)
Date:   Fri, 28 Sep 2018 06:50:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/88] 4.18.11-stable review
Message-ID: <20180928045044.GD21073@kroah.com>
References: <20180927090300.631426620@linuxfoundation.org>
 <20180927215312.GA9198@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927215312.GA9198@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:53:12PM -0700, Guenter Roeck wrote:
> On Thu, Sep 27, 2018 at 11:02:41AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.11 release.
> > There are 88 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Sep 29 09:02:26 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 137 pass: 137 fail: 0
> Qemu test results:
> 	total: 321 pass: 319 fail: 2
> Failed tests: 
> 	arm:sabrelite:imx_v6_v7_defconfig:imx6dl-sabrelite 
> 	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> 
> arm_sabrelite crashes in drm code. Presumably this is the same problem as
> reported by others with v4.14.
> 
> powerpc:g3beige is the known problem. Patch should be available upstream
> in the near future.
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.

greg k-h
