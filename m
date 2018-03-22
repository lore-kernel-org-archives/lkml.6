Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754928AbeCVNjx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:39:53 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35421 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754598AbeCVNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:39:50 -0400
X-Google-Smtp-Source: AG47ELuePpHzfLraxF9EeyxzDljJbdjFXql8WqpE/h5bl3ryRmnrWmDB6v4+6V/8KqEjgU0IomeQkBJJCr3Wi7ENfkU=
MIME-Version: 1.0
In-Reply-To: <9bd82cb0-d88f-4891-a111-3704802e1d4e@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com> <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
 <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com> <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
 <9bd82cb0-d88f-4891-a111-3704802e1d4e@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 22 Mar 2018 21:39:49 +0800
Message-ID: <CANRm+CwmJQCFZ7oe1_YatqoOXzzEU+SP9Z5qR6zU_ybd_DoGQQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit mode
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-22 20:38 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 22/03/2018 12:04, Andrew Cooper wrote:
>> We've got a Force Emulation Prefix (ud2a; .ascii "xen") for doing
>> magic.  Originally, this was used for PV guests to explicitly request an
>> emulated CPUID, but I extended it to HVM guests for "emulate the next
>> instruction", after we had some guest user => guest kernel privilege
>> escalations because of incorrect emulation.
>
> Wanpeng, why don't you add it behind a new kvm module parameter? :)

Great point! I will have a try. Thanks Paolo and Andrew. :)

Regards,
Wanpeng Li
