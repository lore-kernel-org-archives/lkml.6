Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B63AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF752073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF752073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeH3OlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:41:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:8679 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbeH3OlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:41:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 03:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="69279972"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2018 03:39:34 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1fvKMP-0000b3-5X; Thu, 30 Aug 2018 13:39:33 +0300
Date:   Thu, 30 Aug 2018 13:39:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/2] clk: Add of_clk_get_by_name_optional() function
Message-ID: <20180830103933.GJ11447@smile.fi.intel.com>
References: <1533039060-18779-1-git-send-email-phil.edworthy@renesas.com>
 <1533039060-18779-2-git-send-email-phil.edworthy@renesas.com>
 <20180829171039.GD11447@smile.fi.intel.com>
 <TY1PR01MB176960BEDC23EA64095EF6F2F5080@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB176960BEDC23EA64095EF6F2F5080@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 08:30:59AM +0000, Phil Edworthy wrote:
> On 29 August 2018 18:11 Andy Shevchenko wrote:
> > On Tue, Jul 31, 2018 at 01:10:59PM +0100, Phil Edworthy wrote:

> Thanks for the review. I'm not particularly happy with the patch as is, it's
> pretty messy. I was in rush trying to get things done before holidays - always
> a mistake.
> Would you mind if I sent a v5 that I feel is somewhat clearer?

That's definitely preferable!

-- 
With Best Regards,
Andy Shevchenko


