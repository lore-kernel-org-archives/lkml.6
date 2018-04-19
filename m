Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbeDSX45 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 19:56:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeDSX4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 19:56:55 -0400
Date: Thu, 19 Apr 2018 16:56:51 -0700
From: Darren Hart <dvhart@infradead.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 40/61] platform: x86: simplify getting .drvdata
Message-ID: <20180419235651.GC11546@fury>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-41-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-41-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:06:10PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 

It is indeed, thanks.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.

Queued up for testing.

(I'm not sure what you mean by "Please apply individually")
-- 
Darren Hart
VMware Open Source Technology Center
