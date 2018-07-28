Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C1C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26F92088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26F92088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeG1HyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:54:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbeG1HyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:54:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E785795748774;
        Sat, 28 Jul 2018 14:28:56 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.382.0; Sat, 28 Jul 2018
 14:28:53 +0800
Subject: Re: About the V9fs-developer list (Was: [PATCH] 9p: fix multiple
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>
References: <20180728055945.GA16684@nautica>
CC:     <v9fs-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B5C0D12.3070208@huawei.com>
Date:   Sat, 28 Jul 2018 14:28:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180728055945.GA16684@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could we cancel the limitation of recipients' number?

Thanks,
Jun

On 2018/7/28 13:59, Dominique Martinet wrote:
> NULL-pointer-dereferences)
> Reply-To: 
> In-Reply-To: <5B5BBFCE.50002@huawei.com>
> 
> 
> (Re-added Eric, ron, Latchesar to the recipients and removed a few
> others to make v9fs accept this mail without moderation, sorry Thomas &
> others)
> 
> 
> TL;DR: should we move the list, and should I send a patch adding myself
> to maintainers?
> 
> 
> piaojun wrote on Sat, Jul 28, 2018:
>> I could not recieve the original patch. Did the patch CC v9fs developer
>> maillist?
> 
> Yes, but as usual there were too many recipients (I removed some like
> you did previously), so the patch is probably queued for moderation
> somewhere.
> 
> For this specific patch, you can find the original message here from the
> lkml archives:
> http://lkml.kernel.org/r/20180727110558.5479-1-tomasbortoli@gmail.com
> 
> 
> (Or more generally for patches I say I've accepted, my current process
> is to push them to my 9p-test branch[1] then once they have been tested
> push the same thing to my 9p-next branch[2] that will be taken into
> linux-next; this is already in 9p-next now :
> https://github.com/martinetd/linux/commit/49fd386d1e67d7876770d46b57359c6891d4cb70
> 
> [1] https://github.com/martinetd/linux/commits/9p-test
> [2] https://github.com/martinetd/linux/commits/9p-next
> 
> I always check that linux-kernel@vger was in copy and insert the Link:
> tag as appropriate if you need to reply)
> 
> 
> 
> 
> In general though I'd realy like to bring up the subject of this mailing
> list as I feel it's been a burden lately.
> I'm not even an admin of the list so I feel a little out of place here
> but should I go around snooping to ask if we could make a new
> v9fs@vger.kernel.org mailing list and abandon the ship here?
> 
> A second question that's been on my mind lately is if I'm going to be
> gathering 9p patchs from now I should probably start considering sending
> a patch to add myself to MAINTAINER.
> 
> I've had a quick look at the file though and there aren't many
> subsystems with 4+ maintainer (breakdown if I can count: 1301 with 1,
> 342 with 2, 104 with 3, 31 with 4, 4 with 5, 1 with 6 and 10
> maintainers) and more to the point I also think having too many
> maintainers is a nuisance, which is why I've been reluctant to add
> myself.
> 
> I however don't want to forcefully remove anyone either, Eric has been
> somewhat active with three messages in may at least, and Latchesar akced
> patchs this past year as well (September but still within 12 months) so
> he's definitely still reading these emails a bit...
> That being said, it's not like retiring from maintainers means one won't
> be able to look and comment at patches, just that patches will get less
> recipients and might go to through to the list more easily.
> 
> To be honest I wouldn't care at all if the list worked well, but in the
> state things are in it's easy for me to miss a patch unless someone
> redirects it to me like Greg did recently.
> 
> There isn't any hurry, but let's discuss this and move forward.
> 
> 
> What do you three think about this?
> What do others think?
> 
> Thanks!
> 
