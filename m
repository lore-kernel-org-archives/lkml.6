Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeA3UbQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:31:16 -0500
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:43807 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752298AbeA3UbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:31:13 -0500
Message-ID: <1517344262.2230.27.camel@tiscali.nl>
Subject: Re: [PATCH] kconfig: Warn if help text is blank
From: Paul Bolle <pebolle@tiscali.nl>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Date: Tue, 30 Jan 2018 21:31:02 +0100
In-Reply-To: <CAFkk2KSUpEvCCt0fUzCN+r7Lz9CuyN3jKV6atpPR92zPRK4f-w@mail.gmail.com>
References: <20180130181853.32512-1-ulfalizer@gmail.com>
         <1517337292.2230.15.camel@tiscali.nl>
         <CAFkk2KSUpEvCCt0fUzCN+r7Lz9CuyN3jKV6atpPR92zPRK4f-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEAnD93OMt0DtXVP+uiKtYnxDhbg2ay+QjVNdy6mrIfm9yjc/LZjUTap7ktEzC3pf2KKxXBWfv+7CiEVLFKEwoO3dKiY5FwC+SbNrlPU1VggfpWKkArR
 NpgK3sk+j3mDdawkVLdngX3LjmbgE/jqwK7Z1CtBkKKPyYn0PBlkmV3wfL7LZ9EqC387poAZmMXlBMbQAqnSLwmEiZWdnZ0m8CeDN5rAgJ0p2N9Uu00tSwS5
 ny8fVHJ6xnAmqYTCvzQhqXZsNmPp7BmWGskG7naIUyCjFuGNt7OdSQtuwmyCLH4RZSm8793Fs3V/JoYls1KN02T/gx4Hh9ezQoiFoKwCrs0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-30 at 20:33 +0100, Ulf Magnusson wrote:
> I agree that this shouldn't go in until/unless a significant portion
> of those empty help texts get removed first.

Not a significant portion, but all, I'd say.

> The patchset that removes the empty help texts is at
> https://lkml.org/lkml/2018/1/30/574. I could make another one if you'd
> prefer that.

I'm fine with anything that doesn't add warnings just to appease pet peeves.

> I haven't even checked how they are rendered to be honest. I was more
> concerned with the Kconfig mess.

Well, if you could make empty help texts disappear somehow (either during the
Kconfig parse phase - which requires a jump into the yacc horror - or during
the rendering phase) that would be much better than adding a warning for
something that you yourself described as a pet peeve.

And after that's done you're free to send cleanup patches for this whenever
you feel like doing so.

Thanks,


Paul Bolle
