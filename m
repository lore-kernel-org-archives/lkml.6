Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeBVQZU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:25:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbeBVQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:25:18 -0500
Date: Thu, 22 Feb 2018 08:25:16 -0800
From: Darren Hart <dvhart@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86: wmi: Replace list_for_each() by
 list_for_each_entry()
Message-ID: <20180222162516.GB19843@fury>
References: <20180219150228.5823-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219150228.5823-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 05:02:28PM +0200, Andy Shevchenko wrote:
> In all cases list_for_each() followed by list_entry(),
> so, replace them by list_for_each_entry() macro.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice cleanup Andy, thanks.

Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>

-- 
Darren Hart
VMware Open Source Technology Center
