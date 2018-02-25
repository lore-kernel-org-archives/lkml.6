Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeBYAFY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 19:05:24 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:51276 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbeBYAFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 19:05:22 -0500
X-Google-Smtp-Source: AH8x226321jNuQXKmdhqykNknm7pButJBOBTZfz4MgWeJjKFc9iFzM9RtgiehFcUwW4AsDDFAX66KUQw9tXS+WV/Wi0=
MIME-Version: 1.0
In-Reply-To: <1519436776-2987-1-git-send-email-pbonzini@redhat.com>
References: <1519436776-2987-1-git-send-email-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2018 16:05:20 -0800
X-Google-Sender-Auth: XdTgw3gTUIopvz2A_7CBiAS0iX0
Message-ID: <CA+55aFxeFRsDB+DaDW+E1daFRgk4Ccy=Tmt7cPn2A-uCmqW1iw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.16-rc3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 5:46 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

This has 28 fixes that were committed one hour before you sent this email.

I pulled, but I think I'm going to unpull, just because I want an
explanation of how that could possibly have had sufficient testing for
the upcoming rc?

                    Linus
