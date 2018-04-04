Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeDDGPl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:15:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:28801 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeDDGPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:15:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="34113061"
Date: Wed, 4 Apr 2018 11:49:59 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] Append several fixes and improvements in STM32 DMA
Message-ID: <20180404061958.GH15443@localhost>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 05:41:59PM +0100, Pierre-Yves MORDRET wrote:
> This patchset appends several fixes and some improvements for STM32 DMAv2.
> This includes:
>         * Introduce DMA features bitfield
>         * Threshold manages with bitfield feature
>         * Improve memory burst management
>         * Improve DMA IRQ status handling
>         * Fix max items per transfer to match FIFO Size
>         * Properly mask irq bits to avoid overlaping
>         * Fix incomplete configuration in cyclic mode
>         * Fix typo and reported checkpatch warnings

Applied, thanks

-- 
~Vinod
