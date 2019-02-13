Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C9BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B85222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404162AbfBMWSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:18:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45772 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfBMWSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:18:20 -0500
Received: by mail-ed1-f68.google.com with SMTP id d9so3321988edh.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NbSqWpBg7Mi9yhXJpdTbKkP9qMtgF2+adPLWUr56kAo=;
        b=unsFViMFiwvwwjI0RBkVRKpjiPycu3W3XbNtJuAsoYAaG2Qjz+iUZIEQFp3qN5UNmc
         kSLYdeV+GFiRXb+XNblVfR0GT1MaXAd75+/Y4F4Zr2iV7XNSOPsPnUYrhrlHTTd2pAF6
         yViWXZQyKcTpCZUMx/Irw7TxNWx5fXxWfN8C24ADTW81AcBvcHMFtTULCbxP46grVRFo
         VIo5e5mgYSiuhTq7sjDfxjJVdQEjvsSZYKW6K+mtgI8DB4MyelKIhL3n0HTAaDl3Aeg6
         0bvGCN/rk0KQBi0lfNXh6wtapd+S912pfqb0Ub68LQU3fXPlMKVhhFPNiWnrsAPCnANv
         6XFw==
X-Gm-Message-State: AHQUAuY1Sojoavn1Nc/JbCMa5bziGQvU6d4WSTPSunr+aNfeDcVXPoTr
        LJ344rvh1xFx38BHZRg8G/nIG9NVuaw=
X-Google-Smtp-Source: AHgI3IaKl4a2Yv4pyMmO/JRyMWyQ4ul7WrQTLCI+gDymh5VXQGi4H1UbpXdtLjhCG3LUS3kJUXJtqw==
X-Received: by 2002:a50:be05:: with SMTP id a5mr243426edi.243.1550096298837;
        Wed, 13 Feb 2019 14:18:18 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y63sm138548eda.57.2019.02.13.14.18.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:18:17 -0800 (PST)
Subject: Re: [PATCH 2/2] staging/vboxvideo: Add TODO
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
 <20190204103114.30772-2-daniel.vetter@ffwll.ch>
 <20190204185416.GC2834@ravnborg.org>
 <20190206155856.GK3271@phenom.ffwll.local>
 <c5c6169c-8e3d-36ec-67ed-dd2773a5eb9d@redhat.com>
 <20190213184605.GA11537@ravnborg.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b3d561ab-33cb-fb17-6fd6-d0bd0b5697ff@redhat.com>
Date:   Wed, 13 Feb 2019 23:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213184605.GA11537@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-02-19 19:46, Sam Ravnborg wrote:
> Hi Hans
>>>
>>>> Which bring me back to a question asked a week ago or so.
>>>> What is missing before we can move vboxvideo out of staging/
>>>
>>> I think it boils down to someone needs to submit it and we'll take a look.
>>
>> Right, I have this on my TODO, but I did not manage to find time for this
>> the past few weeks. I expect to have time for this in a couple of weeks
>> from now, which means the move will miss the 5.1 merge window.
>>
>> Note you (Sam) are certainly welcome to submit a patch doing the move
>> yourself, I can certainly use some help with maintaining vboxvideo.
> 
> I have not tried to submit patches to move vboxvideo out of staging.
> Partially due to lack of time, mostly lack of competence to
> follow-up on the review comments I hope we will see.
> I am perfectly happy to do trivial stuff, but when someone ask
> to replace the use of ttm with shmem+gem (example - I do not
> know if this is a relevant comment), then it is above
> me for the moment.
> And on top of this then I lack a good testing environment.
> 
> I could do it but then anything difficult would just be added
> to a TODO file, and then I dunno how useful it is.
> Something to consider when we are past the merge window anyway.

Ok, I will try to submit a patch doing the move myself soon.

Regards,

Hans

