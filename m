Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD1C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78120839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F78120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeIKU4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:56:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12097 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeIKU4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:56:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E54B5025C097;
        Tue, 11 Sep 2018 23:56:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Tue, 11 Sep 2018
 23:56:48 +0800
Message-ID: <5B97E5BF.1030307@huawei.com>
Date:   Tue, 11 Sep 2018 23:56:47 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <dsterba@suse.cz>, <clm@fb.com>, <jbacik@fb.com>,
        <dsterba@suse.com>, <lufq.fnst@cn.fujitsu.com>,
        <suy.fnst@cn.fujitsu.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs/extent_map: Remove unneeded variable "ret"
References: <1533474287-15049-1-git-send-email-zhongjiang@huawei.com> <5B7E9B1C.40404@huawei.com> <20180911154404.GD2154@twin.jikos.cz>
In-Reply-To: <20180911154404.GD2154@twin.jikos.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/11 23:44, David Sterba wrote:
> On Thu, Aug 23, 2018 at 07:31:40PM +0800, zhong jiang wrote:
>> Hi,  dsterba
>>
>> Can you pick up the patch? Thanks
> Please send one patch per changed function with relevant changelog that
> the return value is not used and that no callees could potentially
> return an error that would need to be passed.
Will do in v3

Thanks,
zhong jiang

