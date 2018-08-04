Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6CEC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E34521564
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E34521564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbeHDPU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:20:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726871AbeHDPU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:20:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 78745C5D3A798;
        Sat,  4 Aug 2018 21:19:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Sat, 4 Aug 2018
 21:19:39 +0800
Message-ID: <5B65A7E9.90607@huawei.com>
Date:   Sat, 4 Aug 2018 21:19:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Lu Fengqi <lufq.fnst@cn.fujitsu.com>
CC:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs/extent_map: Remove unneeded variable "ret"
References: <1533381223-16734-1-git-send-email-zhongjiang@huawei.com> <20180804125947.GF2049@fnst.localdomain>
In-Reply-To: <20180804125947.GF2049@fnst.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/4 20:59, Lu Fengqi wrote:
> On Sat, Aug 04, 2018 at 07:13:43PM +0800, zhong jiang wrote:
>> The ret is not used after initalization, So just remove it.
> So why not change these two functions to void function?
>
 I just keep the original interface  and make the minimal change.
of course,   It is also feasible that make these two functions to void function.

I will repost if  you prefer to that change.  I am ok with that.

Thanks,
zhong jiang

