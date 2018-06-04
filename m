Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeFDItI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:49:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFDItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:49:05 -0400
Date: Mon, 4 Jun 2018 01:49:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/39] vfs: export vfs_ioctl() to modules
Message-ID: <20180604084904.GF11333@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-8-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-8-mszeredi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:07PM +0200, Miklos Szeredi wrote:
> This is needed by the stacked ioctl implementation in overlayfs.

EXPORT_SYMBOL_GPL for exporting random internals, please.  Same
for any following patches.
