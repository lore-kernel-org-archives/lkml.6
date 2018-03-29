Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeC2AqW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:46:22 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41249 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC2AqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:46:21 -0400
X-Google-Smtp-Source: AIpwx4+KlC7yp7N51w4nJ6jw/JfXB5OSkzGEMbb/btv3FH0YQi6uBigJ5yjfKf83kItcxfxcY0dPYNKamN4CkZQVzig=
MIME-Version: 1.0
In-Reply-To: <20180328201424.GE26753@flask>
References: <1521951515-5139-1-git-send-email-wanpengli@tencent.com> <20180328201424.GE26753@flask>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 29 Mar 2018 08:46:19 +0800
Message-ID: <CANRm+CzTY6R4QoOHWSWz-6wUp+1krSMf3B0-RNpoUmu22uD8cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: X86: Fix disable pv tlb flush when steal time is enabled
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2T0kQ6s020554

2018-03-29 4:14 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
> 2018-03-24 21:18-0700, Wanpeng Li:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> PV TLB FLUSH can be turned on when steal time is enabled. The condition
>> reverse when the patch is sent out for several rounds review by mistake.
>
> It was just one round and the m/l patch actually looks correct,
>
>> This patch fixes it.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>
> I've modified the commit message and rebased it for kvm/master, thanks.

Thanks Radim. :)

Regards,
Wanpeng Li
