Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE00C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E88208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfAJRcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:32:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:57684 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfAJRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:32:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 09:32:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="113734468"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.152])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2019 09:32:50 -0800
Date:   Thu, 10 Jan 2019 19:32:49 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tweek@google.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm/eventlog/tpm1: Simplify walking over *pos
 measurements
Message-ID: <20190110173249.GE6589@linux.intel.com>
References: <1546759399-45360-1-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546759399-45360-1-git-send-email-zhang.jia@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 03:23:18PM +0800, Jia Zhang wrote:
> The sanity check would be easier, especially for the first read
> of binary_bios_measurements from the beginning.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

The cover letter is missing and commit messages do not describe
what kind of change the commit does.

/Jarkko
