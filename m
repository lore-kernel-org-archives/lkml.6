Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeAaTbA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 14:31:00 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:51590 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeAaTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:30:59 -0500
X-Google-Smtp-Source: AH8x226HOkBaGOkKKCidIKfXRI2Jga3JHrI30LAfmPaQ9OzrowTtERvx0SCgC7CYjjbHPBItpUvkNAnNqLPmn+PZPsw=
MIME-Version: 1.0
In-Reply-To: <87607im26i.fsf_-_@xmission.com>
References: <87372oph61.fsf@xmission.com> <87a7wwnkce.fsf@xmission.com> <87607im26i.fsf_-_@xmission.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jan 2018 11:30:58 -0800
X-Google-Sender-Auth: pHJrp32gLI_J-V1zubSJj1Q37pk
Message-ID: <CA+55aFz+uhHRRDPHW_OU+MXmrpKdE3Eb=okczd5_0STaTDe8sQ@mail.gmail.com>
Subject: Re: [GIT PULL] siginfo fix for 4.16-rc1
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 8:19 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I had a brain fart when I received Stephen email about a compile failure
> in linux-next.  I thought the powerpc call to memory_failure had not
> merged yet.  Instead it simply failed to compile :(
>
> Linus can you please pull Stephen's fix so that powerpc builds correctly.

I fixed this up in the merge already, afaik. Or is there some other failure?

                     Linus
