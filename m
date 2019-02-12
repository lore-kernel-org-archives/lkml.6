Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED222C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFC3222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfBLUuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:50:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:12826 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfBLUuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:50:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 12:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="299229573"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2019 12:50:11 -0800
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
To:     "Ooi, Joyce" <joyce.ooi@intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        See Chin Liang <chin.liang.see@intel.com>
References: <1549988692-4124-1-git-send-email-joyce.ooi@intel.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <0c93846a-48ab-5cde-6d27-291606dd8c31@linux.intel.com>
Date:   Tue, 12 Feb 2019 14:52:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549988692-4124-1-git-send-email-joyce.ooi@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joyce,

On 2/12/19 10:24 AM, Ooi, Joyce wrote:
> As there is restriction to access to EMAC System Manager registers in
> the kernel for Intel Stratix10, the use of SMC calls are required and
> added in dwmac-socfpga driver.
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>

<snip>

I have a pending patchset[1] that addresses this but can be used by 
other drivers as well.

[1] https://patchwork.kernel.org/cover/10612891/

