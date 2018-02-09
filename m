Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeBIWzv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:55:51 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:40470 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBIWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:55:49 -0500
X-Google-Smtp-Source: AH8x227VPztHwKQ2kvuwykRmPXQ3hPTcVjpIuhxzeTfoUOfJmwIpgSDSzgnuKBpilQ4+Xl/uXm8QUZaznqzPVTAxH1o=
MIME-Version: 1.0
In-Reply-To: <b12b9a53-2793-5317-bc59-535b615eb903@amazon.com>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
 <1517856451-2932-4-git-send-email-karahmed@amazon.de> <CALMp9eRhHfoy7cL0x3qUMOHn4DUacHGc_497ac1QMPbiGU9O5g@mail.gmail.com>
 <b12b9a53-2793-5317-bc59-535b615eb903@amazon.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 9 Feb 2018 14:55:47 -0800
Message-ID: <CALMp9eQPLwT5Fd2J_uKpW0OymbL6RQ1bSbsU=xXwbfP=sBFs9g@mail.gmail.com>
Subject: Re: [RFC 03/12] KVM/VMX: Use the new host mapping API for virtual_apic_page
To: KarimAllah Ahmed <karahmed@amazon.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 4:15 AM, KarimAllah Ahmed <karahmed@amazon.com> wrote:

> Can you elaborate a bit? I do not really understand what is the concern.

I can't find the posting that gave me this impression. The only thing
I can find is the following in Documentation/vm/highmem.txt:

 (*) kmap().  This permits a short duration mapping of a single page.  It needs
     global synchronization, but is amortized somewhat.  It is also prone to
     deadlocks when using in a nested fashion, and so it is not recommended for
     new code.

What constitutes a "short duration," and does this new usage qualify?
