Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859E1213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUjdnpXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859E1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeJLNpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeJLNpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:45:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BA22086A;
        Fri, 12 Oct 2018 06:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539324870;
        bh=FVmqnH32jHiAzcypvZdqmHEvb6xTWW4XO8T6BjeGdXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUjdnpXe8kNFapqYEr2hXzNZ8ksv4BlZTzZzUw3AfwE6P+tlIXarCIImBQHqAYQ7m
         MAW0OS3eaLFg/5GrYDA9tPC+sYqGprYspGfqvbjkEdjM5aRwko/vKtBhNdoheg5pFy
         ZWisALoa3I2j0bvjGMk19CMfrNmv3n0yOkJkdVKU=
Date:   Fri, 12 Oct 2018 08:14:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/27] 4.4.161-stable review
Message-ID: <20181012061427.GA19105@kroah.com>
References: <20181011152534.014964888@linuxfoundation.org>
 <5bbfcd13.1c69fb81.477c6.d7d9@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bbfcd13.1c69fb81.477c6.d7d9@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 03:22:11PM -0700, kernelci.org bot wrote:
> 
> 
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.4.y/kernel/v4.4.160-28-gb3522afcec59/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.160-28-gb3522afcec59/
> 
> Tree: stable-rc
> Branch: linux-4.4.y
> Git Describe: v4.4.160-28-gb3522afcec59
> Git Commit: b3522afcec59a6a8030ebf4397f5b285b3e804d2
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 39 unique boards, 20 SoC families, 13 builds out of 178
> 
> Boot Regressions Detected:
> 
> x86:
> 
>     x86_64_defconfig:
>         qemu:
>             lab-baylibre: new failure (last pass: v4.4.160)

Should I worry about this?

thanks,

greg k-h
