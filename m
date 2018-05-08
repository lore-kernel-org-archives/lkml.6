Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755133AbeEHNpX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:45:23 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33100 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbeEHNpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:45:22 -0400
X-Google-Smtp-Source: AB8JxZoIsVmpKH2D5PcICxBoAN+2ZiUQ9/UcJ8y8EipVFpBmPBl5SNGEOKATOvRjGfqHnybI0HZ29nuGfBPnDqR820I=
MIME-Version: 1.0
In-Reply-To: <737baa062b19428816afc1fccf3bca03210b45c5.1525673368.git.nickhu@andestech.com>
References: <cover.1525673368.git.nickhu@andestech.com> <737baa062b19428816afc1fccf3bca03210b45c5.1525673368.git.nickhu@andestech.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 8 May 2018 21:44:40 +0800
Message-ID: <CAEbi=3dF+EAGUKYFwg7vN_gTi1hWYiP14j9YUb8nxwgU9NFtjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nds32: Fix the unaligned access handler
To: Nickhu <nickhu@andestech.com>
Cc: Greentime <greentime@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Vincent Chen <vincentc@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-07 14:45 GMT+08:00 Nickhu <nickhu@andestech.com>:
> If the kernel config 'CONFIG_ALIGNMENT_TRAP' and the file
> '/proc/sys/nds32/unaligned_access/enable' are set, the kernel
> unaligned access handler does not handle correctly when the
> value of immediate field is negative. This commit fixes the
> unaligned access handler in kernel.
>
> Signed-off-by: Nickhu <nickhu@andestech.com>

Thank you, Nick.
Reviewed-by: Greentime Hu <greentime@andestech.com>
