Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeFAIcH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeFAIcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:32:02 -0400
Date: Fri, 1 Jun 2018 10:31:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>,
        Amir Shehata <amir.shehata@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH v2 v2 07/25] staging: lustre: libcfs: replace
 num_possible_cpus() with nr_cpu_ids
Message-ID: <20180601083140.GC19242@kroah.com>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
 <1527603725-30560-8-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527603725-30560-8-git-send-email-jsimmons@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:21:47AM -0400, James Simmons wrote:
> From: Amir Shehata <amir.shehata@intel.com>
> 
> Move from num_possible_cpus() to nr_cpu_ids.

This says what you did, not _why_ you did it.  If these functions are
really identical, why do we have both of them?  :)

greg k-h
