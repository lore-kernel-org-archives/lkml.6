Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeELOZC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 10:25:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeELOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 10:25:01 -0400
Date: Sat, 12 May 2018 07:24:51 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        mhocko@suse.com, hughd@google.com, dan.j.williams@intel.com,
        rientjes@google.com, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com, aneesh.kumar@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: Change return type to vm_fault_t
Message-ID: <20180512142451.GB24215@bombadil.infradead.org>
References: <20180512061712.GA26660@jordon-HP-15-Notebook-PC>
 <e194731158f7f89145ed0ae28f46aac5726fc32d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e194731158f7f89145ed0ae28f46aac5726fc32d.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:20:29PM -0700, Joe Perches wrote:
> It'd be nicer to realign the 2nd and 3rd arguments
> on the subsequent lines.
> 
> 	vm_fault_t (*fault)(const struct vm_special_mapping *sm,
> 			    struct vm_area_struct *vma,
> 			    struct vm_fault *vmf);
> 

It'd be nicer if people didn't try to line up arguments at all and
just indented by an extra two tabs when they had to break a logical
line due to the 80-column limit.
