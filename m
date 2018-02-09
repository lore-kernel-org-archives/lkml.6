Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeBIT22 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:28:28 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33144 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbeBIT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:28:25 -0500
X-Google-Smtp-Source: AH8x224dlr7TJU2m1YEL4+P4thwedqSGw/M5X0KX/aFjot2jsdj7GOXsoGSsEUo+MsuOjaZbYWXKlvTZlz4JHABIcd4=
MIME-Version: 1.0
In-Reply-To: <20180209180222.qsi7jcw7pj442rpo@linutronix.de>
References: <20171226102940.26908-1-ard.biesheuvel@linaro.org> <20180209180222.qsi7jcw7pj442rpo@linutronix.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 9 Feb 2018 19:28:23 +0000
Message-ID: <CAKv+Gu9o7k0jrrc0jHYUbcJ2k+pmo4N-PHYEZrr_vj=nx-3Z+g@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] crypto: arm64 - play nice with CONFIG_PREEMPT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>, linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w19JSkl2020083

On 9 February 2018 at 18:02, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-12-26 10:29:20 [+0000], Ard Biesheuvel wrote:
>> As reported by Sebastian, the way the arm64 NEON crypto code currently
>> keeps kernel mode NEON enabled across calls into skcipher_walk_xxx() is
> …
>> So let's clean this up for arm64: update the NEON based skcipher drivers to
>> no longer keep the NEON enabled when calling into the skcipher walk API.
>
> Thanks for working on this.
> What is the status of this? Is this going to be merged?
>

Without anybody acking or reviewing it, this is not going to be
merged, so I kind of gave up.
