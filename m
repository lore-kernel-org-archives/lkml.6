Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A8C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDFA21717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDFA21717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbeHCDo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:44:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732375AbeHCDo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:44:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08479B1BCB5D2;
        Fri,  3 Aug 2018 09:51:04 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 09:51:03 +0800
Subject: Re: [V9fs-developer] About the V9fs-developer list (Was: [PATCH] 9p:
 fix multiple
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <20180728055945.GA16684@nautica> <5B5C0D12.3070208@huawei.com>
 <20180728063248.GA24054@nautica> <20180802222835.GB18901@nautica>
CC:     Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>,
        Ron Minnich <rminnich@sandia.gov>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B63B4EF.4050909@huawei.com>
Date:   Fri, 3 Aug 2018 09:50:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180802222835.GB18901@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/3 6:28, Dominique Martinet wrote:
> Dominique Martinet wrote on Sat, Jul 28, 2018:
>> piaojun wrote on Sat, Jul 28, 2018:
>>> Could we cancel the limitation of recipients' number?
>>
>> I think it's hard-coded by source-forge...
>> I'm not list admin for v9fs-developer but we've had problems with
>> another sf list on another project and the options are fairly limited
>> from what I can recall...
> 
> I've got the list password from Eric (thanks!) and had a look.
> 
> It's actually more open than I remembered, in particular I have found
> this maximum number of recipients setting and have lifted the limit.
> 
> 
> You probably noticed I've also accepted a bunch of messages just now,
> sorry for the spam if these were messages you had already seen, but
> let's look forward to a more active list ;)
> 
Good news!
