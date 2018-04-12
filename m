Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeDLRNI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:13:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44966 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeDLRNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:13:06 -0400
X-Google-Smtp-Source: AIpwx48qU46OEK4XTefq0FAU+DyBUyt0Qan7O68MV/EorWuPm/dx74lU2TRY71009VxowMeJ6XKC6Q==
Subject: Re: [PATCH 0/5] for-linux/sndif: add explicit back and front
 synchronization
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        konrad.wilk@oracle.com, tiwai@suse.de
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, jgross@suse.com
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
 <d5ede3f5-200e-f1c7-71f4-4ebfb938ca48@gmail.com>
 <43348cf5-d2f8-9d7d-0390-2273eef8f67d@oracle.com>
 <db3ee9fb-d0ab-5f17-a1ec-7bb8ec5cf75f@epam.com>
 <690a322e-20a6-fe55-1d87-0a52de126ee0@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <eb882793-4024-7299-9d34-62d3cf462a33@gmail.com>
Date: Thu, 12 Apr 2018 20:13:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <690a322e-20a6-fe55-1d87-0a52de126ee0@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 08:13 PM, Boris Ostrovsky wrote:
> On 04/12/2018 12:55 PM, Oleksandr Andrushchenko wrote:
>> On 04/12/2018 07:55 PM, Boris Ostrovsky wrote:
>>> On 04/12/2018 12:11 PM, Oleksandr Andrushchenko wrote:
>>>> Hello, Konrad, Takashi!
>>>>
>>>> Could you please review the *Linux Kernel* version of the changes?
>>>> As I said in the cover letter below there is no functional changes
>>>> comparing to the corresponding Xen version, but spaces to tabs.
>>>> Still, formally, I have to drop the R-b tags and request for the new
>>>> review.
>>> Is there any reason why this all can't be done in a single patch?
>> Just to preserve the history of the changes?
> The history is tracked in Xen tree and since you are only updating the
> header file I don't think we gain much by repeating it here.
makes sense
>>> This is just syncing up with the canonical definition in Xen.
>> Do you want me to squash and resend?
>
> Yes, please.
will do
> -boris
