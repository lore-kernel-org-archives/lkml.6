Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeCSIFB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:05:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:28580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeCSIE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:04:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="scan'208";a="25658075"
Date: Mon, 19 Mar 2018 13:39:00 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: dmaengine@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 0/2] Introduce DW AXI DMAC driver
Message-ID: <20180319080900.GN15443@localhost>
References: <20180306114615.8895-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306114615.8895-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 02:46:13PM +0300, Eugeniy Paltsev wrote:
> This patch series add support for the DW AXI DMAC controller.
> 
> DW AXI DMAC is a part of HSDK development board from Synopsys.
> 
> In this driver implementation only DMA_MEMCPY transfers
> are supported.

Applied, thanks

-- 
~Vinod
