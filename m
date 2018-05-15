Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeEOJEI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:04:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:30442 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752452AbeEOJED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:04:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="55317053"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the drm-intel tree
In-Reply-To: <20180515073349.6efabb21@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180515073349.6efabb21@canb.auug.org.au>
Date: Tue, 15 May 2018 12:06:36 +0300
Message-ID: <87po1x1e5f.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commits
>
>   cb8ba171ae6c ("drm/i915/gvt: let force_to_nonpriv cmd handler only valid for LRI cmd")
>   0438a1059877 ("drm/i915/gvt: do not return error on handling force_to_nonpriv registers")
>   3d8b9e258b9d ("drm/i915/gvt: let NOPID be the default value of force_to_nonpriv registers")
>   b99f514f5dfa ("drm/i915/gvt: Remove disable_warn_untrack and print untracked mmio with debug level")
>
> are missing a Signed-off-by from their committer.

Zhi's rebase fail leading to change of committer that I failed to
reject. :(

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
