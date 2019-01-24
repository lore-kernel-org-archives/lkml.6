Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09083C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C970420854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfAXLbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:31:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:42211 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfAXLbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:31:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 03:31:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,515,1539673200"; 
   d="scan'208";a="140923416"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2019 03:31:35 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Weinan Li <weinan.z.li@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-intel-fixes tree
In-Reply-To: <20190124221949.4c89542a@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190124221949.4c89542a@canb.auug.org.au>
Date:   Thu, 24 Jan 2019 13:33:17 +0200
Message-ID: <87munq1e9u.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> In commit
>
>   0f7555121609 ("drm/i915/gvt: release shadow batch buffer and wa_ctx before destroy one workload")
>
> Fixes tag
>
>   Fixes: 0cce2823ed37 ("drm/i915/gvt/kvmgt:Refine error handling for prepare_execlist_workload")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>
> Just some whitespace.

Thanks for the report. The commit being referenced seems to be the right
one, though, so I don't think I'm going to force push to fix this.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
