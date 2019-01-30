Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CD3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6682087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfA3P2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:28:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbfA3P2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:28:35 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4AA0473C44F397D3BFC8;
        Wed, 30 Jan 2019 23:28:31 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 30 Jan
 2019 23:28:21 +0800
Subject: Re: [PATCH] staging: erofs: keep corrupted fs from crashing kernel in
 erofs_namei()
To:     Sasha Levin <sashal@kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20190129155540.17473-1-gaoxiang25@huawei.com>
 <20190130144647.525BA218AC@mail.kernel.org>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <429f1337-76e4-cc2a-63e0-62a091f1dcf4@huawei.com>
Date:   Wed, 30 Jan 2019 23:28:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190130144647.525BA218AC@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

I will send v4.19 patch independently to the stable mailing list
after It gets carefully reviewed by Chao (and Al Viro if it is possible...)

Thanks,
Gao Xiang

On 2019/1/30 22:46, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: d72d1ce60174 staging: erofs: add namei functions.
> 
> The bot has tested the following trees: v4.20.5, v4.19.18.
> 
> v4.20.5: Build OK!
> v4.19.18: Failed to apply! Possible dependencies:
>     6e78901a9f23 ("staging: erofs: separate erofs_get_meta_page")
>     7dd68b147d60 ("staging: erofs: use explicit unsigned int type")
>     8be31270362b ("staging: erofs: introduce erofs_grab_bio")
>     ab47dd2b0819 ("staging: erofs: cleanup z_erofs_vle_work_{lookup, register}")
> 
> 
> How should we proceed with this patch?
> 
> --
> Thanks,
> Sasha
> 
