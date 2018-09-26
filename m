Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D37C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2772151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2772151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeI0Ass (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:48:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:38812 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbeI0Asr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:48:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 11:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="92136934"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 26 Sep 2018 11:34:30 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Sep 2018 21:34:29 +0300
Date:   Wed, 26 Sep 2018 21:34:29 +0300
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: intel-wmi-thunderbolt: Add dynamic
 debugging
Message-ID: <20180926183429.GP2664@lahna.fi.intel.com>
References: <1537978258-2907-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537978258-2907-1-git-send-email-mario.limonciello@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:10:58AM -0500, Mario Limonciello wrote:
> Some users have been reporting issues with thunderbolt being turned off
> before fully initialized.  This is suspected to be caused by userspace
> turning off the Thunderbolt controller using intel-wmi-thunderbolt
> prematurely.
> 
> Details are available here:
> https://bugzilla.kernel.org/show_bug.cgi?id=201227
> https://bugzilla.kernel.org/show_bug.cgi?id=199631
> 
> Userspace has already made some mitigiations for this situation:
                                  ^^^^^^^^^^^^
mitigations?

> https://github.com/hughsie/fwupd/commit/ef6f1d76983c9b66
> https://github.com/hughsie/fwupd/commit/c07ce5b4889a5384
> 
> To allow easier debugging of this situation add output that can be turned
> on with dynamic debugging to better root cause this problem.
> 
> Suggested-by: Mika Westerberg <mika.westerberg@intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
