Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeA3WDG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:03:06 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35197 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeA3WCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:02:46 -0500
X-Google-Smtp-Source: AH8x227pvflsTAxR3aIsj9FWHJU2XmVrYsqowEWuYfAH1knHAnaGpfO5uvRHCZ4KyPNVN4rQYf98nxf8F5tNMiwOg+Y=
MIME-Version: 1.0
In-Reply-To: <20180130192636.sctfdnedffxv7vmv@armageddon.cambridge.arm.com>
References: <20180130192636.sctfdnedffxv7vmv@armageddon.cambridge.arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2018 14:02:45 -0800
X-Google-Sender-Auth: ChKaMlRb5vakYGSLJBqO-nJL34M
Message-ID: <CA+55aFxwU54sa=b=kE0pCromBJAQRhYqCwkJZXy9vDqY2D=kJw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 4.16
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:26 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

I got some fairly trivial conflicts on the merge, and I expect them to
be fine but since I don't do a build/boot test on arm64 somebody
should verify that.

                   Linus
