Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDUTeP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 15:34:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbeDUTeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 15:34:14 -0400
Date: Sat, 21 Apr 2018 12:34:09 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: hughd@google.com, minchan@kernel.org, ying.huang@intel.com,
        ross.zwisler@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: memory: Introduce new vmf_insert_mixed_mkwrite
Message-ID: <20180421193409.GD14610@bombadil.infradead.org>
References: <20180421170540.GA17849@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421170540.GA17849@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 10:35:40PM +0530, Souptick Joarder wrote:
> As of now vm_insert_mixed_mkwrite() is only getting
> invoked from fs/dax.c, so this change has to go first
> in linus tree before changes in dax.

No.  One patch which changes both at the same time.  The history should
be bisectable so that it compiles and works at every point.

The rest of the patch looks good.
