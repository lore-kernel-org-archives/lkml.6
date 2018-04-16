Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDPPpl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:45:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35303 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeDPPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:45:38 -0400
X-Google-Smtp-Source: AIpwx48KaMI/WWKuGf3aGedCmMWmy8PDuDrc06od8+1QFYOOg08w6z54lcmgd0UO0cCS8GiiWmlOauSwsNX3OMy02P4=
MIME-Version: 1.0
In-Reply-To: <bd6eb51a-584a-91ac-2af9-934cb33d2cbf@redhat.com>
References: <1523675452-27271-1-git-send-email-karahmed@amazon.de> <bd6eb51a-584a-91ac-2af9-934cb33d2cbf@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 16 Apr 2018 08:45:36 -0700
Message-ID: <CALMp9eRaOTOQF9T3CrvbgZOk0ohbdzbNtwMtb8-Beu0fBvpXWA@mail.gmail.com>
Subject: Re: [PATCH v4] X86/KVM: Properly update 'tsc_offset' to represent the
 running guest
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3GFjmP9009660

On Mon, Apr 16, 2018 at 4:04 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 14/04/2018 05:10, KarimAllah Ahmed wrote:
>> Update 'tsc_offset' on vmentry/vmexit of L2 guests to ensure that it always
>> captures the TSC_OFFSET of the running guest whether it is the L1 or L2
>> guest.
>>
>> Cc: Jim Mattson <jmattson@google.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: kvm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
>> [AMD changes, fix update_ia32_tsc_adjust_msr. - Paolo]
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
