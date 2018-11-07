Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715DDC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331EC20844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331EC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbeKGJ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:28:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:23881 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388174AbeKGJ2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:28:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 16:00:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,473,1534834800"; 
   d="scan'208";a="89109762"
Received: from rdvivi-vienna.jf.intel.com (HELO intel.com) ([10.7.196.65])
  by orsmga006.jf.intel.com with ESMTP; 06 Nov 2018 16:00:35 -0800
Date:   Tue, 6 Nov 2018 16:00:34 -0800
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] linux-next: Signed-off-by missing for commit in the
 drm-intel tree
Message-ID: <20181107000034.GD2367@intel.com>
References: <20181107065929.3ded00a6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107065929.3ded00a6@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 06:59:29AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   35b876db4a42 ("drm/i915/dsc: Add slice_row_per_frame in DSC PPS programming")
> 
> is missing a Signed-off-by from its committer.

It seems the tag "Suggested-by:" tricked out our maintainer tools.

from dim:

# check for committer sign-off
if ! git show -s $sha1 | grep -qi "S.*-by:.*$committer"  ; then

-----

I will send a patch to our tools to spell signed-off-by directly.

Thanks for reporting this out.
Rodrigo.

> 
> -- 
> Cheers,
> Stephen Rothwell



> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

