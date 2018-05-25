Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965729AbeEYKE4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:04:56 -0400
Received: from foss.arm.com ([217.140.101.70]:58324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965291AbeEYKEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:04:55 -0400
Subject: Re: [PATCH v4 02/26] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
To: Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-3-git-send-email-julien.thierry@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <e44df12f-9868-ae94-4623-ec221d72d783@arm.com>
Date: Fri, 25 May 2018 11:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527241772-48007-3-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/18 10:49, Julien Thierry wrote:
> Add a cpufeature indicating whether a cpu supports masking interrupts
> by priority.

How is this different from the SYSREG_GIC_CPUIF cap ? Is it just
the description ?

Suzuki
