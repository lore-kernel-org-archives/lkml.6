Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeBIXPl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:15:41 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:51009 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeBIXPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:15:39 -0500
X-Google-Smtp-Source: AH8x227Yyv1/2TsIdGw6EH4t5n33uPFkzhKi4Mg4NvN+Xs0JlSiraJcx1ipWQAiC+R96qur/IHJ02akQziSqS5MXy0o=
MIME-Version: 1.0
In-Reply-To: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
References: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 9 Feb 2018 15:15:38 -0800
Message-ID: <CALMp9eRbEqSu9M0_Z6aKbhXA9q8fKzkPznXm3ubU8Bcv_p2K1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] X86/nVMX: Properly set spec_ctrl and pred_cmd before
 merging MSRs
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w19NFkH6017378

On Thu, Feb 8, 2018 at 2:53 PM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
> These two variables should check whether SPEC_CTRL and PRED_CMD are
> supposed to be passed through to L2 guests or not. While
> msr_write_intercepted_l01 would return 'true' if it is not passed through.
>
> So just invert the result of msr_write_intercepted_l01 to implement the
> correct semantics.
>
> Fixes: 086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>
