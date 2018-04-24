Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756242AbeDXGF2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:05:28 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:42195 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755919AbeDXGFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:05:22 -0400
X-Google-Smtp-Source: AB8JxZqIunLfgwkzuPUdF/TaeH5csfUeW63kCQcZ2nfb/fsk5S8/v1GRw9G8yujC0juV41GYEiUvWw==
Subject: Re: [PATCH v2] Input: xen-kbdfront - allow better run-time
 configuration
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lyan@suse.com, boris.ostrovsky@oracle.com, andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180419133934.31306-1-andr2000@gmail.com>
 <998533bb-8042-b07e-cb79-661750e035d9@gmail.com>
 <a2189ec9-ef4d-2c23-28c6-a6ff8525e8e5@suse.com>
 <7b4c1f8a-6317-1f17-5950-64a1b7183dba@gmail.com>
 <20180423185530.GC66646@dtor-ws>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <97f3a94f-f1d3-a162-c081-15f938eb7dd6@gmail.com>
Date: Tue, 24 Apr 2018 09:05:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423185530.GC66646@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2018 09:55 PM, Dmitry Torokhov wrote:
> On Mon, Apr 23, 2018 at 11:29:45AM +0300, Oleksandr Andrushchenko wrote:
>> On 04/23/2018 11:23 AM, Juergen Gross wrote:
>>> On 23/04/18 10:02, Oleksandr Andrushchenko wrote:
>>>> Juergen, Jason, Dmitry
>>>> any comment on this?
>>> Oleksandr, please give us some time. I can't speak for others, but I am
>>> not sitting here idling and hoping that some work (e.g. patches to
>>> review) might appear.
>>>
>>> I have a lot of other stuff to do and will respond when I find some time
>>> to look at your patches.
>>>
>>> Pinging others on Monday when having sent out the patch only on Thursday
>>> is rather unfriendly.
>> Really sorry about this, my bad.
>> I had an impression that the only change we need to
>> discuss was uint -> bool change which seemed rather trivial
> I am sorry I did not respond to the previous version until today, but I
> do not think that we should be extending module parameters for this.
> Protocol features are already there for absolute pointers and
> multi-touch, keyboard and relative pointers should use the same
> mechanism.
Ok, then I'll start from extending the protocol
> Thanks.
>
