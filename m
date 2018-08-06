Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8BAC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5140D219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5140D219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeHFEoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:44:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbeHFEoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:44:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96328170AC470;
        Mon,  6 Aug 2018 10:37:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 10:37:07 +0800
Message-ID: <5B67B454.1050604@huawei.com>
Date:   Mon, 6 Aug 2018 10:37:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Nikolay Borisov <nborisov@suse.com>
CC:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Remove uneeded variable "err"
References: <1533481371-21349-1-git-send-email-zhongjiang@huawei.com> <c9f07f02-38c0-7491-3b48-0dda20f60d13@suse.com>
In-Reply-To: <c9f07f02-38c0-7491-3b48-0dda20f60d13@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/6 3:14, Nikolay Borisov wrote:
>
> On  5.08.2018 18:02, zhong jiang wrote:
>> zhong jiang (3):
>>   fs/btrfs/disk-io: Remove unneeded variable "err"
>>   fs/btrfs/extent-tree: remove redudant variable "err"
>>   fs/btrfs/tree-log: remove the unneeded variable "err"
>>
>>  fs/btrfs/disk-io.c     | 12 ++++--------
>>  fs/btrfs/extent-tree.c |  6 ++----
>>  fs/btrfs/tree-log.c    |  5 +----
>>  fs/btrfs/tree-log.h    |  2 +-
>>  4 files changed, 8 insertions(+), 17 deletions(-)
>>
>
> NAK on the whole series on the basis of using a bulk commit message
> which doesn't really describe the changes of each individual commit. If
> you want those changes to eventually be merged resubmit the series with
> individual reasoning for every commit.
>
>
 It's sorry for using a bulk commit message. I will repost with a patch
 because it solves the same issue.

Thanks,
zhong jiang

