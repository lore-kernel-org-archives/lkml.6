Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FBBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A620871
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129A620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbeGFI7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:59:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37043 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753467AbeGFI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:59:33 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="41918616"
Received: from localhost (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Jul 2018 16:59:31 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id BAE7D4B34D40;
        Fri,  6 Jul 2018 16:59:30 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Fri, 6 Jul 2018 16:59:32 +0800
Subject: Re: [PATCH] kbuild: document the KBUILD_KCONFIG env. variable
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     LKML <linux-kernel@vger.kernel.org>
References: <70d08f42-27e4-ccc2-00f6-266568123d8c@infradead.org>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <a8a9fa55-3dcc-f13f-ad4a-6f7ee2c23aa3@cn.fujitsu.com>
Date:   Fri, 6 Jul 2018 16:58:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <70d08f42-27e4-ccc2-00f6-266568123d8c@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: BAE7D4B34D40.A944B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2018 10:47 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Add usage info for the Kbuild environment variable KBUILD_KCONFIG.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

I can recall this variable does take me a little while to find out its
meaning during my earliest time in kbuild, so,

Acked-by: Cao jin <caoj.fnst@cn.fujitsu.com>

-- 
Sincerely,
Cao jin

> ---
>  Documentation/kbuild/kbuild.txt |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- lnx-418-rc3.orig/Documentation/kbuild/kbuild.txt
> +++ lnx-418-rc3/Documentation/kbuild/kbuild.txt
> @@ -50,6 +50,11 @@ LDFLAGS_MODULE
>  --------------------------------------------------
>  Additional options used for $(LD) when linking modules.
>  
> +KBUILD_KCONFIG
> +--------------------------------------------------
> +Set the top-level Kconfig file to the value of this environment
> +variable.  The default name is "Kconfig".
> +
>  KBUILD_VERBOSE
>  --------------------------------------------------
>  Set the kbuild verbosity. Can be assigned same values as "V=...".
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 




