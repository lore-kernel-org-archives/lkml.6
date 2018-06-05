Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeFEHNe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:13:34 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:42703 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeFEHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:13:32 -0400
X-Google-Smtp-Source: ADUXVKLqy/vChF6Z0hsUYvVwdrzZ3/s55ek9I4Vn1UyB1H5mdwO1YaRKfIltQJfZ3dQagqv/0YOiDa34car5B4NrZBo=
MIME-Version: 1.0
In-Reply-To: <20180604162224.555716895@linutronix.de>
References: <20180604162224.555716895@linutronix.de>
From: Song Liu <liu.song.a23@gmail.com>
Date: Tue, 5 Jun 2018 00:13:31 -0700
Message-ID: <CAPhsuW4A_JdN0vB=X71y6bAuuKYMKTsKLo8BHafx28j_d6Rchw@mail.gmail.com>
Subject: Re: [patch 4/8] irq_remapping: Use apic_ack_irq()
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
