Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44023C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA762147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfBTIwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:52:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:7827 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfBTIwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:52:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 00:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,390,1544515200"; 
   d="scan'208";a="320511034"
Received: from ncanderx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.148])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2019 00:52:32 -0800
Date:   Wed, 20 Feb 2019 10:52:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 -next] tpm: Fix the type of the return value in
 calc_tpm2_event_size()
Message-ID: <20190220085231.GB6253@linux.intel.com>
References: <20190220082538.26260-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220082538.26260-1-yuehaibing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:25:38PM +0800, Yue Haibing wrote:
> calc_tpm2_event_size() has an invalid signature because
> it returns a 'size_t' where as its signature says that
> it returns 'int'.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v3: fix My real name and cc stable
> v2: modify patch title and commit message as Jarkko suggested

Thanks,

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
