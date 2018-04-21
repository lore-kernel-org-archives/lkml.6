Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeDUNk3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 09:40:29 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32961 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeDUNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 09:40:27 -0400
X-Google-Smtp-Source: AB8JxZpl52NJ6JRMdX+xmqm2K0oRGR9OAPfJCQmvWfjdH5YouY/Z4n5rO3xgacE96f0sdLLcq4RqsjIbjz3g9PlFjJk=
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 21 Apr 2018 19:10:26 +0530
Message-ID: <CAG=yYwnnVissybfqmJHgzGccMYDUnxtK+6OT_CRo6Yu1TzoGSg@mail.gmail.com>
Subject: POSSIBLE BUG: boot gets stuck and loads initramfs shell
To: linux@dominikbrodowski.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i did a new git pull on my mainline linux kernel repository
i did "make localmodconfig" and compiled
i got a boot failure related. i got message about not able to mount
filesystem. it then loaded the initramfs shell.

i recompiled the kernel with ext4 file system inbuilt (i mean not as a module )
then the system did not have that problem.

but i think the problem did not exist before even when the ext4 was compiled
as a module. i think the problem occurred after i compiled using "make
localmodconfig"


Linux debian 4.17.0-rc1+ #3 SMP Sat Apr 21 03:41:44 IST 2018 x86_64 GNU/Linux

GNU Make            4.2.1
Binutils            2.30
Util-linux          2.31.1
Mount                2.31.1
Linux C Library      2.27
Dynamic linker (ldd) 2.27
readlink: missing operand
Try 'readlink --help' for more information.
Procps              3.3.14
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                238





-- 
software engineer
rajagiri school of engineering and technology
