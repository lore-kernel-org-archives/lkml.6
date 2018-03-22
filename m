Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeCVMTV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:19:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36794 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeCVMTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:19:18 -0400
Subject: Re: [RFC PATCH] irqchip: arm-gic: take gic_lock when updating irq
 type
To: Aniruddha Banerjee <aniruddhab@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <treding@nvidia.com>, Vipin Kumar <vipink@nvidia.com>
References: <c20f41d47ed9444b9050bc1f609d4bbe@bgmail101.nvidia.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <77ac9d88-e99e-c507-66b2-cc14f06ce192@arm.com>
Date: Thu, 22 Mar 2018 12:19:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c20f41d47ed9444b9050bc1f609d4bbe@bgmail101.nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/18 10:28, Aniruddha Banerjee wrote:

[a PGP-encrypted email]

Given that you're cc-ing various mailing lists, please resend this email
unencrypted.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
