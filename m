Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeCGMv2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:51:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:8327 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbeCGMvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:51:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,435,1515484800";
   d="scan'208";a="39923299"
Message-ID: <1520427080.10722.451.camel@linux.intel.com>
Subject: Re: [PATCH v7] mmc: Export host capabilities to debugfs.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, adrian.hunter@intel.com,
        shawn.lin@rock-chips.com, avri.altman@wdc.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir_Zapolskiy@mentor.com
Date: Wed, 07 Mar 2018 14:51:20 +0200
In-Reply-To: <1520426462-3039-1-git-send-email-harish_kandiga@mentor.com>
References: <1520426462-3039-1-git-send-email-harish_kandiga@mentor.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 18:11 +0530, Harish Jenny K N wrote:
> This patch exports the host capabilities to debugfs
> 
> This idea of sharing host capabilities over debugfs
> came up from Abbas Raza <Abbas_Raza@mentor.com>
> Earlier discussions:
> https://lkml.org/lkml/2018/3/5/357
> https://www.spinics.net/lists/linux-mmc/msg48219.html
> 

Please, don't be so fast with new versions.

Consider my reply to previous version.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
