Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F49C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB65020844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB65020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbeKGJcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:32:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:44912 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbeKGJcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:32:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 16:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,473,1534834800"; 
   d="scan'208";a="106015714"
Received: from labuser-z97x-ud5h.jf.intel.com (HELO intel.com) ([10.54.75.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Nov 2018 16:04:59 -0800
Date:   Tue, 6 Nov 2018 16:07:25 -0800
From:   Manasi Navare <manasi.d.navare@intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [Intel-gfx] linux-next: Signed-off-by missing for commit in the
 drm-intel tree
Message-ID: <20181107000724.GJ26420@intel.com>
References: <20181107065929.3ded00a6@canb.auug.org.au>
 <20181107000034.GD2367@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107000034.GD2367@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 04:00:34PM -0800, Rodrigo Vivi wrote:
> On Wed, Nov 07, 2018 at 06:59:29AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Commit
> > 
> >   35b876db4a42 ("drm/i915/dsc: Add slice_row_per_frame in DSC PPS programming")
> > 
> > is missing a Signed-off-by from its committer.
> 
> It seems the tag "Suggested-by:" tricked out our maintainer tools.

Hmm yea that makes sense since it did have suggested-by: me (committer)
so it skipped adding my sign-off.

Thanks for catching this and fixing it in tools.

Manasi

> 
> from dim:
> 
> # check for committer sign-off
> if ! git show -s $sha1 | grep -qi "S.*-by:.*$committer"  ; then
> 
> -----
> 
> I will send a patch to our tools to spell signed-off-by directly.
> 
> Thanks for reporting this out.
> Rodrigo.
> 
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> 
> 
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
