Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034306AbeEXSVv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:21:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37615 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034293AbeEXSVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:21:44 -0400
X-Google-Smtp-Source: AB8JxZoS3o2UmVIetmWLSQbkT4NOVZue948Cl8VZQVHHLVl/be1FIDbhOLJJ/PWSDh1+BSDDJbSyKO8WhOHdr3XiSVc=
MIME-Version: 1.0
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524135240.10881-1-peda@axentia.se>
In-Reply-To: <20180524135240.10881-1-peda@axentia.se>
From: John Sperbeck <jsperbeck@google.com>
Date: Thu, 24 May 2018 11:21:31 -0700
Message-ID: <CAFNjLiVZ+g6eeHjpwMm+KiAA69Kpm_nVjWxkm2wCuV58RZwj4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Re: Problem: lockdep warning with nested instances
 of i2c-mux
To: peda@axentia.se
Cc: linux-kernel@vger.kernel.org, wsa@the-dreams.de, peterz@infradead.org,
        mingo@redhat.com, will.deacon@arm.com, dave@stgolabs.net,
        pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 6:52 AM Peter Rosin <peda@axentia.se> wrote:

> Hi!

> Sorry for spamming. At least I'm finding these embarrassing f$&%ups
> myself, not that it helps all that much, but...

> Changes since v2    https://lkml.org/lkml/2018/5/24/176
> - EXPORT_SYMBOL_GPL(rt_mutex_lock_nested) is more appropriate (the
>    rt_ prefix was missing).


Yes, after fixing the "rt_" typo, this addresses our use case.  Thanks for
the quick response.
