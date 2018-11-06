Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66D6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6D920862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6D920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbeKGBTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:19:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:44092 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388346AbeKGBTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:19:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 07:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="106348844"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2018 07:53:48 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gK3fn-0005UE-HI; Tue, 06 Nov 2018 17:53:47 +0200
Date:   Tue, 6 Nov 2018 17:53:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Message-ID: <20181106155347.GC10650@smile.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com>
 <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
 <20181106144037.GD13048@kuha.fi.intel.com>
 <20181106145537.GB10650@smile.fi.intel.com>
 <20181106150503.GE13048@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106150503.GE13048@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:05:03PM +0200, Heikki Krogerus wrote:

> Maybe it would be best to just read the "name" device property in
> fwnode_name() and not have of_fwnode_name at all.

If it's a mandatory property or somehow its presence is guaranteed, it would work.

-- 
With Best Regards,
Andy Shevchenko


