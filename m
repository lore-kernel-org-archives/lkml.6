Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeDVQGk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 12:06:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:44756 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754054AbeDVQGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 12:06:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,313,1520924400";
   d="scan'208";a="222407196"
Date: Sun, 22 Apr 2018 21:41:11 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/6] tree-wide: simplify getting .drvdata
Message-ID: <20180422161111.GY6014@localhost>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 11:14:08AM +0200, Wolfram Sang wrote:
> I got tired of fixing this in Renesas drivers manually, so I took the big
> hammer. Remove this cumbersome code pattern which got copy-pasted too much
> already:
> 
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
> 
> I send this out as one patch per directory per subsystem. I think they should
> be applied individually. If you prefer a broken out series per subsystem, I can
> provide this as well. Just mail me.

Applied all, thanks

-- 
~Vinod
