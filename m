Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E5AC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297E52080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406029AbfBNSCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:02:34 -0500
Received: from foss.arm.com ([217.140.101.70]:48758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbfBNSCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:02:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17E37EBD;
        Thu, 14 Feb 2019 10:02:34 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D93353F589;
        Thu, 14 Feb 2019 10:02:29 -0800 (PST)
Subject: Re: [PATCH 4.9 00/16] V4.9 backport of more 32-bit arm spectre
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
References: <20190214144930.27539-1-dave.long@linaro.org>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <0a70f40e-ae04-a203-8153-4d362a16d62c@arm.com>
Date:   Thu, 14 Feb 2019 18:02:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 14/02/2019 14:49, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> V4.9 backport of spectre patches from Russell M. King's spectre branch.
> Patches have been kvm-unit-test'ed on an arndale, run through kernelci, and
> handed off to ARM for functional testing.
> 

As for 4.14 and 4.19, I reviewed those patches and checked to code
generation for Spectre-v1.1. So for all the patches:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

However, 4.9 stable does not boot on TC2 (the arm32 big.Little platform
I have at hand), even without this backport (so at least it isn't these
patches breaking things). So I've been unable to test the Spectre-v2
big.Little patches.

Thanks,

-- 
Julien Thierry
