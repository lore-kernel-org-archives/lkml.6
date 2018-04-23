Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeDWTt2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:49:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932292AbeDWTtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:49:24 -0400
Date: Mon, 23 Apr 2018 12:49:17 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: jack@suse.cz, viro@zeniv.linux.org.uk, ross.zwisler@linux.intel.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] fs: dax: Adding new return type vm_fault_t
Message-ID: <20180423194917.GF13383@bombadil.infradead.org>
References: <20180423180625.GA16101@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423180625.GA16101@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:36:25PM +0530, Souptick Joarder wrote:
> If the insertion of PTE failed because someone else
> already added a different entry in the mean time, we
> treat that as success as we assume the same entry was
> actually inserted.

No, Jan said to *make it a comment*.  In the source file.  That's why
he formatted it with the /* */.  Not in the changelog.
