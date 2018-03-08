Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755881AbeCHN4B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:56:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38428 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeCHN4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:56:00 -0500
Date: Thu, 8 Mar 2018 13:55:55 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 21/22] arm64: Delay enabling hardware DBM feature
Message-ID: <20180308135555.yg6wdrarlpmedmmb@lakrids.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-43-suzuki.poulose@arm.com>
 <20180209185840.GJ5862@e103592.cambridge.arm.com>
 <e8b40320-10d2-6117-ef7f-7bbb46823ffb@arm.com>
 <20180308135312.GQ32331@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308135312.GQ32331@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 01:53:13PM +0000, Dave Martin wrote:
> In practice, we don't race booting of two CPUs against each other
> IIUC.

Yup. Today, hotplugs are strictly serialized.

Several things would have to change for parallel hotplug to be feasible.

Thanks,
Mark.
