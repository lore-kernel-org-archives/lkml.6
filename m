Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ABCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142A520663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142A520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeK0Btg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:49:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:1210 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbeK0Bt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:49:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 06:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="103306597"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2018 06:55:05 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRIHw-0001wT-4v; Mon, 26 Nov 2018 16:55:04 +0200
Date:   Mon, 26 Nov 2018 16:55:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/15] i2c-multi-instantiate: Adapt for INT3515 and
 alike
Message-ID: <20181126145504.GL10650@smile.fi.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <24f96a15-6b57-c19d-b77d-fdc6c11fddc9@redhat.com>
 <cdb902c7-324c-3f19-6caa-ff78132c593d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb902c7-324c-3f19-6caa-ff78132c593d@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 01:00:07PM +0100, Hans de Goede wrote:
> On 21-11-18 12:27, Hans de Goede wrote:

> > Patches 1-5, 7-13 and 15 are: >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks!

> 
> Correction, I also have some small remarks to patch 9:
> 
> [PATCH v1 09/15] platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
> 
> Which will need to be addressed before you can add my Reviewed-by.

Will be addressed for v2.

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


