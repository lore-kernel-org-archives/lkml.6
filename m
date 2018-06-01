Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbeFAHwz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:52:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:28142 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbeFAHwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:52:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="60898912"
Message-ID: <09ff4b28a17ef6056f54659696ce16d97442b469.camel@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Correct names of RESETS register
 bits
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Date: Fri, 01 Jun 2018 10:52:40 +0300
In-Reply-To: <20180425102632.GP2173@lahna.fi.intel.com>
References: <20180424150512.60824-1-andriy.shevchenko@linux.intel.com>
         <20180425102632.GP2173@lahna.fi.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:26 +0300, Mika Westerberg wrote:
> On Tue, Apr 24, 2018 at 06:05:12PM +0300, Andy Shevchenko wrote:
> > According to documentation the function has 2 bits for reset
> > while iDMA 64-bit has only one.
> > 
> > Rename it accordingly. Note, there is no functional change since
> > we always handle them together.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks, Mika!

Lee, anything about this one? (it's not stable material, though I don't
see it in linux-next)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
