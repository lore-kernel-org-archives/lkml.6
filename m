Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247E4C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B763A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B763A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeLMBvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:51:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45885 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbeLMBvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:51:51 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 21B6CEFB9DEB8;
        Thu, 13 Dec 2018 09:51:48 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 13 Dec
 2018 09:51:40 +0800
Subject: Re: [PATCH] staging: erofs: Add a blank line after declarations
To:     Sungkyung Kim <jotun9935@gmail.com>
CC:     <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>
References: <20181212155023.45294-1-jotun9935@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <9d1280a1-d4bd-d64d-20ff-1468408f9607@huawei.com>
Date:   Thu, 13 Dec 2018 09:51:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181212155023.45294-1-jotun9935@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sungkyung,

On 2018/12/12 23:50, Sungkyung Kim wrote:
> Fix a warning from checkpathch.pl: 'Missing a blank line after
> declarations'
> 
> Signed-off-by: Sungkyung Kim <jotun9935@gmail.com>
> ---
>  drivers/staging/erofs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index 04c61a9d7b76..82b6ad5badff 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -278,6 +278,7 @@ struct inode *erofs_iget(struct super_block *sb,
>  	if (inode->i_state & I_NEW) {
>  		int err;
>  		struct erofs_vnode *vi = EROFS_V(inode);
> +

Thanks for your patch, is there a only one 'Missing a blank line after declarations' in erofs?

If not, could you have time check the other files? That is my personal thought, and
I cc-ed the staging mailing list as well.

Thanks,
Gao Xiang

>  		vi->nid = nid;
>  
>  		err = fill_inode(inode, isdir);
> 
