Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeCTJTX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:19:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:52338 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeCTJTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:19:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,334,1517904000";
   d="scan'208";a="35292429"
Subject: Re: [PATCH 0/3] mmc: add support for sdhci 4.0
To: Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2291348c-7338-f335-88b8-10dc308e7f22@intel.com>
Date: Tue, 20 Mar 2018 11:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/18 10:36, Chunyan Zhang wrote:
>>From the SD host controller version 4.0 on, SDHCI implementation either
> is version 3 compatible or version 4 mode. This patch-set covers those
> changes which are common for SDHCI 4.0 version, regardless of whether
> they are used with SD or eMMC storage devices.

Why use v4 mode?

What driver is using v4 mode?  Can you also post those changes?

Are you planning on adding UHS-II support also?

> 
> Chunyan Zhang (3):
>   mmc: sdhci: add sd host v4 mode
>   mmc: sdhci: made changes for System Address register of SDMA
>   mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
> 
>  drivers/mmc/host/sdhci.c | 66 +++++++++++++++++++++++++++++++++++++-----------
>  drivers/mmc/host/sdhci.h | 29 +++++++++++++++++----
>  2 files changed, 75 insertions(+), 20 deletions(-)
> 
