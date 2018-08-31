Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6827420661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6827420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeHaREp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:04:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:47148 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeHaREo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:04:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 05:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="79868505"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 31 Aug 2018 05:57:20 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 31 Aug 2018 15:57:20 +0300
Date:   Fri, 31 Aug 2018 15:57:20 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/7] MAINTAINERS: Add myself as designated reviewer of
 Intel MFD PMIC
Message-ID: <20180831125720.GN2283@lahna.fi.intel.com>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
 <20180830165255.43114-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830165255.43114-7-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 07:52:55PM +0300, Andy Shevchenko wrote:
> There are few Intel MFD PMIC device drivers which I would like
> to review.
> 
> Note, Intel MSIC is old system controller that based mostly on PMIC
> integrated in it. Thus, I included it as well.

Good idea.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
