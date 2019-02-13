Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58772C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BEB206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfBMAjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:39:37 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:55349 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727871AbfBMAjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:39:37 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0892108|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.DxsVvxw_1550018370;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DxsVvxw_1550018370)
          by smtp.aliyun-inc.com(10.147.42.241);
          Wed, 13 Feb 2019 08:39:31 +0800
Subject: Re: [RFC v7 0/5] pstore/block: new support logger for block devices
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
References: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
 <CAGXu5jLE8dr4+G6fFmwcbm8YAs=RB+OiupyPCX6COhVu6av__w@mail.gmail.com>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <18924d77-f027-33f9-a775-ef140f5ba360@allwinnertech.com>
Date:   Wed, 13 Feb 2019 08:40:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLE8dr4+G6fFmwcbm8YAs=RB+OiupyPCX6COhVu6av__w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13 04:54, Kees Cook wrote:
> On Wed, Jan 23, 2019 at 4:06 AM liaoweixiong
> <liaoweixiong@allwinnertech.com> wrote:
>>
>> Why should we need pstore_block?
>> 1. Most embedded intelligent equipment have no persistent ram, which
>> increases costs. We perfer to cheaper solutions, like block devices.
>> In fast, there is already a sample for block device logger in driver
>> MTD (drivers/mtd/mtdoops.c).
>> 2. Do not any equipment have battery, which means that it lost all data
>> on general ram if power failure. Pstore has little to do for these
>> equipments.
>>
>> [PATCH v7]
>> On patch 1:
>> 1. Fix line over 80 characters.
>> On patch 2:
>> 1. Insert a separate patch for DT bindings.
> 
> This is looking good. Can you address the DT bindings review concerns,
> and send a v8?
> 

Sure. I had little time to send patches as i caught up with the Spring
Festival some days ago, the most grand festival of China. I'll do it
before this weekend, which is already in my plan.

> Thanks!
> 

-- 
liaoweixiong
