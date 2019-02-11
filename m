Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D51EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E541B218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBKL7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:59:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:25135 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfBKL7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:59:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 03:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="319380856"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2019 03:59:52 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gtAFb-0004mK-Pt; Mon, 11 Feb 2019 13:59:51 +0200
Date:   Mon, 11 Feb 2019 13:59:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] Intel Cherry Trail Whiskey Cove LEDs support
Message-ID: <20190211115951.GC9224@smile.fi.intel.com>
References: <20190209221213.24052-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209221213.24052-1-jekhor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 01:12:12AM +0300, Yauhen Kharuzhy wrote:
> This patch series introduces new driver for controlling LEDs connected
> to Intel Cherry Trail Whiskey Cove PMIC (general-purpose LED and charger
> status led). Only simple 'always on' and blinking modes are supported
> for now, no breathing.
> 
> Driver was tested only with Lenovo Yoga Book notebook, and I don't have
> any documentation for the PMIC, so proposals and testing are welcome.
> 

I'm not sure you have a correct Cc list here. LED maintainers are
M:      Jacek Anaszewski <jacek.anaszewski@gmail.com>
M:      Pavel Machek <pavel@ucw.cz>

Also would be nice to cc to Hans de Goede.


-- 
With Best Regards,
Andy Shevchenko


