Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937083AbeE3DWL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:22:11 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33261 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754164AbeE3DWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:22:05 -0400
X-Google-Smtp-Source: ADUXVKJzdVVKygt8xIRhRSZa5buuUaPHxDRL4ZU/yFHJaNwRdx78DhmQ2n8W+JrFTUQdC/+YTyKDPIourzAgpaThhF0=
MIME-Version: 1.0
References: <20180529233834.GA50727@dtor-ws>
In-Reply-To: <20180529233834.GA50727@dtor-ws>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 May 2018 22:21:53 -0500
Message-ID: <CA+55aFzc_gZ15Qg3BAoSgALbgTepnQmAnzNb+1w9U8OUxjjVvQ@mail.gmail.com>
Subject: Re: [git pull] Input updates for v4.17-rc7
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 6:38 PM Dmitry Torokhov <dmitry.torokhov@gmail.com>
wrote:

>     We are switching a bunch of
> Lenovo devices with Synaptics touchpads from PS/2 emulation over to
> native RMI/SMbus.

> Given that all commits are marked for stable there is no point delaying
> them till next release.

Hmm. The elan driver stack overrun isn't mentioned, but seems more
fundamental fix than the other changes that just add a few new PnP ID's...

            Linus
