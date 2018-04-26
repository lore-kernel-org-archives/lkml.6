Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbeDZJ5u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:57:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:11462 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754277AbeDZJ5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:57:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="37188281"
Subject: Re: [RESEND PATCH v4.9, 1/1] mmc: sdhci-dwc-mshc-pci: synopsys dwc
 mshc support
To: Prabu Thangamuthu <Prabu.T@synopsys.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manjunath M Bettegowda <Manjunath.MB@synopsys.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <705D14B1C7978B40A723277C067CEDE2010A99DD80@IN01WEMBXB.internal.synopsys.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2f51bbdb-6d1e-8e8e-d6d5-96270a47dd56@intel.com>
Date: Thu, 26 Apr 2018 12:56:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <705D14B1C7978B40A723277C067CEDE2010A99DD80@IN01WEMBXB.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/18 18:47, Prabu Thangamuthu wrote:
> This patch is intended for linux-4.9.y branch.

Do you mean linux stable?  That means you need to follow stable kernel rules:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst
