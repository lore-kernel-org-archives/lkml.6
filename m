Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeBEFh1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 00:37:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:29721 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752249AbeBEFhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 00:37:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,463,1511856000";
   d="scan'208";a="198633756"
Date: Mon, 5 Feb 2018 11:11:57 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v3] dmaengine: dmatest: add norandom option
Message-ID: <20180205054157.GS18649@localhost>
References: <1517565069-19769-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517565069-19769-1-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 05:51:09PM +0800, Yang Shunyong wrote:
> Existing option noverify disables both random src/dst address offset
> setup and data verification. Sometimes, we need to control random
> src/dst address setup and verification separately, such as disabling
> random to make sure that test covers addresses in all interleaving
> banks, but data verification is still performed.
> 
> This patch adds option norandom to disable random offset setup. Option
> noverify has been changed to disable data verification only.

Applied, thanks

-- 
~Vinod
