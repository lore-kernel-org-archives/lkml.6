Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeC0L5g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:57:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:4490 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbeC0L5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:57:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="28800979"
Date: Tue, 27 Mar 2018 17:31:46 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: sean.wang@mediatek.com
Cc: dan.j.williams@intel.com, robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] add support for Mediatek High-Speed DMA
 controller on MT7622 and MT7623 SoC
Message-ID: <20180327120146.GI15443@localhost>
References: <cover.1521098171.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1521098171.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 03:40:34PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> 
> This patchset introduces support for MediaTek High-Speed DMA controller
> (MTK-HSDMA) Currently, the driver is already tested successfully with
> dmatest module on MT7622 and MT7623 SoC. 
> 
> MTK-HSDMA on MT7622/23 SoC has a single ring which is dedicated for
> doing memory-to-memory transfer through ring-based descriptor management.
> Even though there is only a single ring available inside HSDMA, the
> driver is being extended to the support for multiple virtual channels
> processing simultaneously by means of DMA_VIRTUAL_CHANNELS.

Applied all, thanks

-- 
~Vinod
