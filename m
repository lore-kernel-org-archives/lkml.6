Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeDIRP2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:15:28 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:40656 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeDIRP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:15:27 -0400
X-Google-Smtp-Source: AIpwx4/OScveLCwVTgRN6PBxyuKwdAxa2xAvagRVKCIeiqizDc71sENLBaUKM4odtLjsMKVOAueEbD6LzwZIjilncVY=
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1804091909270.1698@schleppi>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
 <alpine.LFD.2.21.1804091809310.1698@schleppi> <CA+55aFw1MoQ=7=U6QCGXAAiCniMKy8_igxgc8sMLykSRcDk-0g@mail.gmail.com>
 <alpine.LFD.2.21.1804091909270.1698@schleppi>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 10:15:25 -0700
X-Google-Sender-Auth: soBz1dLNNpMEjJjKn08KSB3vBFk
Message-ID: <CA+55aFy5tYQjBWCiEqjBjkWhPe7_DzdCTN8X9QfsDescepBFSg@mail.gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on s390
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 10:11 AM, Sebastian Ott <sebott@linux.ibm.com> wrote:
>
> Argh....so obvious now :-)
>
> When I change these it works.

Mind testing the slightly more complex patch I just emailed out, and I
can commit it?

               Linus
