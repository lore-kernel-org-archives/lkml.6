Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBQU5F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:57:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:32750 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeBQU5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:57:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,526,1511856000";
   d="scan'208";a="28048160"
Message-ID: <1518901021.22495.383.camel@linux.intel.com>
Subject: Re: i2c-designware: sound and s2ram broken on Broadwell-U system
 since commit ca382f5b38f367b6 (add i2c gpio recovery option)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: tim@krieglstein.org, jarkko.nikula@linux.intel.com,
        preid@electromag.com.au, wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sat, 17 Feb 2018 22:57:01 +0200
In-Reply-To: <20180217165815.GA1854@light.dominikbrodowski.net>
References: <20180217132543.GA21571@light.dominikbrodowski.net>
         <1518879773.22495.378.camel@linux.intel.com>
         <1518880180.22495.379.camel@linux.intel.com>
         <20180217165815.GA1854@light.dominikbrodowski.net>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-17 at 17:58 +0100, Dominik Brodowski wrote:
> On Sat, Feb 17, 2018 at 05:09:40PM +0200, Andy Shevchenko wrote:

> This patch fixes the issue, thanks.

I will send it soon out.

>  Do you still need the DEBUG_GPIO output?

It would be nice to have, though if it makes difficulties to you, then
don't bother.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
