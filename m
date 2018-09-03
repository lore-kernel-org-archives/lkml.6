Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B0FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBEA20841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBEA20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeICGRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:17:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725762AbeICGRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:17:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 664194E8BCBE1;
        Mon,  3 Sep 2018 09:59:44 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Mon, 3 Sep 2018
 09:59:44 +0800
Subject: Re: [PATCH 2/6] staging: erofs: formatting fix to NULL comparison
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Gao Xiang <hsiangkao@aol.com>,
        Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        <ldv-project@linuxtesting.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
 <1535642042-5336-2-git-send-email-zemlyanoy@ispras.ru>
 <747d9c74-02cd-fa39-9870-ae17dbddf366@aol.com>
 <44d6e603-fe1d-6853-c474-760c0a2ed4ec@aol.com>
 <47c7d469-c807-760d-7e28-ae8108a46af5@huawei.com>
 <20180831094106.sxwsd5v2mmn3cux6@mwanda>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9172e7b7-ff42-85ca-f546-a369b8698d27@huawei.com>
Date:   Mon, 3 Sep 2018 09:59:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831094106.sxwsd5v2mmn3cux6@mwanda>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/31 17:41, Dan Carpenter wrote:
> On Fri, Aug 31, 2018 at 11:29:03AM +0800, Chao Yu wrote:
>>
>> Hi Xiang,
>>
>> I'm not against this change which follows checkpatch's rule, since I think this
>> can help to unify coding style in different modules of Linux. Maybe cleanup in
>> other filesystem is needed as well.
>>
> 
> That code is old, and those filesystems are not in staging so we're not
> going to change them.

Yup, anyway, it can be decided by their maintainer if they want the cleanup.

> 
> Let's just apply the patch and not spend any time thinking about it.
> Part of the point of style guidelines is so that we don't have to
> repeat all these discussions over and over...
> 
> Btw, I have a rename_rev.pl patch for reviewing these.  I've attached
> it.  rename_rev.pl -r NULL.  I've seen some people screw up the
> conversion so having an automated review is nice.

Cool, thanks very much for providing this tools, it actually can help to save
some time during review. :)

> 
> regards,
> dan carpenter
> 

