Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEQGgi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:36:38 -0400
Received: from verein.lst.de ([213.95.11.211]:51523 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752339AbeEQGgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:36:36 -0400
Date: Thu, 17 May 2018 08:41:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build warning after merge of the vfs tree
Message-ID: <20180517064108.GA24207@lst.de>
References: <20180517103932.3d7014d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517103932.3d7014d1@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:39:32AM +1000, Stephen Rothwell wrote:
> Hi Al,
> 
> After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> drivers/isdn/gigaset/capi.c:2344:14: warning: 'gigaset_procinfo' defined but not used [-Wunused-function]
>  static char *gigaset_procinfo(struct capi_ctr *ctr)

The assignment for it was incorrectly removed.  I'll send a set of fixes
to Al.
