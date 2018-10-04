Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8045C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981942084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981942084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeJDWiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:38:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeJDWiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:38:20 -0400
Received: from localhost (unknown [104.132.1.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 146DB412;
        Thu,  4 Oct 2018 15:44:30 +0000 (UTC)
Date:   Thu, 4 Oct 2018 08:44:29 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/137] 4.14.74-stable review
Message-ID: <20181004154429.GD6921@kroah.com>
References: <20181002132458.446916963@linuxfoundation.org>
 <424795e5-7ef6-63ff-7908-babf1b34ff58@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424795e5-7ef6-63ff-7908-babf1b34ff58@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:42:48PM +0100, Jon Hunter wrote:
> 
> On 02/10/18 14:23, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.74 release.
> > There are 137 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Oct  4 13:24:18 UTC 2018.
> > Anything received after that time might be too late.
> 
> All tests are passing for Tegra ...
> 
> Test results for stable-v4.14:
>     8 builds:	8 pass, 0 fail
>     8 boots:	8 pass, 0 fail
>     14 tests:	14 pass, 0 fail
> 
> Linux version: 4.14.74-rc1-g3fa7781
> Boards tested: tegra124-jetson-tk1, tegra20-ventana,
>                tegra210-p2371-2180, tegra30-cardhu-a04
> 

Wonderful, thanks for testing and letting me know.

greg k-h
