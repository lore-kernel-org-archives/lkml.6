Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeC0Bqz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:46:55 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:38258 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeC0Bqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:46:54 -0400
X-Google-Smtp-Source: AIpwx4/RpranXqsZOLLyb0ZKt5JPgl2U7WRGzfD5AFZi0b8HrX3boDboxEvYyCKvIBS0FBp3YhYh98vG+pPKGlFgNK8=
MIME-Version: 1.0
From: =?UTF-8?B?6rCV7LKg7Zi4?= <kbright0912@gmail.com>
Date: Tue, 27 Mar 2018 10:46:12 +0900
Message-ID: <CAGUTK8hiRd6GSp-_1yEph4ZM2tt=KGby3U0zzHJ+XvOKh_JN9A@mail.gmail.com>
Subject: [DM-Delay] How can I reduce the granularity from mili-sec to nano-sec?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R1l1o7007260

To whom it may concern,

Hello, this is Chulho Kang at Seoul National University, the Republic of Korea.
I have a question regarding dm-delay component.

I know this implementation has a limited delay granularity (1ms)
I hope to emulate devices with sub-millisecond delays through the
high-resolution Linux timers.

Could I ask you for advice?
I want to try out this component to “storage performance analysis”
that I’m researching
My aim is to emulate SSD devices latency of being reduced from
mili-sec to nano-sec on
ramdisk using dm-delay.

Best regards,
- Chulho Kang
