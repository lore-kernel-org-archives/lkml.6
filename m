Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeCZO0V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:26:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41676 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeCZO0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:26:20 -0400
Subject: Re: [RFC PATCH] irqchip: arm-gic: take gic_lock when updating irq
 type
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Aniruddha Banerjee <aniruddhab@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Thierry Reding <treding@nvidia.com>, Vipin Kumar <vipink@nvidia.com>
References: <c20f41d47ed9444b9050bc1f609d4bbe@bgmail101.nvidia.com>
 <77ac9d88-e99e-c507-66b2-cc14f06ce192@arm.com>
 <20180326131907.3m3sfwxvyzuli2ps@holly.lan>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <9acdc1bc-5a8b-4996-4986-9c3fddb2f8b7@arm.com>
Date: Mon, 26 Mar 2018 15:26:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326131907.3m3sfwxvyzuli2ps@holly.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/18 14:19, Daniel Thompson wrote:
> On Thu, Mar 22, 2018 at 12:19:15PM +0000, Marc Zyngier wrote:
>> On 22/03/18 10:28, Aniruddha Banerjee wrote:
>> [a PGP-encrypted email]
>>
>> Given that you're cc-ing various mailing lists, please resend this email
>> unencrypted.
> 
> I am very puzzled about what is going on here. I could read the 
> original mail fine and I was not in To: or Cc:. It also seems to
> have made it through to the archives OK.
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1645375.html
> https://www.spinics.net/lists/linux-tegra/msg32829.html

It looks like any email I getting from nvidia is encrypted. The message
on the list is in clear text, but not the one I received, hence my
(admittedly premature) rant.

	M.
-- 
Jazz is not dead. It just smells funny...
