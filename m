Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8ECC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE9321480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE9321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391120AbeHPNzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:55:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:4458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeHPNzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:55:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 03:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,246,1531810800"; 
   d="scan'208";a="254576890"
Received: from mylly.fi.intel.com (HELO [10.237.72.67]) ([10.237.72.67])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2018 03:57:57 -0700
Subject: Re: [PATCH v4 0/7] Add support for MSCC Ocelot i2c
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <7eb26433-9346-db9a-6d76-5c1da8b9baa3@linux.intel.com>
Date:   Thu, 16 Aug 2018 13:58:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 11:45 AM, Alexandre Belloni wrote:
> Hello,
> 
> Because the designware IP was not able to handle the SDA hold time before
> version 1.11a, MSCC has its own implementation. Add support for it and then add
> i2c on ocelot boards.
> 
> I would expect patches 1 to 5 to go through the i2c tree and 6-7 through
> the mips tree once patch 4 has been reviewed by the DT maintainers.
> 
For the patches 1-3 and 5/7 that touch i2c-designware:

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
