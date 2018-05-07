Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeEGNuQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:50:16 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51415 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750937AbeEGNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:50:13 -0400
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
To: Rob Landley <rob@landley.net>,
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
 <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <3f06d7b8-7124-1b98-2f52-51951c6d7624@physik.fu-berlin.de>
Date: Mon, 7 May 2018 15:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 87.77.146.231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 03:40 PM, Rob Landley wrote:
> On a related note, is there a list of boards anywhere? I'm working on a 7760
> system at $DAYJOB, Rich has a landisk which according to
> https://www.openbsd.org/landisk.html is an SH7751R, and Sato-san says that
> QEMU's -r2d emulates that too? ("RTS7751R2Dplus is QEMU-SH4 target. So easy
> trying.")

I have lots of Dreamcasts (SH7091), one SH7785LCR evaulation board and one
SH7724 Evovec board. I also own one KMC KZ-SH3-03 (SH7708, SH-3) board and
several small SH-2 and SH-2A boards (from a Japanese electronics magazine).

I think Geert Uytterhoven has also one SH-4 board (if I remember correctly)
and one of the gcc upstream maintainers has an AP-SH4AD-0A board from Alpha
Project.

> What other boards do we need to covert to device tree? arch/sh/boards has 15 C
> files and 19 subdirectories, but I dunno the status of any of them...

Hard to say. At least the ones above plus the ST-40 boards should be included.

I would leave the rest in for the time being unless they become a burden
in any way.

First we should get Sato-san's LANDISK device tree conversion merged though
and maybe we can use this one as a template to convert the rest. I would
be happy to help.

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
