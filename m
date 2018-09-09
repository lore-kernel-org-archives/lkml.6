Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F99EC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57F42086E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 08:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57F42086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeIINcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 09:32:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeIINcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 09:32:45 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB98A92B;
        Sun,  9 Sep 2018 08:43:48 +0000 (UTC)
Date:   Sun, 9 Sep 2018 10:43:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/89] 4.14.69-stable review
Message-ID: <20180909084346.GB14455@kroah.com>
References: <20180907210852.341064285@linuxfoundation.org>
 <7cfd62d8-e287-aff0-3e9e-2b59d7db42c7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cfd62d8-e287-aff0-3e9e-2b59d7db42c7@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 02:16:02PM -0700, Guenter Roeck wrote:
> On 09/07/2018 02:08 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.69 release.
> > There are 89 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Sep  9 21:08:28 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 151 pass: 149 fail: 2
> Failed builds:
> 	powerpc:defconfig
> 	powerpc:allmodconfig
> Qemu test results:
> 	total: 311 pass: 293 fail: 18
> Failed tests:
> 	powerpc:mac99:ppc64_book3s_defconfig:nosmp:initrd
> 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:initrd
> 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:ide:rootfs
> 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:mmc:rootfs
> 	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:scsi[DC395]:rootfs
> 	powerpc:pseries:pseries_defconfig:initrd
> 	powerpc:pseries:pseries_defconfig:scsi:rootfs
> 	powerpc:pseries:pseries_defconfig:mmc:rootfs
> 	powerpc:pseries:pseries_defconfig:nvme:rootfs
> 	powerpc:pseries:pseries_defconfig:sata-sii3112:rootfs
> 	powerpc:pseries:pseries_defconfig:little:initrd
> 	powerpc:pseries:pseries_defconfig:little:scsi:rootfs
> 	powerpc:pseries:pseries_defconfig:little:sata-sii3112:rootfs
> 	powerpc:pseries:pseries_defconfig:little:scsi[MEGASAS]:rootfs
> 	powerpc:pseries:pseries_defconfig:little:scsi[FUSION]:rootfs
> 	powerpc:pseries:pseries_defconfig:little:mmc:rootfs
> 	powerpc:pseries:pseries_defconfig:little:nvme:rootfs
> 	powerpc:powernv:powernv_defconfig:initrd
> 
> Details are available at https://kerneltests.org/builders/.

Should now be fixed up, I've pushed out a -rc2 for this.

thanks,

greg k-h
