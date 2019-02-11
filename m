Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D815CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A569520821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBKK3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:29:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:57283 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKK3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:29:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 02:29:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="132650128"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Feb 2019 02:29:42 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gt8qL-00047B-PW; Mon, 11 Feb 2019 12:29:41 +0200
Date:   Mon, 11 Feb 2019 12:29:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: driver-api: fix dmatest.rst warning
Message-ID: <20190211102941.GB9224@smile.fi.intel.com>
References: <da8b9103-5203-13da-65c5-232233ab0bfb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da8b9103-5203-13da-65c5-232233ab0bfb@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 10:26:53PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix markup warning: insert a blank line before the hint.
> 
> Documentation/driver-api/dmaengine/dmatest.rst:63: WARNING: Unexpected indentation.

Thanks.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> ---
>  Documentation/driver-api/dmaengine/dmatest.rst |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-50-rc6.orig/Documentation/driver-api/dmaengine/dmatest.rst
> +++ lnx-50-rc6/Documentation/driver-api/dmaengine/dmatest.rst
> @@ -59,6 +59,7 @@ parameter, that specific channel is requ
>  is created with the existing parameters. This thread is set as pending
>  and will be executed once run is set to 1. Any parameters set after the thread
>  is created are not applied.
> +
>  .. hint::
>    available channel list could be extracted by running the following command::
>  
> 
> 

-- 
With Best Regards,
Andy Shevchenko


