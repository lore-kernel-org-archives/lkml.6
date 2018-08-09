Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939F421AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939F421AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbeHILxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:53:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:53887 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbeHILxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:53:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 02:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,214,1531810800"; 
   d="scan'208";a="75107867"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 09 Aug 2018 02:29:42 -0700
Message-ID: <92b206fcb5af4ad809e6f2b103a21bce9f9af706.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/6] i2c: designware: use generic table matching
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Date:   Thu, 09 Aug 2018 12:29:41 +0300
In-Reply-To: <20180808202210.qkocl4hckqla7exe@ninjato>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
         <20180806185412.7210-2-alexandre.belloni@bootlin.com>
         <20180808202210.qkocl4hckqla7exe@ninjato>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 22:22 +0200, Wolfram Sang wrote:
> On Mon, Aug 06, 2018 at 08:54:07PM +0200, Alexandre Belloni wrote:
> > Switch to device_get_match_data in probe to match the device
> > specific data
> > instead of using the acpi specific function.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Andy, you happy with this patch?
> 

Yes, yes.
If you need my formal tag, here it is

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

