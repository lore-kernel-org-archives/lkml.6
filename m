Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6121C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B4120892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B4120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeLFO3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:29:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbeLFO3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:29:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB2E289AD3;
        Thu,  6 Dec 2018 14:29:02 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBEEC19C7D;
        Thu,  6 Dec 2018 14:29:01 +0000 (UTC)
Subject: Re: [PATCH v14 00/11] livepatch: Atomic replace feature
To:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129094431.7801-1-pmladek@suse.com>
 <176e592d-6e9c-8e1c-abe6-d07ba9b10d54@redhat.com>
 <20181206075404.rv4qyw2u5auvfiuz@pathway.suse.cz>
 <alpine.LSU.2.21.1812061031030.17628@pobox.suse.cz>
 <20181206101555.cydbzb7smubzsavn@pathway.suse.cz>
 <20181206123700.ljiybm6w6wvmiy7c@pathway.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <a135ede9-c5c9-cf63-4beb-8a56379ed8af@redhat.com>
Date:   Thu, 6 Dec 2018 09:29:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181206123700.ljiybm6w6wvmiy7c@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 06 Dec 2018 14:29:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 07:37 AM, Petr Mladek wrote:
> On Thu 2018-12-06 11:15:55, Petr Mladek wrote:
>> On Thu 2018-12-06 10:32:00, Miroslav Benes wrote:
>>>
>>>>> I don't have many code comments as the changes appear to safely and
>>>>> correctly do what the say.  (We are at v14 after all :)  I mainly
>>>>> compared the text and comments to the implementation and noted typos
>>>>> (marked by substitution s/old/new) and awkward wordings (marked by
>>>>> "re-wording suggestion").  That said, I ack'd each patch as I wouldn't
>>>>> want these to hold up the patchset.
>>>>
>>>> Thanks a lot both you and Miroslav for the review.
>>>>
>>>> I'll give it some more days before I prepare v15. I wonder if Josh
>>>> could find some cycle to look at it at least from the top level.
>>>
>>> For what is worth, I'm fine with all the changes Joe proposed and you can 
>>> preserve my acks there.
>>
>> We need enough time for bikeshedding about comments and documentation.
>> I need some time to recover. And I still hope that Josh can give it
>> a spin.
> 
> Please, forget the above paragraph. I did not get Mirek's one correctly.
> I understood it as "Why do we need to wait? You have two acks.
> Jump on it and send us v15 immediately."
>

No worries :) I usually interpret language bikeshedding as an indication
that the code is just about done.  BTW, I think Josh will be back online
next week, as he is out of the office this week.

-- Joe


