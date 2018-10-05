Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A97C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B073520875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B073520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeJEPK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:10:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:50176 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbeJEPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:10:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 01:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,343,1534834800"; 
   d="scan'208";a="97637246"
Received: from kromanow-mobl5.ger.corp.intel.com (HELO [10.252.4.128]) ([10.252.4.128])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 01:13:17 -0700
Subject: Re: [PATCH] drm/gvt : fix error message typo
To:     Peng Hao <penghao122@sina.com.cn>, zhenyuw@linux.intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        airlied@linux.ie
Cc:     intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
References: <1538669074-26012-1-git-send-email-penghao122@sina.com.cn>
From:   Zhi Wang <zhi.a.wang@intel.com>
Message-ID: <659e1b3d-8b17-e380-4196-340596ec9740@intel.com>
Date:   Fri, 5 Oct 2018 04:13:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538669074-26012-1-git-send-email-penghao122@sina.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Thanks for the patches. :) Several places needs to be improved:

1. The prefix of the patch should be: "drm/i915/gvt:".
2. You can just cc the maintainers of gvt since the gvt is a sub-module 
of i915.
3. Better refine the tittle of the patch and also the commit message. An 
informative title and commit message would be more friendly to people 
who reading this later, even it's only a small typo. :)

Again. Thanks for the patch. :) I will fix that for you and commit it, 
so you don't need to send it again.

Thanks,
Zhi.

On 10/04/18 12:04, Peng Hao wrote:
> 
> From: Peng Hao <peng.hao2@zte.com.cn>
> 
> gvt_err message typo.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>   drivers/gpu/drm/i915/gvt/gvt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
> index 46c8b72..31d6809 100644
> --- a/drivers/gpu/drm/i915/gvt/gvt.c
> +++ b/drivers/gpu/drm/i915/gvt/gvt.c
> @@ -438,7 +438,7 @@ int intel_gvt_init_device(struct drm_i915_private *dev_priv)
>   
>   	ret = intel_gvt_debugfs_init(gvt);
>   	if (ret)
> -		gvt_err("debugfs registeration failed, go on.\n");
> +		gvt_err("debugfs registration failed, go on.\n");
>   
>   	gvt_dbg_core("gvt device initialization is done\n");
>   	dev_priv->gvt = gvt;
> 
