Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E7FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5D2070D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfBFQNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:13:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45966 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:13:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id t6so5091891edw.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hoYHwI9R3CN35SlxKBXnUAlOUNBbUPhkHMRsIxQtw20=;
        b=suuoj744/StZDZg1uTegami73DahoXwB46gpPVMaLDDgRrYJKXzpzawqIoE3i975a2
         UbayrZ0AWSE4xdDj7QiolM7AsRPELSLpW5DSj3w2G5t3Q03JPAtpLIqiS1yzAOjjEebs
         XCfIE8wzwweVo2HBzqUDnqC1eo5myAAUa2ezhnb1exM7dg/e9LQNSqPGlqi7dKr1i/sw
         vLs5X54y8KelTzFVmj9F5k3wcRd4xOOeglLqDTUAlaIQWPD+GxHsAwGHaXn2+QDB4IN8
         QsdrMXK6omHMAMD6LIIRMxNxzlpbM4hX+bly3L36atN53yip6eHpS4nif1m+V29OymEG
         vQSg==
X-Gm-Message-State: AHQUAuYaRJq+WuJm2xM5G49Te9l19kDv8iFiI56mbYfJuxaGqeMMY2A/
        NbEPp8kP6SDcdK9KPBGuwSDjdw==
X-Google-Smtp-Source: AHgI3IY+MKHNXibq/OeHvbG8HvswxdIiwVFVyr1HAy6IuZqW/9EDNkWe54BHqv1bAlBtoyIpPcoB5g==
X-Received: by 2002:aa7:ca0d:: with SMTP id y13mr8586170eds.285.1549469628978;
        Wed, 06 Feb 2019 08:13:48 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k12sm3612140ejz.4.2019.02.06.08.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 08:13:48 -0800 (PST)
Subject: Re: [PATCH 2/2] staging/vboxvideo: Add TODO
To:     Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
 <20190204103114.30772-2-daniel.vetter@ffwll.ch>
 <20190204185416.GC2834@ravnborg.org>
 <20190206155856.GK3271@phenom.ffwll.local>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c5c6169c-8e3d-36ec-67ed-dd2773a5eb9d@redhat.com>
Date:   Wed, 6 Feb 2019 17:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206155856.GK3271@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-02-19 16:58, Daniel Vetter wrote:
> On Mon, Feb 04, 2019 at 07:54:16PM +0100, Sam Ravnborg wrote:
>> Hi Daniel
>>
>> On Mon, Feb 04, 2019 at 11:31:14AM +0100, Daniel Vetter wrote:
>>> Noticed why wonder what vboxvideo is using the ->master_set/drop hooks
>>> for.
>> Can you improve the gammar a little, I find it hard to read.
>>
>>>
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Fabio Rafael da Rosa <fdr@pid42.net>
>>> Cc: Nicholas Mc Guire <der.herr@hofr.at>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>   drivers/staging/vboxvideo/TODO | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/staging/vboxvideo/TODO b/drivers/staging/vboxvideo/TODO
>>> index 2e0f99c3f10c..2953e7f794fb 100644
>>> --- a/drivers/staging/vboxvideo/TODO
>>> +++ b/drivers/staging/vboxvideo/TODO
>>> @@ -1,5 +1,7 @@
>>>   TODO:
>>>   -Get a full review from the drm-maintainers on dri-devel done on this driver
>>> +-Drop all the logic around initial_mode_queried/master_set&_drop and everything
>>> +related to this. kms clients can handle hotplugs.
>>>   -Extend this TODO with the results of that review
>>>   
>>>   Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
>>
>> The syntax around "master_set&_drop" could be better.
>> I wondered if the "&" was some rst syntax.
>>
>> But anyway, despite grammar nit and syntax nit:
>> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Both patches queued for 5.1 in drm-misc, thanks for taking a look.
> 
>> Which bring me back to a question asked a week ago or so.
>> What is missing before we can move vboxvideo out of staging/
> 
> I think it boils down to someone needs to submit it and we'll take a look.

Right, I have this on my TODO, but I did not manage to find time for this
the past few weeks. I expect to have time for this in a couple of weeks
from now, which means the move will miss the 5.1 merge window.

Note you (Sam) are certainly welcome to submit a patch doing the move
yourself, I can certainly use some help with maintaining vboxvideo.

Note I will be available to help answer questions resulting from a
review for moving the driver out of staging. And more in general, if you
want to do this I will try to help where I can.

Regards,

Hans
