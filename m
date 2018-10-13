Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686D4C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2855620652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C83VqUQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2855620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJMOSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbeJMOSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:18:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBAA205C9;
        Sat, 13 Oct 2018 06:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539412966;
        bh=qyAfV5b6mOXmlBV5Ax8P9b6fSIxJ0RMbLFfGnWcdYbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C83VqUQEeqSbZpzCGcI+UzfrFYuElGG2FlhLaPn+NJzqquJrFD4Uc182RFDUnNW/x
         XCd3c6xH9TwN1q6mtuiWg25jySFg8YABYl57PKvX4X6XbYwnTzbKVT6h9WR4Ms1A0K
         NJrHmnPuHDtFCMwwUEV+WF1FpjDNgFX2imxF+d98=
Date:   Sat, 13 Oct 2018 08:42:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
Message-ID: <20181013064243.GC28177@kroah.com>
References: <20181011152549.500488630@linuxfoundation.org>
 <20181012170709.GA28298@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012170709.GA28298@flashbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:07:09AM -0700, Nathan Chancellor wrote:
> On Thu, Oct 11, 2018 at 05:33:01PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.124 release.
> > There are 120 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.124-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled with -Werror, and installed onto my Pixel XL.
> 
> No initial issues noticed in dmesg or general usage.

Thanks for testing 3 of these and letting me know.

greg k-h
