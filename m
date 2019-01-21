Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D8C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4746220861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfAULMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:12:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:37474 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfAULMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:12:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 03:12:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,502,1539673200"; 
   d="scan'208";a="116243030"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga007.fm.intel.com with SMTP; 21 Jan 2019 03:12:14 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Jan 2019 13:12:13 +0200
Date:   Mon, 21 Jan 2019 13:12:13 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: cherryview: fix Strago DMI workaround
Message-ID: <20190121111213.GV14577@lahna.fi.intel.com>
References: <20190115033836.GA150475@dtor-ws>
 <20190115053258.GA9170@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115053258.GA9170@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 07:32:58AM +0200, Andy Shevchenko wrote:
> On Mon, Jan 14, 2019 at 07:38:36PM -0800, Dmitry Torokhov wrote:
> > Well, hopefully 3rd time is a charm. We tried making that check
> > DMI_BIOS_VERSION and DMI_BOARD_VERSION, but the real one is
> > DMI_PRODUCT_VERSION.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Also,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
