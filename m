Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeBLF3T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:29:19 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:39504 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeBLF3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:29:17 -0500
X-Google-Smtp-Source: AH8x224Aoz2/rzy40EOVbKvjBZyGm4IX+L+oQ0FiHhiPffvGQdaJl9b+jPWj6KKVC/Y+XSOdh0r2B/qyTKZ4pXq5W6I=
MIME-Version: 1.0
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 12 Feb 2018 10:59:16 +0530
Message-ID: <CAMet4B62Ni3Q5OzNvxWVpSfiRkWu2K_20xX6sGBZbROK+9-ULg@mail.gmail.com>
Subject: Re: tg3 crashes under high load, when using 100Mbits
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanley Hsiao <stanley.hsiao@canonical.com>,
        Tim Chen <tim.chen119@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1C5TP0T029817

On Fri, Feb 9, 2018 at 10:41 AM, Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Hi Broadcom folks,
>
> We are now enabling a new platform with tg3 nic, unfortunately we observed
> the bug [1] that dated back to 2015.
> I tried commit 4419bb1cedcd ("tg3: Add workaround to restrict 5762 MRRS to
> 2048”) but it does’t work.
>
> Do you have any idea how to solve the issue?
>
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1447664
>
> Kai-Heng
>
Thank you for reporting. We will check and update you.
