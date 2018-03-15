Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCOILW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:11:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42841 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeCOILU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:11:20 -0400
Date: Thu, 15 Mar 2018 09:11:18 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 0/3] Introduce module_nd_driver
Message-ID: <20180315081118.vivohgn6vrt74pyc@linux-x5ow.site>
References: <20180314182508.10351-1-jthumshirn@suse.de>
 <20180315072257.GA14576@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180315072257.GA14576@infradead.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 12:22:57AM -0700, Christoph Hellwig wrote:
> What is the point?  It saves a hand fulk of lines, while making
> the code both harder to read and harder to extend.

In the end it's just style alignment with most of the other "busses"
in the kernel, like pci, of, acpi, platform and so on...

But yes I admit it's not a huge win. For the harder to read part, I
doubt it. A quick:
git grep -E module_.*._driver drivers/ | wc -l
has 3896 hit's, so it's not that uncommon ;-)

But anyways, it's just code churn I came up with while being
frustrated hunting down a bug in this subsystem.

Byte,
	   Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
