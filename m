Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9911BC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E4420823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBHQjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:39:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:20526 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfBHQjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:39:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 08:39:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="142697168"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2019 08:39:09 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gs9BE-0007YH-5K; Fri, 08 Feb 2019 18:39:08 +0200
Date:   Fri, 8 Feb 2019 18:39:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
Message-ID: <20190208163908.GR9224@smile.fi.intel.com>
References: <cover.1547445576.git.vilhelm.gray@gmail.com>
 <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 05:07:34PM -0800, Andrew Morton wrote:
> On Mon, 14 Jan 2019 15:19:17 +0900 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> It's a shame that it doesn't actually dercease the kernel line count,
> but there are other benefits.
> 
> The patches are missing the hoped-for acks, but I think you maintain
> most/all of those drivers.

I'm okay with the code as well, so,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Do we have any expectation that these facilities will be used by
> anything other than GPIO?  If not then perhaps they should be sited
> within drivers/gpio (presumably as a standalone module) until such a
> need is found?

I think I have an example out of GPIO realm. But I need time to prove that.
In any case I tend to bend to the generic exposure than to local one.

-- 
With Best Regards,
Andy Shevchenko


