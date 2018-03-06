Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeCFSGT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:06:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:47695 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932112AbeCFSGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:06:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="25702608"
Date: Tue, 6 Mar 2018 20:06:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Javier Arteaga <javier@emutex.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: intel: Implement intel_gpio_get_direction
 callback
Message-ID: <20180306180613.GA22205@lahna.fi.intel.com>
References: <20180306134213.16898-1-javier@emutex.com>
 <3585081b-70af-5c31-08c0-84e96b6055bc@emutex.com>
 <1520348165.10722.438.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520348165.10722.438.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 04:56:05PM +0200, Andy Shevchenko wrote:
> On Tue, 2018-03-06 at 14:31 +0000, Javier Arteaga wrote:
> > (Fix Andy's Cc: - apologies)
> > 
> > On 06/03/2018 13:42, Javier Arteaga wrote:
> > > Allows querying GPIO direction from the pad config register.
> > > If the pad is not in GPIO mode, return an error.
> > > 
> > > Signed-off-by: Javier Arteaga <javier@emutex.com>
> > > ---
> > > This is needed by the drivers for the UP Squared board, an APL-based
> > > platform. (For now, these drivers are out-of-tree.)
> > > 
> > > An earlier version of this patch was reviewed some time ago by Andy
> > > Shevchenko outside of the mailing lists:
> > > <https://github.com/emutex/ubilinux-kernel/commit/708a776f2ffd1b1c>
> > > 
> 
> Yes, this one look good!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
