Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeA3Guw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:50:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:61561 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeA3Guu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:50:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,433,1511856000";
   d="scan'208";a="14486373"
Date: Tue, 30 Jan 2018 12:25:23 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, yu.zheng@hxt-semitch.com
Subject: Re: [PATCH v2] dmaengine: dmatest: fix container_of member in
 dmatest_callback
Message-ID: <20180130065522.GO18649@localhost>
References: <1517208011-7640-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517208011-7640-1-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 02:40:11PM +0800, Yang Shunyong wrote:
> The type of arg passed to dmatest_callback is struct dmatest_done.
> It refers to test_done in struct dmatest_thread, not done_wait.

Applied, thanks

-- 
~Vinod
