Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A1FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF98C214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF98C214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbeHGN7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:59:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:28847 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeHGN7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:59:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 04:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="252003003"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2018 04:45:18 -0700
Message-ID: <af71656fda0f94e77a136bd50381713020660638.camel@linux.intel.com>
Subject: Re: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
Date:   Tue, 07 Aug 2018 14:45:17 +0300
In-Reply-To: <9e17dfca-901b-79c9-b562-4f893d7ae44b@redhat.com>
References: <20180807080539.17811-1-hdegoede@redhat.com>
         <20180807080539.17811-5-hdegoede@redhat.com>
         <20180807112701.5iukqa6m5atf22fw@ninjato>
         <9e17dfca-901b-79c9-b562-4f893d7ae44b@redhat.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 13:33 +0200, Hans de Goede wrote:
> Hi,
> 
> On 07-08-18 13:27, Wolfram Sang wrote:
> > Hi Hans,
> > 
> > > +I2C MULTI INSTANTIATE DRIVER

In the case below, I think it would be slightly better to mention ACPI
here, something like

ACPI I2C ...

Otherwise it sounds a bit confusing why it's in PDx86.

> > > +M:	Hans de Goede <hdegoede@redhat.com>
> > > +L:	linux-i2c@vger.kernel.org
> > 
> > Since this driver is about FW bugs, I wonder if
> > platform-driver-x86@vger.kernel.org isn't the better list here?
> 
> Ok, fixed for v4.
> 
> > > +S:	Maintained
> > > +F:	drivers/drivers/platform/x86/i2c-multi-instantiate.c
> > 
> > I2C parts of the rest looks good from a glimpse...
> 
> Thanks.
> 
> Regards,
> 
> Hans

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
