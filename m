Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbeFAIj7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbeFAIjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:39:55 -0400
Date: Fri, 1 Jun 2018 10:39:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH v2 13/25] staging: lustre: libcfs: fix libcfs_cpu coding
 style
Message-ID: <20180601083932.GF19242@kroah.com>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
 <1527603725-30560-14-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527603725-30560-14-git-send-email-jsimmons@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:21:53AM -0400, James Simmons wrote:
>  int cfs_cpt_set_nodemask(struct cfs_cpt_table *cptab,
> -			 int cpt, nodemask_t *mask);
> +			 int cpt, const nodemask_t *mask);

This is not a coding style change.  It is a semi-functional change.
Don't bury code changes in the middle of "cleanup code formatting"
patches, it makes maintainers very grumpy when we notice this as we then
feel like we might have missed other things being snuck by us in the
guise of these types of patches...

thanks,

greg k-h
