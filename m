Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F28B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbfAKTvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:51:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:51866 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732913AbfAKTtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:49:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 11:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="107572899"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2019 11:49:31 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gi2o5-0002Zt-SK; Fri, 11 Jan 2019 21:49:29 +0200
Date:   Fri, 11 Jan 2019 21:49:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v1] gpiolib: acpi: Introduce
 ACPI_GPIO_QUIRK_ONLY_GPIOIO
Message-ID: <20190111194929.GW9170@smile.fi.intel.com>
References: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYgBsvNR1PFuzmMegpjraWRi58ACb-=mBrUDvLoi_5J_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYgBsvNR1PFuzmMegpjraWRi58ACb-=mBrUDvLoi_5J_g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:21:39PM +0100, Linus Walleij wrote:
> On Tue, Jan 8, 2019 at 7:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > New quirk enforces search for GPIO based on its type.
> > Note, supplied index in the mapping table must be 0.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> (...)
> 
> >  sound/soc/intel/boards/bytcr_rt5651.c | 74 ++++-----------------------
> 
> Do we have an ACK from the maintainer of this file?
> It's Hans I think. Ideally also from Mark Brown.

I hope to get Hans' Tested-by on this.

-- 
With Best Regards,
Andy Shevchenko


