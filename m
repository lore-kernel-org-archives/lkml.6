Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD74C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38593205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38593205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJVQev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:34:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:50379 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeJVQev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:34:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 01:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,411,1534834800"; 
   d="scan'208";a="80579121"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 22 Oct 2018 01:17:17 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Oct 2018 11:17:18 +0300
Date:   Mon, 22 Oct 2018 11:17:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/5] pinctrl: intel: pinctrl-baytrail: simplify getting
 .driver_data
Message-ID: <20181022081718.GQ2302@lahna.fi.intel.com>
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
 <20181021200032.1833-2-wsa+renesas@sang-engineering.com>
 <20181021211951.GM10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021211951.GM10650@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 12:19:51AM +0300, Andy Shevchenko wrote:
> On Sun, Oct 21, 2018 at 10:00:27PM +0200, Wolfram Sang wrote:
> > We should get 'driver_data' from 'struct device' directly. Going via
> > platform_device is an unneeded step back and forth.
> > 
> 
> Thanks!
> 
> I see only 3 out of 5 patches.
> 
> Since we are about to establish a separate tree as well as an additional record
> in MAINTAINERS data base for Intel pinctrl driver, I ask you to resend only
> Intel related stuff in a separate series.

Well, it is easy enough to apply to our tree even if part of larger
series :) So no need to resend anything IMHO.

Looks good to me,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
