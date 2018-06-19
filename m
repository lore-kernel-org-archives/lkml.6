Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7492CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEB020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEB020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966954AbeFSQAa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:00:30 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50824 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965783AbeFSQA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:00:28 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fVJ3P-0007w1-5K; Tue, 19 Jun 2018 10:00:24 -0600
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152938829462.17797.17960582127304725369.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6d5ae5ea-48ed-fc0b-8945-a0478aa0ca5c@deltatee.com>
Date:   Tue, 19 Jun 2018 10:00:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152938829462.17797.17960582127304725369.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, hch@lst.de, stable@vger.kernel.org, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 3/8] mm, devm_memremap_pages: Fix shutdown handling
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/06/18 12:04 AM, Dan Williams wrote:
> Cc: <stable@vger.kernel.org>
> Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

