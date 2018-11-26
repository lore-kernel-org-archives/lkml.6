Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51656C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D82B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D82B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeKZWWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:22:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:36854 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeKZWWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:22:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 03:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="252662982"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2018 03:29:03 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRF4Y-0003JH-9X; Mon, 26 Nov 2018 13:29:02 +0200
Date:   Mon, 26 Nov 2018 13:29:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David CARLIER <devnexen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        gregkh@linuxfoundation.org, aryabinin@virtuozzo.com
Subject: Re: [PATCH] Little memset_explicit optimisation
Message-ID: <20181126112902.GC10650@smile.fi.intel.com>
References: <CA+XhMqyR1wMEnEE2cCnoGj2RatxTbFuNH2jOj1-50iYso67rAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqyR1wMEnEE2cCnoGj2RatxTbFuNH2jOj1-50iYso67rAw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 12:35:43PM +0000, David CARLIER wrote:
> 

Hmm... Can we see the difference in assembly generation?


-- 
With Best Regards,
Andy Shevchenko


