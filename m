Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeCLKHu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:07:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:57622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932449AbeCLKHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:07:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="23562720"
Message-ID: <1520849262.10722.582.camel@linux.intel.com>
Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, adrian.hunter@intel.com,
        shawn.lin@rock-chips.com, avri.altman@wdc.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir_Zapolskiy@mentor.com
Date: Mon, 12 Mar 2018 12:07:42 +0200
In-Reply-To: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 10:01 +0530, Harish Jenny K N wrote:
> This patch exports the host capabilities to debugfs
> 
> This idea of sharing host capabilities over debugfs
> came up from Abbas Raza <Abbas_Raza@mentor.com>
> Earlier discussions:
> https://lkml.org/lkml/2018/3/5/357
> https://www.spinics.net/lists/linux-mmc/msg48219.html
> 

Address below minors and, FWIW, take mine

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +	for_each_set_bit(bit, (const unsigned long *)&caps,
> BITS_PER_LONG)

> +	for_each_set_bit(bit, (const unsigned long *)&caps2,
> BITS_PER_LONG)

Explicit casting is not needed anymore in both cases.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
