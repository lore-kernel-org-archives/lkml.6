Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC8C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CD72184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfBLPlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:41:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:44971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbfBLPlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:41:49 -0500
Received: from [10.0.0.4] ([113.116.50.220]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Ld4xA-1hJoFt0Xs8-00iEgi; Tue, 12
 Feb 2019 16:41:47 +0100
Subject: Re: [PATCH 2/2] chardev: showing minor range for chardev in the
 output of /proc/devices
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190212084739.27602-1-cgxu519@gmx.com>
 <20190212084739.27602-2-cgxu519@gmx.com> <20190212090212.GE31657@kroah.com>
 <a8332299-818e-571c-efc9-7885f18eddb8@gmx.com>
 <20190212152053.GA25804@kroah.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <f6f02cb9-79ad-aeb0-a911-89dfb1f90aae@gmx.com>
Date:   Tue, 12 Feb 2019 23:41:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212152053.GA25804@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:NWE2M9a/8IrjrA+KnVD99ve1MX9xqU+wv0r7u1G+zfgRvPXWR4r
 toEpXey4m1ep+ySthOpvWRk3UpNWa5iKgjDJ8YwV5PuKf5XEKPU0L0Ps5WSZtLYBwMq3/Od
 +L4tq14Zwa+03sgp/wWb3qNJLAJATs/Y8VjBnFxB8KAqZz+0Bv56NXal2t7QBhaEUTUOT3K
 zubL7EGenPppWQecQE1QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kthetnN4f2g=:fLieYvO6rvzC2nx9HkjZwA
 WdkPPOvir3lP9ezruBZevRXLuJnXE8+8eDtTYEGiinQ6wLWalnIaLyvFDDQOFuBAJYNPzPcUa
 jmog0xwxUQNhcRM8BDsyJ7xVEDJoa9TPiJuG9jFl5+5k3Yd8ZB9UWqKrO4Ri25rpY7+TCq8Bx
 wrF7KpFreJQERw8uTSdKhyIfWf7x/hQvINsKjlmqKoLucCgThFozj9eyuTSC6M2Igr+WngOrK
 /JX0CDjHwEJuvcT5whN4FAT00cAH2YW3XjBC3n8TkbHPhW+SSRKSNrUQ5b9oqkqitGdgmLMO8
 XQi6VMa6F2gdWCYeSCVtCcdpt3FphYdueC+rByDhXwd/Zsp6BmYcoWWYTAtSjp+rPuVG681Fd
 +wtCVZctDDWY6n0GJcGuTGJpUtPb53nT0zI21wdRYe4/qx8lynK9wF3sgh9VxVVii97eB6gzw
 ruLEJfsmeGcDMRwMJbDKCYs69qu6r+sZ6zZFmL0IoOalWh+nJxSv1vs97z7uxOiHIfjIqcHBz
 druCRqKquSOJQXj+h5OPFCi83o07e7c2FsbduopJ1L180LMNiKCbRXVpZ6U/Qe1H9BlHgGIlM
 2yXxv2C211FIZ3KHlTPzyyPonxYloGyJl4KryeBybAbLZ2Vyg9BfDPLxzOs8+RJR6ZcF7Lgpp
 8vEjKZnD6joYjqZWgbhFDex6ih+aaoePzu7YTnbk3R4iR5u0kol6pzCOa4oUm5UnDTdJGRIaQ
 8AVhs5GWM65WnVOYy6tHqv68hBj+OXnqT92vAjeYfkURfq1a+g7Xpn0mGB5a5zakb5KXiBkOQ
 VKMLjSwHAcqHTO/uQLbiMbau3+Smir9YIe0eoxVruCZ1bgRC1bYij409oj3NA25q/Y7biwBFW
 kNbErdUt8AbMZZQ/LvCW7NCoI85CSN88QgHoXf3bz7xOp+ysRponIGS8MDY2XHdWvnESA0Q4p
 w5p8aTfShn0FN8lVpO5DYCc+Ht/1UCBJyjgSoT/cLYUTeacj0iO/72ZrKHzTvfa9BB65Gpxza
 kKsqd6f2St4W/tUQC/07qXw/0lcgy25MNVZSCHMu2w2GnQaXZKn6MFA/us4dELTZu5pdIn/2K
 PjczuW1fdvEhKwM6UBf8eK6zOYERU/4aOi2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 11:20 PM, Greg KH wrote:
> On Tue, Feb 12, 2019 at 11:18:22PM +0800, cgxu519 wrote:
>> On 2/12/19 5:02 PM, Greg KH wrote:
>>> On Tue, Feb 12, 2019 at 04:47:39PM +0800, Chengguang Xu wrote:
>>>> Currently chardev allows to share major, showing
>>>> major with minor range for chardev will be more
>>>> helpful.
>>>>
>>>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
>>>> ---
>>>>    fs/char_dev.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/char_dev.c b/fs/char_dev.c
>>>> index b25b1da097d5..6f00acdeb308 100644
>>>> --- a/fs/char_dev.c
>>>> +++ b/fs/char_dev.c
>>>> @@ -55,7 +55,9 @@ void chrdev_show(struct seq_file *f, off_t offset)
>>>>    	mutex_lock(&chrdevs_lock);
>>>>    	for (cd = chrdevs[major_to_index(offset)]; cd; cd = cd->next) {
>>>>    		if (cd->major == offset)
>>>> -			seq_printf(f, "%3d %s\n", cd->major, cd->name);
>>>> +			seq_printf(f, "%3d %s (%u-%u)\n", cd->major, cd->name,
>>>> +				   cd->baseminor,
>>>> +				   cd->baseminor + cd->minorct - 1);
>>> You are changing the format of a userspace file, what tools are going to
>>> break when you do this?
>> I'll remove this part in V2. Do you have any idea how to get the minor
>> range info for particular major? Or adding a similar file to somewhere
>> under /sys is acceptable?
> Why do you need to know the minor range?  What can userspace do with
> this that actually matters?

Assume that when we try to load a driver module and fail with -EBUSY
because of minor range overlapping, then what can we do for this case?
we even don't know what range has occupied and what range is available.

Also, I think we can obviously notice range overlapping bugs by showing
all registered minor ranges.

Thanks,
Chengguang.

