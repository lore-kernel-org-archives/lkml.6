Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeDYJLw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:11:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:37178 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbeDYJLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:11:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,325,1520924400";
   d="scan'208";a="50652899"
Date: Wed, 25 Apr 2018 14:46:27 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: pl330: flush before wait, and add dev
 burst support.
Message-ID: <20180425091627.GM6014@localhost>
References: <1643219.q45jaR7ETT@bear>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643219.q45jaR7ETT@bear>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 08:31:06PM -0400, Frank Mori Hess wrote:
> Do DMAFLUSHP _before_ the first DMAWFP to ensure controller
> and peripheral are in agreement about dma request state before first
> transfer.  Add support for burst transfers to/from peripherals. In the new
> scheme, the controller does as many burst transfers as it can then
> transfers the remaining dregs with either single transfers for
> peripherals, or with a reduced size burst for memory-to-memory transfers.

Applied, thanks

-- 
~Vinod
