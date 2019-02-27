Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64186C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA57218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfB0BNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:13:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728766AbfB0BNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:13:06 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CCA41532D998CB7E8C94;
        Wed, 27 Feb 2019 09:13:03 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 09:12:57 +0800
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jian Shen <shenjian15@huawei.com>,
        "Peng Li" <lipeng321@huawei.com>
References: <20190225190034.0cad4e3d@canb.auug.org.au>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <0788736a-dfba-edd1-f62d-2205d6702f4b@huawei.com>
Date:   Wed, 27 Feb 2019 09:12:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190225190034.0cad4e3d@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen & David,

It is my mistake, so sorry about this. There is a redundant "net: hns3: 
" in the fixes tag.

How could I fix it?

Thanks.

On 2019/2/25 16:00, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    a638b1d8cc87 ("net: hns3: fix get VF RSS issue")
> 
> Fixes tag
> 
>    Fixes: 374ad291762a ("net: hns3: net: hns3: Add RSS general configuration support for VF")
> 
> has these problem(s):
> 
>    - Subject does not match target commit subject
>      Just use
> 	git log -1 --format='Fixes: %h (%s)'
> 

