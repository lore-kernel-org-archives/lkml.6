Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbeEGEE7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 00:04:59 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:42518 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeEGEE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 00:04:58 -0400
X-Google-Smtp-Source: AB8JxZok7amGNZJpp03oYs2WRkJ/D6w64bFgM2QR9riDJm5YvcSVk1ZfmZZXVECkcDqD/0pcAgAX6/DBmt6iNSlLgHU=
MIME-Version: 1.0
References: <20180504175935.104085-1-jannh@google.com>
In-Reply-To: <20180504175935.104085-1-jannh@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 07 May 2018 04:04:46 +0000
Message-ID: <CALCETrXeUs7ar_j1vzneyEayDB6EcXa_ceRnxL_F4rdmKSh6fQ@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: remove unused file
To: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 10:59 AM Jann Horn <jannh@google.com> wrote:

> commit da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
> left this file behind; nothing is using it anymore.

Acked-by: Andy Lutomirski <luto@kernel.org>
