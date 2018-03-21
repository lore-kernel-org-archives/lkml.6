Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeCUPHU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:07:20 -0400
Received: from foss.arm.com ([217.140.101.70]:54634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbeCUPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:07:19 -0400
Date: Wed, 21 Mar 2018 15:07:14 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, shankerd@codeaurora.org
Subject: Re: [PATCH v4 11/22] arm64: capabilities: Group handling of features
 and errata workarounds
Message-ID: <20180321150712.GB16308@e103592.cambridge.arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-12-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313115120.17256-12-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:51:09AM +0000, Suzuki K Poulose wrote:
> Now that the features and errata workarounds have the same
> rules and flow, group the handling of the tables.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

It looks like nothing signifcant has changed since v3 [1], and I was
reasonably happy with this last time around [2], so

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

[...]

Cheers
---Dave

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/558742.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/558763.html
