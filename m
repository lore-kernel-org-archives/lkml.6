Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeBZLhi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:37:38 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:46210 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBZLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:37:33 -0500
X-Google-Smtp-Source: AG47ELv4f5N+f0jkAaFdgLyv8SYE/sytqfcYHx7UFEnv6RZl3uPP7E0dn6DnnMH3T8j+gepwxQZrwqaw+WxLgVg6zqA=
MIME-Version: 1.0
In-Reply-To: <20180226113000.GC4377@pd.tnic>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic> <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic> <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
 <20180226111630.GB4377@pd.tnic> <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
 <20180226113000.GC4377@pd.tnic>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 26 Feb 2018 19:37:32 +0800
Message-ID: <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 19:30 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> On Mon, Feb 26, 2018 at 07:25:28PM +0800, Wanpeng Li wrote:
>> Both are the same values set by kvm userspace.
>
> This still doesn't answer my question what "the non-sensical value which
> is written by the guest will not reflect to guest-visible microcode
> revision" means?

The guest write is ignored as the original kvm implementation before the patch.

>
>> This is correct. The link explains why the userspace sets microcode
>> revision is still needed.
>
> Why is it still needed?

Hmm, the apic_check_deadline_errata() example can be referred to.

Regards,
Wanpeng Li
