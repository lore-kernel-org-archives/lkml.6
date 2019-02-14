Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F03C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390FB218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406972AbfBNMrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:47:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:54221 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfBNMrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:47:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 04:47:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="143421236"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2019 04:47:45 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1guGQa-0003Gi-QT; Thu, 14 Feb 2019 14:47:44 +0200
Date:   Thu, 14 Feb 2019 14:47:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
Message-ID: <20190214124744.GT9224@smile.fi.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:00:44AM +0100, Hans de Goede wrote:
> On 10-02-19 21:36, Yauhen Kharuzhy wrote:

> A kind request to the platform-x86 driver maintainers (hi Andy): Please
> do not apply these patches until I've been able to test they don't cause
> issues elsewhere.

Yes, that's my plan from the day one.

I also asked Yauhen to keep you in Cc list for all patches regarding the
platform he is enabling. On his GH page you may find, btw, a pile of patches.
I hope we will not get a patch bomb at once.

-- 
With Best Regards,
Andy Shevchenko


