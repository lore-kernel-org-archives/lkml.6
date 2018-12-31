Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A527CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8174F21738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeLaKxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:53:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:8729 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeLaKxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 05:53:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 02:53:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,422,1539673200"; 
   d="scan'208";a="122953026"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 31 Dec 2018 02:53:50 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gdvCe-0002Zo-Ll; Mon, 31 Dec 2018 12:53:48 +0200
Date:   Mon, 31 Dec 2018 12:53:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        me@jue.yt, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, Juergen Fitschen <jfi@ssv-embedded.de>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20181231105348.GV10650@smile.fi.intel.com>
References: <20181227151311.20107-1-ludovic.desroches@microchip.com>
 <20181227151311.20107-4-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227151311.20107-4-ludovic.desroches@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Slave mode driver is based on the concept of i2c-designware driver.

> +/*
> + *  i2c slave support for Atmel's AT91 Two-Wire Interface (TWI)
> + *
> + *  Copyright (C) 2017 Juergen Fitschen <me@jue.yt>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + */

Perhaps, you can use SPDX instead of boiler plate license text in the files?

-- 
With Best Regards,
Andy Shevchenko


