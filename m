Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeDYK0F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:26:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:42457 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751212AbeDYK0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:26:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,325,1520924400";
   d="scan'208";a="219243358"
Date: Wed, 25 Apr 2018 13:25:59 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Program REMAP register in PIO mode
Message-ID: <20180425102559.GO2173@lahna.fi.intel.com>
References: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 06:00:10PM +0300, Andy Shevchenko wrote:
> According to documentation REMAP register has to be programmed in
> either DMA or PIO mode of the slice.
> 
> Move the DMA capability check below to let REMAP register be programmed
> in PIO mode.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
