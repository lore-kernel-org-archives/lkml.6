Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeEJXMp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 19:12:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeEJXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 19:12:44 -0400
Date: Thu, 10 May 2018 16:12:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 0/5] fix radix tree multi-order iteration race
Message-Id: <20180510161242.0f9f97686a9c0a47f07eef4e@linux-foundation.org>
In-Reply-To: <CAPcyv4hy40dRr81aO7mr5LhC4L=es6NXE_kDCO2+USGXovGDiQ@mail.gmail.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
        <20180508174424.GA12638@linux.intel.com>
        <20180510154844.dc4e4c7471a885b73ed50576@linux-foundation.org>
        <CAPcyv4hy40dRr81aO7mr5LhC4L=es6NXE_kDCO2+USGXovGDiQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 15:54:53 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> > - The Fixes: tag
> > - The Reported-by
> 
> Those were there.
> 
> > - Jan's reviewed-by
> 
> Right, Jan's came after I pushed it for -next soaking, but I updated it.
> 
> > - the cc:stable tag
> 
> That was there too, not sure where you were looking.

git show 4272afac65e0debacae7eb6af4591e31ba89dcad
