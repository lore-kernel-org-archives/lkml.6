Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeEBEcn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 00:32:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:64204 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbeEBEci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 00:32:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="196003683"
Date: Wed, 2 May 2018 10:07:23 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, lars@metafoo.de
Subject: Re: [PATCH v3] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
Message-ID: <20180502043722.GR6014@localhost>
References: <20180428195754.3053-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428195754.3053-1-mdf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 12:57:54PM -0700, Moritz Fischer wrote:
> Request IRQ with IRQF_SHARED flag to enable setups with multiple
> instances of the core sharing a single IRQ line.
> This works out since the IRQ handler already checks if there is
> an actual IRQ pending and returns IRQ_NONE otherwise.

Applied, thanks

-- 
~Vinod
