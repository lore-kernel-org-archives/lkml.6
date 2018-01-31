Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeAaH6x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:58:53 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:41237 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeAaH6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:58:51 -0500
Date: Tue, 30 Jan 2018 23:58:48 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] mm/swap.c: make functions and their kernel-doc agree
Message-ID: <20180131075848.GB28275@bombadil.infradead.org>
References: <3b42ee3e-04a9-a6ca-6be4-f00752a114fe@infradead.org>
 <20180130123400.GD26445@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130123400.GD26445@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 01:34:00PM +0100, Michal Hocko wrote:
> On Mon 29-01-18 16:43:55, Randy Dunlap wrote:
> > - for function pagevec_lookup_entries(), change the function parameter
> >   name from nr_pages to nr_entries since that is more descriptive of
> >   what the parameter actually is and then it matches the kernel-doc
> >   comments also
> 
> I know what is nr_pages because I do expect pages to be returned. What
> are entries? Can it be something different from pages?

entries are any page cache entries -- pages or exceptional entries.
calling this parameter nr_pages tricks you into thinking that you'll
only get pages back.
