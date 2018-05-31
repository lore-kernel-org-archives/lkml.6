Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755739AbeEaRIO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:08:14 -0400
Received: from muru.com ([72.249.23.125]:45582 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755556AbeEaRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:08:11 -0400
Date: Thu, 31 May 2018 10:08:08 -0700
From: Tony Lindgren <tony@atomide.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>
Subject: Re: drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: warning:  is
 used uninitialized in this function
Message-ID: <20180531170808.GP5705@atomide.com>
References: <201805312039.Rlh8ef3G%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805312039.Rlh8ef3G%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kbuild test robot <lkp@intel.com> [180531 12:26]:
> Hi Tony,
> 
> FYI, the error/warning still remains.

Oh OK. I just resent the fix separately as "[PATCH] phy: mapphone-mdm6600: Fix
wrong enum used for status lines". The previous fix was sent as a response
to your mail and that probably caused it to be lost in patchwork or something.

Regards,

Tony
