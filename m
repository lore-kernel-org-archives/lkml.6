Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8BAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5982082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5982082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeJYRyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:54:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:48264 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbeJYRyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:54:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 02:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,423,1534834800"; 
   d="scan'208";a="275481844"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2018 02:22:22 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gFbqP-0002EM-ON; Thu, 25 Oct 2018 12:22:21 +0300
Date:   Thu, 25 Oct 2018 12:22:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan O'Donovan <dan@emutex.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
Message-ID: <20181025092221.GW10650@smile.fi.intel.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
 <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com>
 <20181023185453.GA27397@amd>
 <226e0df2-83f9-bee5-f359-a3e040d12311@gmail.com>
 <20181023193014.GA32003@amd>
 <00720f10-a525-32d1-0aa5-00fc88251f5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00720f10-a525-32d1-0aa5-00fc88251f5e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:07:30PM +0200, Jacek Anaszewski wrote:

> Yet, there are many out of LED subsystem files to update:
> 
> find -name "*.c" -o -name "*.h" | xargs grep  "enum led_brightness" |
> awk -F: '{print $1}' | sort -u | grep -v "leds" | wc -l
> 
> returns 87.

Side note: 

git grep -n 'enum led_brightness' | ...

a bit more effitient.

-- 
With Best Regards,
Andy Shevchenko


