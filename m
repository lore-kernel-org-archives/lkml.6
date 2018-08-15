Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA786C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71353215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71353215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeHOP7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:59:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728896AbeHOP7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:59:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5C53672985631;
        Wed, 15 Aug 2018 21:06:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Wed, 15 Aug 2018
 21:06:52 +0800
Message-ID: <5B742568.4000202@huawei.com>
Date:   Wed, 15 Aug 2018 21:06:48 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <dsterba@suse.cz>, <clm@fb.com>, <jbacik@fb.com>,
        <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 0/3] change some function to be void function
References: <1533736075-8691-1-git-send-email-zhongjiang@huawei.com> <20180815125340.GN24025@twin.jikos.cz>
In-Reply-To: <20180815125340.GN24025@twin.jikos.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/15 20:53, David Sterba wrote:
> On Wed, Aug 08, 2018 at 09:47:52PM +0800, zhong jiang wrote:
>> v3->v2:
>>  - Repost the patches with detailed changelog.
>> v1->v2:
>>  - Fix v1 issue that forget to return after remove the variable "ret".
>>
>> zhong jiang (3):
>>   fs/btrfs/disk-io: change btrfs_destroy_delayed_refs to be void
>>     function
>>   fs/btrfs/extent-tree: change btrfs_free_reserved_bytes to be void
>>     funtion
>>   fs/btrfs/tree-log: change btrfs_pin_log_trans to be void function
> The patches 2 and 3 can be applied, but please update che subject and
> put just "btrfs: " there, not the full file path. That we can find in
> the diff. The changelogs can be still improved to be clear about callers
> vs callees. Please update and resend.
>
> .
>
 Thank you for review and  suggestion.   I will repost v3.

Sincerely,
zhong jiang

