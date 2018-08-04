Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA84FC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A0E2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A0E2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeHDShT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 14:37:19 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7784 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728417AbeHDShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 14:37:19 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43070901"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Aug 2018 00:35:56 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 723234B6ADEE;
        Sun,  5 Aug 2018 00:35:51 +0800 (CST)
Received: from fnst.localdomain (10.167.226.155) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Sun, 5 Aug 2018 00:35:54 +0800
Date:   Sun, 5 Aug 2018 00:35:48 +0800
From:   Lu Fengqi <lufq.fnst@cn.fujitsu.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs/extent_map: Remove unneeded variable "ret"
Message-ID: <20180804163548.GG2049@fnst.localdomain>
References: <1533381223-16734-1-git-send-email-zhongjiang@huawei.com>
 <20180804125947.GF2049@fnst.localdomain>
 <5B65A7E9.90607@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5B65A7E9.90607@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.226.155]
X-yoursite-MailScanner-ID: 723234B6ADEE.AC1DF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lufq.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 09:19:37PM +0800, zhong jiang wrote:
>On 2018/8/4 20:59, Lu Fengqi wrote:
>> On Sat, Aug 04, 2018 at 07:13:43PM +0800, zhong jiang wrote:
>>> The ret is not used after initalization, So just remove it.
>> So why not change these two functions to void function?
>>
> I just keep the original interface  and make the minimal change.
>of course,   It is also feasible that make these two functions to void function.
>
>I will repost if  you prefer to that change.  I am ok with that.

Since the return value which always is 0 is meaningless, I would prefer
to make this change.

-- 
Thanks,
Lu

>
>Thanks,
>zhong jiang
>
>
>


