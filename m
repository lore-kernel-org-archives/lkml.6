Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeBIFNW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 00:13:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:65215 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeBIFNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 00:13:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="30075744"
Date: Fri, 9 Feb 2018 10:46:48 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Colin King <colin.king@canonical.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Skylake: make function
 skl_clk_round_rate static
Message-ID: <20180209051647.GA3666@localhost>
References: <20180208143530.11450-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208143530.11450-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:35:30PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function skl_clk_round_rate is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> sound/soc/intel/skylake/skl-ssp-clk.c:250:6: warning: symbol
> 'skl_clk_round_rate' was not declared. Should it be static?

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
