Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E265C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A2C218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbfB0AuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:50:14 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:32783 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbfB0AuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:50:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08317383|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.21743-0.010436-0.772134;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.E1n3gWn_1551228607;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E1n3gWn_1551228607)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 27 Feb 2019 08:50:08 +0800
Subject: Re: [RFC v10 0/4] pstore/block: new support logger for block devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551162825-28943-1-git-send-email-liaoweixiong@allwinnertech.com>
 <20190226112033.GA16900@kroah.com>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <34916ace-7020-06e8-7958-f3652aef6604@allwinnertech.com>
Date:   Wed, 27 Feb 2019 08:50:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190226112033.GA16900@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-02-26 19:20, Greg Kroah-Hartman wrote:
> On Tue, Feb 26, 2019 at 02:33:41PM +0800, liaoweixiong wrote:
>> Why should we need pstore_block?
>> 1. Most embedded intelligent equipment have no persistent ram, which
>> increases costs. We perfer to cheaper solutions, like block devices.
>> In fast, there is already a sample for block device logger in driver
>> MTD (drivers/mtd/mtdoops.c).
>> 2. Do not any equipment have battery, which means that it lost all data
>> on general ram if power failure. Pstore has little to do for these
>> equipments.
>>
>> [PATCH v10]
> 
> Why are you still labeling these as "RFC"?  No one should actually be
> applying a Request For Comments patchset, as you obviously are not
> thinking it is ready to be merged :(
> 
> After 10 revisions, I hope you are confident in this patchset :)
> 

I'm confident in this patchset :) . It is first time for me to submit
RFC patches, i just don't know i should change the label to PATCH. Thank
you for reminding me.

> thanks,
> 
> greg k-h
> 

-- 
liaoweixiong
