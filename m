Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBIRaS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:30:18 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:35520 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeBIRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:30:16 -0500
X-Google-Smtp-Source: AH8x227GEb2j1PQWem4T9ayxgqfNuNV5ta90yqnuy1k+yZcEJkbpPks1NWSiQkxcUF20/t5dT3+jlOF2qrGfv7PIIUM=
MIME-Version: 1.0
In-Reply-To: <877erma4oy.fsf@intel.com>
References: <20180207172624.24555-1-corbet@lwn.net> <20180207172624.24555-6-corbet@lwn.net>
 <877erma4oy.fsf@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 09:30:14 -0800
X-Google-Sender-Auth: VeADo_Bd_krRaZ34UJXGdwf81Tk
Message-ID: <CA+55aFwULB0-ALeQP9jsbW0qbAkiSPnDw3smJEiZqU+VV=QrBg@mail.gmail.com>
Subject: Re: [PATCH 5/8] docs: kernel-doc: Move STATE_BODY processing to a
 separate function
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, tcharding <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 1:32 AM, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> +     # miguel-style comment kludge, look for blank lines after
>> +     # @parameter line to signify start of description
>
> The "miguel-style" always intrigued me, but its origin predates git
> history. Does anyone know?

It came with the original script in 2.3.52-pre1, somewhere around March 2000.

(Historical footnote: there was no actual 2.3.52 ever released - it
was supposed turn into 2.4, but there was a long line of 2.3.99-pre
kernels before that then finally happened early 2001).

But no, back then we didn't track things well enough to have an actual
reason. And even with git, we probably wouldn't have had a reason
since it came in the initial patch.

You'd have to go search emails if you really care. That "around March
2000" would at least give you a starting point for searches.

               Linus
