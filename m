Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A28C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2B921A09
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2B921A09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbeHFWhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:37:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:39842 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHFWhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:37:17 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w76KQV8V062166;
        Tue, 7 Aug 2018 05:26:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 07 Aug 2018 05:26:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w76KQQmu062141
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 7 Aug 2018 05:26:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>,
        syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>
Cc:     cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
References: <fc6e173e-8bda-269f-d44f-1c5f5215beac@I-love.SAKURA.ne.jp>
 <0000000000006350880572c61e62@google.com>
 <20180806174410.GB10003@dhcp22.suse.cz>
 <20180806175627.GC10003@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <078bde8d-b1b5-f5ad-ed23-0cd94b579f9e@i-love.sakura.ne.jp>
Date:   Tue, 7 Aug 2018 05:26:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806175627.GC10003@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/07 2:56, Michal Hocko wrote:
> So the oom victim indeed passed the above force path after the oom
> invocation. But later on hit the page fault path and that behaved
> differently and for some reason the force path hasn't triggered. I am
> wondering how could we hit the page fault path in the first place. The
> task is already killed! So what the hell is going on here.
> 
> I must be missing something obvious here.
> 
YOU ARE OBVIOUSLY MISSING MY MAIL!

I already said this is "mm, oom: task_will_free_mem(current) should ignore MMF_OOM_SKIP for once."
problem which you are refusing at https://www.spinics.net/lists/linux-mm/msg133774.html .
And you again ignored my mail. Very sad...
