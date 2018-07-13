Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40EDECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CCD208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CCD208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeGMNXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:23:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:59783 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbeGMNXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:23:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 06:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="57406017"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2018 06:08:47 -0700
Message-ID: <4848eeb4ec16af5d227ed2ec8f2d1a511bcb0636.camel@linux.intel.com>
Subject: Re: [PATCH v1] platform/x86: wmi: Switch to use new generic UUID API
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Tai <thomas.tai@oracle.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Date:   Fri, 13 Jul 2018 16:08:47 +0300
In-Reply-To: <20180713125351.26048-1-andriy.shevchenko@linux.intel.com>
References: <20180713125351.26048-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 15:53 +0300, Andy Shevchenko wrote:
> There are new types and helpers that are supposed to be used in new
> code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
> 
> While here, update Copyright to reflect this change along with
> previous
> one for the topic.

Oops, sorry for the noise, wrong patch from old archive.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
