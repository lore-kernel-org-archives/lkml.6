Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeEELDU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 07:03:20 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:38448 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEELDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 07:03:19 -0400
X-Google-Smtp-Source: AB8JxZrD0KTzWnIeRwgLdI09Dhol/Gsvnr8MHcSh1xouVuJ98qBmGqMGujRSO99+vSrCQcPzPMa1N0Rl3nrd+2cQQnc=
MIME-Version: 1.0
In-Reply-To: <96fca559-9759-0c2f-6e3b-98877c7340d3@web.de>
References: <1525131328-27086-1-git-send-email-wanpengli@tencent.com>
 <CANRm+CwcjUqNzWK3qVzGbuzgVLTYTyVtwSGgnVd2Ui4sxE+VkQ@mail.gmail.com> <96fca559-9759-0c2f-6e3b-98877c7340d3@web.de>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sat, 5 May 2018 19:03:18 +0800
Message-ID: <CANRm+CwTJ6ttCzwwYMESAGejC1V2sjLnjHTvTG0q8Vi=+CTAxw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: X86: Limit timer frequency to 200ms
To: Jan Kiszka <jan.kiszka@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>,
        Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-05 16:36 GMT+08:00 Jan Kiszka <jan.kiszka@web.de>:
> On 2018-05-05 01:44, Wanpeng Li wrote:
>> ping,
>> 2018-05-01 7:35 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> Anthoine reported:
>>>  The period used by Windows change over time but it can be 1 milliseconds
>>>  or less. I saw the limit_periodic_timer_frequency print so 500
>>>  microseconds is sometimes reached.
>>>
>>> As suggested by Paolo, lower the timer frequency limit to a
>>> smaller interval of 200 ms (5000 Hz) to leave some headroom. This
>>> is required due to Windows 10 changing the scheduler tick limit
>>> from 1024 Hz to 2048 Hz.
>
> "... lower the *default* timer frequency limit to a smaller interval of
> 200 *us* ..." - same for the subject.

Thanks Jan, I will update it.

Regards,
Wanpeng Li
