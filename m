Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CE8C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DC521531
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DC521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeH0DOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 23:14:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:47459 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbeH0DOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 23:14:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2018 16:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,292,1531810800"; 
   d="scan'208";a="75784843"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2018 16:30:32 -0700
Date:   Mon, 27 Aug 2018 07:18:23 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: fme-mgr: fix spelling mistake "Invaild" ->
 "Invalid"
Message-ID: <20180826231823.GA7561@hao-dev>
References: <20180826221355.12661-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826221355.12661-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 11:13:55PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err message.

This patch is duplicated. This issue is covered by your previous patch.

https://marc.info/?l=linux-fpga&m=153202583007071&w=2

Thanks
Hao

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/fpga/dfl-fme-mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b5ef405b6d88..9f045d058cfd 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
>  		}
>  
>  		if (count < 4) {
> -			dev_err(dev, "Invaild PR bitstream size\n");
> +			dev_err(dev, "Invalid PR bitstream size\n");
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
