Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4105C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B03252F4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 02:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm+oTQVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B03252F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeGACXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 22:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeGACXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 22:23:16 -0400
Received: from [192.168.0.101] (unknown [180.111.132.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1464252F2;
        Sun,  1 Jul 2018 02:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530411796;
        bh=cL8PX9a8apU2eRGcC2L+oUSDY0DOkltVwXz7yHL7SgI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tm+oTQVtgcRxrjz99XPgaAiA4No7Tcam/3fWUyP+/53CLsss+VcabWRsNkltnT8Z4
         kYsV7rkLgRLDuZ5XdxWaI9qto2BJUJyJR/3L00KphaU6gXXOawQzvfqK6fAOUYOthP
         Jkb3pDP6jrf7UxS/L8MsevkS6D3KRyKySBFUyDYI=
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid the global name 'fault_name'
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5c3189ac-8dcf-391c-df0a-01f3a7bb4363@kernel.org>
Date:   Sun, 1 Jul 2018 10:23:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/30 23:57, Gao Xiang wrote:
> Non-prefix global name 'fault_name' will pollute global
> namespace, fix it.
> 
> Refer to:
> https://lists.01.org/pipermail/kbuild-all/2018-June/049660.html
> 
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <yuchao0@huawei.com>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
