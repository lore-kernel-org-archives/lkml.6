Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeCOHXH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:23:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCOHXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:23:05 -0400
Date: Thu, 15 Mar 2018 00:22:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 0/3] Introduce module_nd_driver
Message-ID: <20180315072257.GA14576@infradead.org>
References: <20180314182508.10351-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314182508.10351-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 07:25:05PM +0100, Johannes Thumshirn wrote:
> Provide a module_nd_driver() wrapper and move over the appliccable
> drivers nd_pmem.ko and dax_pmem.ko.

What is the point?  It saves a hand fulk of lines, while making
the code both harder to read and harder to extend.
