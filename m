Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeFEHNz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:13:55 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:37183 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeFEHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:13:52 -0400
X-Google-Smtp-Source: ADUXVKIO320ne7W2P4A4dl+HckF5fFAT99pPt+ptKLLRBzU691383uarq9kSLFdNrmgoILJhBvnj5f6vdytKPzLDJVQ=
MIME-Version: 1.0
In-Reply-To: <20180604162224.721691398@linutronix.de>
References: <20180604162224.721691398@linutronix.de>
From: Song Liu <liu.song.a23@gmail.com>
Date: Tue, 5 Jun 2018 00:13:52 -0700
Message-ID: <CAPhsuW4awnVMDiqgkKkjz2XXerXMcn5BX-23TrtPnVjG1OEt1g@mail.gmail.com>
Subject: Re: [patch 6/8] x86/platform/uv: Use apic_ack_irq()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Song Liu <songliubraving@fb.com>

On Mon, Jun 4, 2018 at 8:33 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
