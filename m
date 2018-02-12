Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934093AbeBLL37 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:29:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39106 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934073AbeBLL3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:29:48 -0500
Date: Mon, 12 Feb 2018 11:29:43 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Shanker Donthineni <shankerd@codeaurora.org>,
        Thomas Speier <tspeier@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: Add missing Falkor part number for branch
 predictor hardening
Message-ID: <20180212112942.e5ojz3wtlt36uzax@armageddon.cambridge.arm.com>
References: <1518398175-28378-1-git-send-email-shankerd@codeaurora.org>
 <86po5ah9fj.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86po5ah9fj.wl-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 08:57:36AM +0000, Marc Zyngier wrote:
> On Mon, 12 Feb 2018 01:16:15 +0000,
> Shanker Donthineni wrote:
> > 
> > References to CPU part number MIDR_QCOM_FALKOR were dropped from the
> > mailing list patch due to mainline/arm64 branch dependency. So this
> > patch adds the missing part number.
> > 
> > Fixes: ec82b567a74f ("arm64: Implement branch predictor hardening for Falkor")
> > Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
[...]
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I'd suggest this goes via the arm64 tree as a matter of consistency
> with the rest of the variant-2 series.

Queued for -rc2. Thanks.

-- 
Catalin
