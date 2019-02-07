Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EFA21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBGVTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:19:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:29625 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfBGVTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:19:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 13:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="142493359"
Received: from mwesterb-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.154])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2019 13:19:17 -0800
Date:   Thu, 7 Feb 2019 23:19:16 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Fix some name collisions with drivers/char/tpm.h
Message-ID: <20190207211916.GB23906@linux.intel.com>
References: <20190205091400.29019-1-jarkko.sakkinen@linux.intel.com>
 <20190207163159.A30D12190A@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207163159.A30D12190A@mail.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 04:31:58PM +0000, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: bf38b8710892 tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy).
> 
> The bot has tested the following trees: v4.20.6, v4.19.19, v4.14.97, v4.9.154, v4.4.172.
> 
> v4.20.6: Build OK!
> v4.19.19: Build OK!
> v4.14.97: Build OK!
> v4.9.154: Build OK!
> v4.4.172: Failed to apply! Possible dependencies:
>     036bb38ffb3e ("tpm_tis: Ensure interrupts are disabled when the driver starts")
>     23d06ff700f5 ("tpm: drop tpm_atmel specific fields from tpm_vendor_specific")
>     25112048cd59 ("tpm: rework tpm_get_timeouts()")
>     4d627e672bd0 ("tpm_tis: Do not fall back to a hardcoded address for TPM2")
>     4eea703caaac ("tpm: drop 'iobase' from struct tpm_vendor_specific")
>     51dd43dff74b ("tpm_tis: Use devm_ioremap_resource")
>     55a889c2cb13 ("tpm_crb: Use the common ACPI definition of struct acpi_tpm2")
>     56671c893e0e ("tpm: drop 'locality' from struct tpm_vendor_specific")
>     570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")
>     7ab4032fa579 ("tpm_tis: Get rid of the duplicate IRQ probing code")
>     d30b8e4f68ef ("tpm: cleanup tpm_tis_remove()")
>     d4956524f1b0 ("tpm: drop manufacturer_id from struct tpm_vendor_specific")
>     e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
>     ee1779840d09 ("tpm: drop 'base' from struct tpm_vendor_specific")
>     ef7b81dc7864 ("tpm_tis: Disable interrupt auto probing on a per-device basis")
> 
> 
> How should we proceed with this patch?

I'll look into this next week.

/Jarkko
