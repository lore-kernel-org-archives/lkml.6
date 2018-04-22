Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeDVRvg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:51:36 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:46060 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeDVRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:51:35 -0400
X-Google-Smtp-Source: AB8JxZr1vQKaQvo7/kM8DpHF3R2KKxOcBt5krVCaKjN17Mbxl94tCeg3kG8Edj2Q9a7xLIhqyXsDsva04DhDcTBHBlQ=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804221251260.6136@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1804221251260.6136@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Apr 2018 10:51:34 -0700
X-Google-Sender-Auth: I66v3qnBTk3lvYSLvYNz6U4PG6Q
Message-ID: <CA+55aFwLa72-0n4PQj5A2ruGCPSyRS7cJM3Z+wKCO9_TCn7YnQ@mail.gmail.com>
Subject: Re: [GIT pull] x86 fixes for 4.17
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 4:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A small set of fixes for x86:

Hmm. Not the fixes for the global bit problems that caused a couple of
pretty bad issues?

I realize that they wanted testing, but considering how bad the
current situation is...

               Linus
