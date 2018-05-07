Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeEGNkm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:40:42 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:41274 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeEGNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:40:38 -0400
X-Google-Smtp-Source: AB8JxZqYgXAVH278pxfNq4FUNE313Y9WzngQ9vt4+k7huB2TL6aApdi/BI6KEx2NSHf0trMLADS0Yg==
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
From: Rob Landley <rob@landley.net>
Message-ID: <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net>
Date: Mon, 7 May 2018 08:40:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 06:00 AM, John Paul Adrian Glaubitz wrote:
> I have been able to boot my own kernel on my USL-5P device, but
> I could never get it to detect the IDE controller. Do I need
> an additional patch for that?

On a related note, is there a list of boards anywhere? I'm working on a 7760
system at $DAYJOB, Rich has a landisk which according to
https://www.openbsd.org/landisk.html is an SH7751R, and Sato-san says that
QEMU's -r2d emulates that too? ("RTS7751R2Dplus is QEMU-SH4 target. So easy
trying.")

What other boards do we need to covert to device tree? arch/sh/boards has 15 C
files and 19 subdirectories, but I dunno the status of any of them...

Rob
