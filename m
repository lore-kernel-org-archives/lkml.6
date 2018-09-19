Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E760FECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9188A2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0hyvcB61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9188A2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeISVGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731661AbeISVGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:06:05 -0400
Received: from [192.168.0.101] (unknown [117.62.222.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B37420877;
        Wed, 19 Sep 2018 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537370859;
        bh=oLuaHCmRnHFZ8aGt8dKUr54DL9htfgslh3xYVwtpT3c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0hyvcB61nh4hoe2k9GyD7UJ9/epVbQcalIUKqnelsdhy6QgK93Kz5ZuhIVopwIL7j
         1N37JthbaE/tyuhSWNO5sy8i/gUEPfczz2QY48+zFlnxiTA9Tgsj8LeXv6qvMbGcqR
         VGDz9S4bPR2sHI1xwh1gt7cP8/Ks+7vziYhwbi5A=
Subject: Re: [PATCH 5/6] staging: erofs: add some comments for xattr subsystem
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, devel@driverdev.osuosl.org
Cc:     Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
 <1537336150-90604-5-git-send-email-gaoxiang25@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <27fe857b-6f9a-6944-cc2d-750aca0fdb07@kernel.org>
Date:   Wed, 19 Sep 2018 23:27:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537336150-90604-5-git-send-email-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 13:49, Gao Xiang wrote:
> As Dan Carpenter pointed out, it is better to document what
> return values of these callbacks in `struct xattr_iter_handlers'
> mean and why it->ofs is increased regardless of success or
> failure in `xattr_foreach'.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
