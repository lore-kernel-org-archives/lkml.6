Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88DEC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADED20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfAUMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:54:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:36922 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbfAUMyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:54:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 04:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="268730838"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2019 04:54:30 -0800
Subject: Re: [PATCH V9 3/3] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, jonathanh@nvidia.com,
        ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
 <1547579032-18314-3-git-send-email-skomatineni@nvidia.com>
 <20190121104432.GE16756@ulmo>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <44e837df-f1c1-b55c-3761-ef699147171f@intel.com>
Date:   Mon, 21 Jan 2019 14:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121104432.GE16756@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/19 12:44 PM, Thierry Reding wrote:
> On Tue, Jan 15, 2019 at 11:03:52AM -0800, Sowjanya Komatineni wrote:
>> This patch adds HW Command Queue for supported Tegra SDMMC
>> controllers.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  drivers/mmc/host/Kconfig       |   1 +
>>  drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++++++--
>>  drivers/mmc/host/sdhci.c       |   9 +++-
>>  drivers/mmc/host/sdhci.h       |   2 +
>>  4 files changed, 124 insertions(+), 5 deletions(-)
> 
> Looks good to me. It might be worth splitting off the SDHCI core changes
> into a separate patch, but that's for Adrian and Ulf to decide. From a

Yes that would be better.  Otherwise seems fine.

> Tegra point of view:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

