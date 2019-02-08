Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BA4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDB621917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBHIdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:33:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:8893 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfBHIdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:33:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 00:33:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="141720870"
Received: from mylly.fi.intel.com (HELO [10.237.72.62]) ([10.237.72.62])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2019 00:33:02 -0800
Subject: Re: linux-next: manual merge of the mfd tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20190208133737.7e754345@canb.auug.org.au>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <e5610b74-043e-07e0-c024-4513f964e8ae@linux.intel.com>
Date:   Fri, 8 Feb 2019 10:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208133737.7e754345@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 4:37 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mfd tree got a conflict in:
> 
>    drivers/mfd/Kconfig
> 
> between commit:
> 
>    9baddb61dfec ("mfd: Fix unmet dependency warning for MFD_TPS68470")
> 
> from Linus' tree and commit:
> 
>    09fdc9857712 ("mfd: Kconfig: Fix I2C_DESIGNWARE_PLATFORM dependencies")
> 
> from the mfd tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
Thanks, that's is the right fix for the conflict.

-- 
Jarkko
