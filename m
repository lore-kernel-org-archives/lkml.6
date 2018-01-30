Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeA3MeD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:34:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbeA3MeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:34:02 -0500
Date: Tue, 30 Jan 2018 13:34:00 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] mm/swap.c: make functions and their kernel-doc agree
Message-ID: <20180130123400.GD26445@dhcp22.suse.cz>
References: <3b42ee3e-04a9-a6ca-6be4-f00752a114fe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b42ee3e-04a9-a6ca-6be4-f00752a114fe@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-01-18 16:43:55, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix some basic kernel-doc notation in mm/swap.c:
> - for function lru_cache_add_anon(), make its kernel-doc function name
>   match its function name and change colon to hyphen following the
>   function name

This is pretty much an internal function to the MM. It shouldn't have
any external callers. Why do we need a kernel doc at all?

> - for function pagevec_lookup_entries(), change the function parameter
>   name from nr_pages to nr_entries since that is more descriptive of
>   what the parameter actually is and then it matches the kernel-doc
>   comments also

I know what is nr_pages because I do expect pages to be returned. What
are entries? Can it be something different from pages?
-- 
Michal Hocko
SUSE Labs
