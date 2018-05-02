Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeEBEY1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 00:24:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:49121 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbeEBEYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 00:24:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="50757633"
Date: Wed, 2 May 2018 09:59:10 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Colin King <colin.king@canonical.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] dmaengine: stm32-mdma: fix spelling mistake:
 "avalaible" -> "available"
Message-ID: <20180502042910.GP6014@localhost>
References: <20180428220352.19601-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428220352.19601-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 11:03:52PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err error message text and make
> channel plural.

Applied, thanks

-- 
~Vinod
