Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeC0MJm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:09:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:58816 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbeC0MJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:09:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="27908889"
Date: Tue, 27 Mar 2018 17:43:54 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH] dmaengine: edma: Check the memory allocation for the
 memcpy dma device
Message-ID: <20180327121353.GK15443@localhost>
References: <20180321083022.32616-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321083022.32616-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 10:30:22AM +0200, Peter Ujfalusi wrote:
> If the allocation fails then disable the memcpy support.

Applied, thanks

-- 
~Vinod
