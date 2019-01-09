Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E104BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA2B20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfAIJVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:21:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:46986 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730155AbfAIJVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:21:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="116682924"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 09 Jan 2019 01:20:59 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 09 Jan 2019 11:20:58 +0200
Date:   Wed, 9 Jan 2019 11:20:58 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH v1] gpiolib: acpi: Introduce
 ACPI_GPIO_QUIRK_ONLY_GPIOIO
Message-ID: <20190109092058.GD2469@lahna.fi.intel.com>
References: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:02:05PM +0200, Andy Shevchenko wrote:
> New quirk enforces search for GPIO based on its type.
> Note, supplied index in the mapping table must be 0.

Can you document this where you define the new flag so new users do not
need go through git history?

Otherwise looks good. :)
