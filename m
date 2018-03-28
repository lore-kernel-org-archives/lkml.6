Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeC1ApU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:45:20 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33535 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeC1ApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:45:18 -0400
X-Google-Smtp-Source: AIpwx4+iuLSPzCtfNNnPZPeHanxqa22wLTm/CsbvYAI72L0LH9MywLiA85pp2YFTNfpBpgI6STye0oMD/g8t9ZiTl/c=
MIME-Version: 1.0
In-Reply-To: <20180327162956.ocafdhbbuwtaphi5@linux-n805>
References: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
 <20180326002732.qks4cp7qq2xzysnx@linux-n805> <CANRm+CxaDNcVdySSH7O3ikyhbmpO9ZVGRx9GxL2gi28s9RoqVQ@mail.gmail.com>
 <20180326223232.ifaoc3zyjii4gq2f@linux-n805> <CANRm+Cw=x1YVSpX1Zcz=EkLFhojSa_zyTOLEiNX-Di3ENGmCiA@mail.gmail.com>
 <20180327162956.ocafdhbbuwtaphi5@linux-n805>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 28 Mar 2018 08:45:17 +0800
Message-ID: <CANRm+Cx2zUQKSnL4CS1XTqwC-uUpMHxe3M-_80RQCy0Ui-oKBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: X86: Fix setup the virt_spin_lock_key before
 static key get initialized
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Radim Kr??m???" <rkrcmar@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-28 0:29 GMT+08:00 Davidlohr Bueso <dave@stgolabs.net>:
> On Tue, 27 Mar 2018, Wanpeng Li wrote:
>
>> The host admin can control it by qemu command-line, -cpu
>> ...+kvm-hint-dedicated
>
>
> So this requires qemu code modification, no?

Yeah, https://git.qemu.org/?p=qemu.git;a=commitdiff;h=be7773268d98176489483a315d3e2323cb0615b9

Regards,
Wanpeng Li
