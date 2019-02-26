Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FA2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513EC217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfBZODj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:03:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:52569 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfBZODj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:03:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 06:03:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,415,1544515200"; 
   d="scan'208";a="322232235"
Received: from unknown (HELO jsakkine-mobl1) ([10.249.254.142])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2019 06:03:35 -0800
Message-ID: <61db64b184a6b409248f5debb8549d6011a8cdac.camel@linux.intel.com>
Subject: Re: [PATCH V4 0/4] Add support for TCG2 event logs on EFI systems
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, roberto.sassu@huawei.com,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com
Date:   Tue, 26 Feb 2019 16:03:33 +0200
In-Reply-To: <20190222202606.160816-1-matthewgarrett@google.com>
References: <20190222202606.160816-1-matthewgarrett@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-22 at 12:26 -0800, Matthew Garrett wrote:
> This patchset adds support for obtaining the TCG2 format event log on
> EFI systems, along with support for copying up the final event log to
> capture events that occur after the primary log is obtained. V4 is
> identical to previous versions, except for tpm_read_log_efi() in patch 3
> being reworked to reduce nesting.

Looks good.

I'll re-try testing latter part of this weke.

/Jarkko

