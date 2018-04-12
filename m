Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeDLQZD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:25:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbeDLQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:25:02 -0400
Date: Thu, 12 Apr 2018 09:25:00 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/35] vfs: clean up dedup
Message-ID: <20180412162500.GA24728@bombadil.infradead.org>
References: <20180412150826.20988-1-mszeredi@redhat.com>
 <20180412150826.20988-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412150826.20988-2-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 05:07:52PM +0200, Miklos Szeredi wrote:
> +ssize_t vfs_dedupe_file_range_one(struct file *src_file, u64 src_pos, u64 len,
> +			      struct file *dst_file, u64 dst_pos)

Why u64 instead of loff_t?
