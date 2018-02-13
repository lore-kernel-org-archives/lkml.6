Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965641AbeBMTg4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:36:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965517AbeBMTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:36:55 -0500
Date: Tue, 13 Feb 2018 11:36:49 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Mario Leinweber <marioleinweber@web.de>
Cc: akpm@linux-foundation.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup: Fixed coding style error and warnings.
Message-ID: <20180213193649.GA2663@bombadil.infradead.org>
References: <20180213191722.11228-1-marioleinweber@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213191722.11228-1-marioleinweber@web.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 02:17:22PM -0500, Mario Leinweber wrote:
>  	if (flags & FOLL_SPLIT && PageTransCompound(page)) {
>  		int ret;
> +
>  		get_page(page);

Hi Mario,

Thanks for your patch, but this kind of change to the Linux core is not
generally welcomed.  There are a lot of people working on the core and
having whitespace changes conflict with real changes isn't a good use of
people's time.  You can practice whitespace changes in drivers/staging
before graduating to patches which change functionality.

Hope to see you back soon!
