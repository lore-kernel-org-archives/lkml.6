Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D083BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84D7222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438783AbfBNNLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:11:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:44355 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbfBNNLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:11:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 05:11:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="116178735"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2019 05:11:18 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1guGnM-0003SN-Tz; Thu, 14 Feb 2019 15:11:16 +0200
Date:   Thu, 14 Feb 2019 15:11:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     rdunlap@infradead.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guiding Li <liguiding@pinecone.net>
Subject: Re: [PATCH V2 2/2] rpmsg: add syslog redirection driver
Message-ID: <20190214131116.GW9224@smile.fi.intel.com>
References: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
 <1550124158-1111-2-git-send-email-xiaoxiang@xiaomi.com>
 <20190214130940.GV9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214130940.GV9224@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:09:40PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 14, 2019 at 02:02:38PM +0800, Xiang Xiao wrote:

> > +	/* append the message after '\n' to the buffer */
> 
> > +	if (copied != 0) {

Missed comment

if (copied)

> > +	}

-- 
With Best Regards,
Andy Shevchenko


