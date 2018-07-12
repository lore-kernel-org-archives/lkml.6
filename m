Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CC5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73B020C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73B020C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbeGLCMN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:12:13 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:40921
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732852AbeGLCMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:12:12 -0400
X-ASG-Debug-ID: 1531361090-093b7e2c7c6d2e0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net (localhost [10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id OCdklDFaBdefsBzV (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 12 Jul 2018 10:04:50 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.847.32; Thu, 12 Jul 2018 10:04:42 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.0847.030; Thu, 12 Jul 2018 10:04:42 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "olof@lixom.net" <olof@lixom.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] iommu: Add config option to set passthrough as
 default
Thread-Topic: [PATCH 1/2] iommu: Add config option to set passthrough as
 default
X-ASG-Orig-Subj: Re: [PATCH 1/2] iommu: Add config option to set passthrough as
 default
Thread-Index: AQHUGVos72k0FiF+U0exr2V+rYPox6SKUI0A
Date:   Thu, 12 Jul 2018 02:04:41 +0000
Message-ID: <1531361076.3757.5.camel@hxt-semitech.com>
References: <20180711205936.18614-1-olof@lixom.net>
In-Reply-To: <20180711205936.18614-1-olof@lixom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.32]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <2EE053A278DDBF47A54CBBFD73706F5C@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1531361090
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5027 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.53461
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Olof,

Tired of changing command line. I like this patch.

Thanks.
Shunyong. 

On Wed, 2018-07-11 at 13:59 -0700, Olof Johansson wrote:
> This allows the default behavior to be controlled by a kernel config
> option instead of changing the commandline for the kernel to include
> "iommu.passthrough=on" on machines where this is desired.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/iommu/Kconfig | 10 ++++++++++
>  drivers/iommu/iommu.c |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 689ffe538370..a9bb1a5b5e43 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -60,6 +60,16 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>  
>  endmenu
>  
> +config IOMMU_DEFAULT_PASSTHROUGH
> +	bool "IOMMU passthrough by default"
> +	depends on IOMMU_API
> +        help
> +	  Enable passthrough by default (removing the need to pass
> in
> +	  iommu.passthrough=on through command line). If this is
> enabled,
> +	  you can still disable with iommu.passthrough=off
> +
> +	  If unsure, say N here.
> +
>  config IOMMU_IOVA
>  	tristate
>  
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 63b37563db7e..ab8fc54467e0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -36,7 +36,11 @@
>  
>  static struct kset *iommu_group_kset;
>  static DEFINE_IDA(iommu_group_ida);
> +#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> +static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
> +#else
>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
> +#endif
>  
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
