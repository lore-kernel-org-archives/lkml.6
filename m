Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FD7C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB33222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437668AbfBNIvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:51:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39008 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436834AbfBNIvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:51:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E7E7EBD;
        Thu, 14 Feb 2019 00:51:01 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7D303F575;
        Thu, 14 Feb 2019 00:50:57 -0800 (PST)
Subject: Re: [PATCH 4.19 00/17] V4.19 backport of more 32-bit arm spectre
 patches
To:     David Long <dave.long@linaro.org>, stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190213213223.916-1-dave.long@linaro.org>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <adb6d688-8f30-af8f-bbac-f3e166c84236@arm.com>
Date:   Thu, 14 Feb 2019 08:50:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 13/02/2019 21:32, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> V4.19 backport of spectre patches from Russell M. King's spectre branch.
> Patches have been kvm-unit-test'ed on an arndale, run through kernelci, and
> handed off to ARM for functional testing.
> 

I've reviewed the backports.

For Spectre-v1.1 I also checked we do get the expected code sequence in
the generated image at the expected locations. So, for patches 1 to 10:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

For Spectre-v2 big.Little patches, I managed to test this on TC2 and can
confirm CPUs pick up the correct mitigation method. So, for patches 11
to 17:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: Julien Thierry <julien.thierry@arm.com>

Thanks,

-- 
Julien Thierry
