Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 04:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C82A21866
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 04:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C82A21866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeHQHav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 03:30:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbeHQHav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 03:30:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8341E401BF61;
        Fri, 17 Aug 2018 04:29:00 +0000 (UTC)
Received: from [10.72.12.22] (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C66717883;
        Fri, 17 Aug 2018 04:28:53 +0000 (UTC)
Subject: Re: [PATCH 1/1] tap: comment fix
To:     David Miller <davem@davemloft.net>, jianjian.wang1@gmail.com
Cc:     girish.moodalbail@oracle.com, mst@redhat.com, willemb@google.com,
        viro@zeniv.linux.org.uk, wexu@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAP4sYWUDb8wtNVvgPO+3a5MWoiBGuafQpvG6KR30RWinf36Msw@mail.gmail.com>
 <20180816.123002.844201503080913720.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d3c380fc-cebd-0a91-1acc-916a453c9f11@redhat.com>
Date:   Fri, 17 Aug 2018 12:28:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816.123002.844201503080913720.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 04:29:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 04:29:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月17日 03:30, David Miller wrote:
> From: Wang Jian <jianjian.wang1@gmail.com>
> Date: Thu, 16 Aug 2018 21:01:27 +0800
>
>> The tap_queue and the "tap_dev" are loosely coupled, not "macvlan_dev".
>>
>> And I also change one rcu_read_lock's place, seems can reduce rcu
>> critical section a little.
>>
>> Signed-off-by: Wang Jian <jianjian.wang1@gmail.com>
> This patch was corrupted by your email client, for example it turned
> TAB characters into sequences of spaces.
>
> Please fix this, email a test patch to yourself, and do not resend the
> patch to this mailing list until you can successfully extract and
> cleanly apply the test patch you email to yourself.
>
> Thank you.

Besides this, please split it into two patches. The RCU change does not 
belong to "comment fix" for sure.

Thanks

