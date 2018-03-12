Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeCLOUo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:20:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:39208 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbeCLOUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:20:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="210867707"
Message-ID: <1520864436.10722.592.camel@linux.intel.com>
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
Date: Mon, 12 Mar 2018 16:20:36 +0200
In-Reply-To: <9923a92c-f76d-ad87-a648-da212b6b39de@mentor.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
         <1520849262.10722.582.camel@linux.intel.com>
         <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
         <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
         <DM5PR04MB10859F389CA2D1F2370C02CFFCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
         <329d521d-1776-43ee-2f0e-e9690c29a693@mentor.com>
         <1520859807.10722.591.camel@linux.intel.com>
         <5e038945-a09c-5c64-2152-5d2783a249ec@mentor.com>
         <9923a92c-f76d-ad87-a648-da212b6b39de@mentor.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 19:37 +0530, Harish Jenny K N wrote:


> Can anyone please respond to my previous request?
> 
> > Before sending new patch , I would like to inform that I have been
> > sending this patch with the following checkpatch warning, just to
> > keep it same as other usages of debugfs_create_file in the
> > drivers/mmc/core/debugfs.c file.
> > WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUSR' are not
> > preferred. Consider using octal permissions '0400'.
> > Do I need to address this or keep it same as S_IRUSR ?

Please, do.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
