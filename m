Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933395AbeD0P0w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:26:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:28216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933213AbeD0P0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:26:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,335,1520924400";
   d="scan'208";a="49644755"
From: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
To: "Brown, Len" <len.brown@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>
CC: "dsmythies@telus.net" <dsmythies@telus.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH][v6] tools/power turbostat: if --iterations, print for
 specific count of iterations
Thread-Topic: [PATCH][v6] tools/power turbostat: if --iterations, print for
 specific count of iterations
Thread-Index: AQHT3Pabs2JmR3pdNEmmYn6SM0Ba86QUrZyA
Date: Fri, 27 Apr 2018 15:26:46 +0000
Message-ID: <1524842805.28779.46.camel@intel.com>
References: <1524703263-22303-1-git-send-email-yu.c.chen@intel.com>
In-Reply-To: <1524703263-22303-1-git-send-email-yu.c.chen@intel.com>
Reply-To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.68.39]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CDF9A9D8FBEEB41A734019B5DCC289C@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3RFQxUI025406

On Thu, 2018-04-26 at 08:41 +0800, Chen Yu wrote:
> There's a use case during test to only print specific round of iterations
> if --iterations is specified, for example, with this patch applied:
> 
> turbostat -i 5 -r 4
> will capture 4 samples with 5 seconds interval.
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Cc: Doug Smythies <dsmythies@telus.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
Best Regards,
Artem Bityutskiy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
