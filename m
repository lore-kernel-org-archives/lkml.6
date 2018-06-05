Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeFEHNp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:13:45 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:45126 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeFEHNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:13:43 -0400
X-Google-Smtp-Source: ADUXVKJHPCyeMt9Me5xwiv/V2e9e5dv/s7Y5oVbrVlBGRI+VGuYaZBvuLZEQ2mozVBETLXLAqE0goaAIzg5b+8c7Hfw=
MIME-Version: 1.0
In-Reply-To: <20180604162224.639011135@linutronix.de>
References: <20180604162224.639011135@linutronix.de>
From: Song Liu <liu.song.a23@gmail.com>
Date: Tue, 5 Jun 2018 00:13:42 -0700
Message-ID: <CAPhsuW4pO1qjfGrjbOraSeGMx=E0iaMMKdWXW=1ojadHyve3eg@mail.gmail.com>
Subject: Re: [patch 5/8] x86/ioapic: Use apic_ack_irq()
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
