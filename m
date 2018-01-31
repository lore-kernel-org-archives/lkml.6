Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeAaHaU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:30:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:15056 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753082AbeAaH3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:29:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,438,1511856000";
   d="scan'208";a="14372802"
Date: Wed, 31 Jan 2018 13:04:24 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: dmatest: add norandom option
Message-ID: <20180131073424.GW18649@localhost>
References: <1516617881-30044-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <1516617881-30044-2-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516617881-30044-2-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 06:44:41PM +0800, Yang Shunyong wrote:
> Existing option noverify disables both random src/dst address offset
> setup and data verification. Sometimes, we need to control random
> src/dst address setup and verification separately, such as disabling
> random to make sure that test covers addresses in all interleaving
> banks in one run. This patch adds option norandom to disable random
> offset setup. Option noverify has been changed to disable data
> verification only.

This doesn't apply for me due to dependency on previous patch. Please rebase
and resend.

-- 
~Vinod
