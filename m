Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeB0LUp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:20:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:36422 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752649AbeB0LUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:20:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,400,1515484800";
   d="scan'208";a="207398174"
Message-ID: <1519730441.10722.216.camel@linux.intel.com>
Subject: test case against union aliasing
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Lukas Wunner <lukas@wunner.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 27 Feb 2018 13:20:41 +0200
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It seems we have some code in kernel which utilizes (rightlessly for
now) union aliasing.

So, can we create a test case against such? (Three steps: a) replace
union by struct keyword in data type in question, b) compile, c) run in
Qemu with proper functional test)

Does it make any sense?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
