Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeDYJFy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:05:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:39157 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeDYJFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:05:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,325,1520924400";
   d="scan'208";a="219228623"
Date: Wed, 25 Apr 2018 14:40:29 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Append some fixes and improvements
Message-ID: <20180425091029.GL6014@localhost>
References: <1523627533-7184-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523627533-7184-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 03:52:11PM +0200, Pierre-Yves MORDRET wrote:
> Fix an issue with FIFO Size and burst size.
> Fix an incomplete allocator for Hardware descriptors: memory badly
> allocated.

Applied, thanks

-- 
~Vinod
