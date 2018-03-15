Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeCORvK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:51:10 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:55048 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeCORvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:51:07 -0400
X-Google-Smtp-Source: AG47ELtFIkGFAyuhZDHgE+M9OGRJDFaT1TthTMw+IEriZrhOe9OA0UvbQUfJd13kHwy8uLBc5F2+o+/8HqbNOK/AGnk=
MIME-Version: 1.0
In-Reply-To: <20180315154448.16222-1-bp@alien8.de>
References: <20180315154448.16222-1-bp@alien8.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 10:51:06 -0700
X-Google-Sender-Auth: obCg6CKmU8oBeCmWMKU8gNpWRMc
Message-ID: <CA+55aFyvwdG49eCgX9Bs9UGEo4VWgS7dY6ZuEkBuugxTR58GnA@mail.gmail.com>
Subject: Re: [PATCH 0/9] x86/dumpstack: Cleanups and user opcode bytes Code:
 section, v2
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 8:44 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> here's v2 with the dumpstack cleanups. This one gets rid of code_bytes=
> as it was discussed last time. As a result, the code got even leaner and
> simpler. I like that. :)

This version looks ok to me. I'm sure there's room for tweaking here,
but I'm not seeing anything alarming.

               Linus
