Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbeBBRhv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:37:51 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:45274 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeBBRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:37:39 -0500
X-Google-Smtp-Source: AH8x225B5ctkAZrjFAhSqK+5arivI29902gO7Vtt4KG1pXlV3CBuG6Fl3Y3bWjRV1eKgREw6ziA/sV/NYg43W2O+Em4=
MIME-Version: 1.0
In-Reply-To: <1517522386-18410-2-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de> <1517522386-18410-2-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 2 Feb 2018 09:37:37 -0800
Message-ID: <CALMp9eTWEO4dZ7Gu3-=6wd3Wj6Z=Qkq3peBNx6ZK3oUOkXbthQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] KVM: x86: Update the reverse_cpuid list to include CPUID_7_EDX
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w12HbuET011790

On Thu, Feb 1, 2018 at 1:59 PM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
> [dwmw2: Stop using KF() for bits in it, too]
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Jim Mattson <jmattson@google.com>
