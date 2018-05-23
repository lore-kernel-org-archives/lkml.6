Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeEWPsx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:48:53 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55938 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbeEWPss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:48:48 -0400
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc: Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152705223910.21414.17294372359464462569.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <40d702a1-1664-6556-ab64-e188f0733675@deltatee.com>
Date: Wed, 23 May 2018 09:48:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152705223910.21414.17294372359464462569.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, hch@lst.de, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 4/7] mm, devm_memremap_pages: Add MEMORY_DEVICE_PRIVATE
 support
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/18 11:10 PM, Dan Williams wrote:
> In preparation for consolidating all ZONE_DEVICE enabling via
> devm_memremap_pages(), teach it how to handle the constraints of
> MEMORY_DEVICE_PRIVATE ranges.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
