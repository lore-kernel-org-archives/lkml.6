Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756127AbeCHQYw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:24:52 -0500
Received: from muru.com ([72.249.23.125]:60076 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbeCHQYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:24:50 -0500
Date: Thu, 8 Mar 2018 08:24:46 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
        abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: Nokia N900: insecure W+X mapping at 0xd0050000
Message-ID: <20180308162446.GK5799@atomide.com>
References: <20180308142818.GA9439@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308142818.GA9439@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180308 06:29]:
> Insecure W+X mappings, who cares about those? I have 7 pages...

Is this with CONFIG_DEBUG_WX=y?

My guess is that it's for mapping the PM assembly to SRAM. This
is already fixed for am335x that is using drivers/misc/sram*.c.
I think omap2 - omap4 still need fixing if this is the culprit.

Regards,

Tony
