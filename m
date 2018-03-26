Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCZLxh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:53:37 -0400
Received: from foss.arm.com ([217.140.101.70]:39950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbeCZLxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:53:36 -0400
Date: Mon, 26 Mar 2018 12:53:46 +0100
From: Will Deacon <will.deacon@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dave.martin@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        shankerd@codeaurora.org
Subject: Re: [PATCH v4 00/22] arm64: Rework cpu capabilities handling
Message-ID: <20180326115345.GA8464@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313115120.17256-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tue, Mar 13, 2018 at 11:50:58AM +0000, Suzuki K Poulose wrote:
> This series reworks the arm64 CPU capabilities handling (which
> manages the system features and errata). The current infrastructure
> doesn't allow fine control for handling different features or errata.
> There is one rule for features and another rule for errata.

Please can you repost this based on top of for-next/core and with Dave's
acks added?

Thanks,

Will
