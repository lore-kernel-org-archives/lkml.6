Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935647AbeCABbU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:31:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeCABbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:31:19 -0500
Date: Wed, 28 Feb 2018 17:31:15 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Split page_type out from mapcount
Message-ID: <20180301013115.GA2946@bombadil.infradead.org>
References: <20180228223157.9281-1-willy@infradead.org>
 <06c145aa-db40-df72-b626-da9d45f9111d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c145aa-db40-df72-b626-da9d45f9111d@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 03:22:49PM -0800, Randy Dunlap wrote:
> On 02/28/2018 02:31 PM, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > I want to use the _mapcount field to record what a page is in use as.
> > This can help with debugging and we can also expose that information to
> > userspace through /proc/kpageflags to help diagnose memory usage (not
> > included as part of this patch set).
> 
> Hey,
> 
> Will there be updates to tools/vm/ also, or are these a different set of
> (many) flags?

Those KPF flags are the ones I was talking about.  I haven't looked into
what it takes to assign those flags yet.
