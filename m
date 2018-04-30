Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeD3HXt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:23:49 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50306 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeD3HXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:23:47 -0400
From: Prabu Thangamuthu <Prabu.T@synopsys.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manjunath M Bettegowda <Manjunath.MB@synopsys.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [RESEND PATCH v4.9, 1/1] mmc: sdhci-dwc-mshc-pci: synopsys dwc
 mshc support
Thread-Topic: [RESEND PATCH v4.9, 1/1] mmc: sdhci-dwc-mshc-pci: synopsys dwc
 mshc support
Thread-Index: AdPSdYPrTNaVoYJwQ8OAmsG+eDQxSQ==
Date: Mon, 30 Apr 2018 07:23:41 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A9AAB68@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2010A99DD80@IN01WEMBXB.internal.synopsys.com>
 <2f51bbdb-6d1e-8e8e-d6d5-96270a47dd56@intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.235]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3U7Nt2H031456

Hi Adrian,

Yes, this patch was meant for linux stable. Thank you pointing me the
corresponding rules.

We are planning to port our driver to mainline. We will submit the patch
for mainline when it's ready.

Thanks,
Prabu

On 4/26/2018 3:27 PM, Adrian Hunter wrote:
> On 12/04/18 18:47, Prabu Thangamuthu wrote:
>> This patch is intended for linux-4.9.y branch.
> Do you mean linux stable?  That means you need to follow stable kernel rules:
>
> 	https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git_tree_Documentation_process_stable-2Dkernel-2Drules.rst&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=Hr8lNh6yuL8thqr0BTH-LcNHR7jkWxQSt_H5NZCoTxI&m=cNM2NjAiX5xnDfckYjMch_0XeHrBjgCHYbcQHjkmVn8&s=D44hBUjJ0oaWFI_OdPQkcDHl5Ou8XJR7tMYW-H3TOhk&e=
>
