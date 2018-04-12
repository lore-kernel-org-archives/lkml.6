Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeDLBpF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:45:05 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:37653 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeDLBpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:45:03 -0400
X-Google-Smtp-Source: AIpwx4//HnoS7vb3SO/L36Ov3jQx9OCHvSsPoxlLk1Z2af39WnmEYgoZefvka/glZEDNQUSUHRjG9QG26m0MnMRR1p4=
MIME-Version: 1.0
In-Reply-To: <20180412013435.GA21219@altlinux.org>
References: <20180409152253.GD10489@altlinux.org> <20180412013435.GA21219@altlinux.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Apr 2018 18:45:02 -0700
X-Google-Sender-Auth: 58kMJeYFSd4_CeRqQpDm4uJ1Xao
Message-ID: <CA+55aFyzwzSH-fh9M1JLduq6dZXZZ9ZsyHUgJGSDeFZVy5_vtg@mail.gmail.com>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sparc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 6:34 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> There is a clear pattern of sneaking in ABI changes using innocently
> looking commit messages.

Yes, this siginfo stuff has been a mess.

Eric - this needs to stop. Or we need to revert all that garbage entirely.

Send a fix. And stop changing the siginfo layout or field values.

                 Linus
