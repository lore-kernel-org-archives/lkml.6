Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938076AbeBUO6T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:58:19 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:44801 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932826AbeBUO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:58:18 -0500
X-Google-Smtp-Source: AH8x225gutf9pMFDZ15Fba5mLU4ROaIz+XS3agUvMO8Ev4mfZKAlfldyJQToRRG9q0eJ2UqrsSdiR5eeoOvXnkIYU6M=
MIME-Version: 1.0
In-Reply-To: <20180220225425.40682-1-bbellevi@uci.edu>
References: <20180220225425.40682-1-bbellevi@uci.edu>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 16:58:16 +0200
Message-ID: <CAHp75Vc9GLy+GoVQb28K9mNREPFR3oD_uVaAWCQXSGmZ+EA+-w@mail.gmail.com>
Subject: Re: [PATCH] floppy: Don't print kernel addresses to log in show_floppy
To: Brian Belleville <bbellevi@uci.edu>
Cc: Jiri Kosina <jikos@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 12:54 AM, Brian Belleville <bbellevi@uci.edu> wrote:
> Outputting kernel addresses will reveal the locations of kernel code
> and data. Change the cases in show_floppy that print
> fd_timer.work.func and fd_timeout.work.func to use the %pf format
> specifier, which will print the symbol name, like what is done for the
> other function pointers printed by show_floppy. No longer output the
> value of cont. The variable cont is a pointer that can hold the
> address of kernel global variables.

Perhaps you missed %px introduction and hashing pointers otherwise.

OTOH I don't give a crap about floppy.

-- 
With Best Regards,
Andy Shevchenko
