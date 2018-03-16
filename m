Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeCPWT0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:19:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40345 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:19:24 -0400
X-Google-Smtp-Source: AG47ELvtxBI2zGAFeqziCLyayfAHHc3mird5VJ3cbleRaqV4xc0KSyuuUjSm9Y5S6reFeyrA+M9A1g==
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RelNotes: add details on Perl module changes
References: <20180316220748.4279-1-tmz@pobox.com>
Date: Fri, 16 Mar 2018 15:19:21 -0700
In-Reply-To: <20180316220748.4279-1-tmz@pobox.com> (Todd Zullinger's message
        of "Fri, 16 Mar 2018 18:07:48 -0400")
Message-ID: <xmqqd103zms6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Document changes to core and non-core Perl module handling in 2.17.
> ...
> Maybe something like this?  I had intended to suggest a note about
> NO_PERL_CPAN_FALLBACKS as well, so that's included too.

Thanks.  A help like this in individual areas from people more
familiar than I am is greatly appreciated.
