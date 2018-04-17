Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeDQIA1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:00:27 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:39906 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeDQIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:00:26 -0400
X-Google-Smtp-Source: AIpwx48y4ftHZwfktuHds9yMsFk4iZ/JrhPnnfscs8ZN42B3JqPU5yogv5O7Tw2H9YwGHA9y6R5ElkqyGLn6/2btzEw=
MIME-Version: 1.0
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date: Tue, 17 Apr 2018 10:00:25 +0200
Message-ID: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
Subject: 4.17.0-rc1 doesn't boot.
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3H80iPS029116

Hi,
my notebook doesn't boot with 4.17.0-rc1. Booting stops right after
displaying "loading initial ramdisk..". No further displays.
Also nothing is wriiten to the logs.

First known bad kernel is: 4.16.0-12564-g6b0a02e
Last known good kernel is: 4.16.0-12548-g71b8ebb

Maybe the problem came in with:
6b0a02e:  "Merge branch 'x86-pti-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip"


Thanks, Jörg
