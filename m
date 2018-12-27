Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5661FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DDC214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeL0Hob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:44:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:64200 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeL0Hob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:44:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 23:44:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,404,1539673200"; 
   d="scan'208";a="110237756"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga007.fm.intel.com with ESMTP; 26 Dec 2018 23:44:28 -0800
Subject: Re: [PATCH V4 1/3] mmc: sdhci: add support for using external DMA
 devices
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
 <1544519572-21921-2-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0e683aef-383c-8200-0059-44a9abb654b8@intel.com>
Date:   Thu, 27 Dec 2018 09:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1544519572-21921-2-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 11:12 AM, Chunyan Zhang wrote:
> Some standard SD host controllers can support both external dma
> controllers as well as ADMA/SDMA in which the SD host controller
> acts as DMA master. TI's omap controller is the case as an example.
> 
> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine, meaning that custom code is
> needed for any systems that use an external DMA controller with SDHCI.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

FYI, I am waiting on successful testing before reviewing these patches again.
