Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeFAQCE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:02:04 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:44283 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeFAQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:02:00 -0400
X-Google-Smtp-Source: ADUXVKKrVp5IC+aD8OiQhtSzCsDpmq90vM/0mi6ApmZnSWrQPEwJ3ToBPxwSR7AYz8jh5qxeew/81S2tu2yYKtjC/3E=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 1 Jun 2018 18:01:58 +0200
Message-ID: <CA+icZUVkajCqc0Opg3EB8Jg915Nu4mCjgmU54twLeBrq3hHvgg@mail.gmail.com>
Subject: module: x86/modules: Skipping invalid relocation target, existing
 value is nonzero for type 1
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can someone tell me what this exactly means?

What is the root cause for this?
GNU binutils/ld?
Compiler?
Curently I test with clang-7.
VirtualBox and compiler incompatible?

Steps to reproduce the failure...

root# modprobe -v vboxdrv
insmod /lib/modules/4.14.47-1-iniza-llvmlinux/updates/dkms/vboxdrv.ko
modprobe: ERROR: could not insert 'vboxdrv': Exec format error

root# dmesg | tail -1
[13437.021825] module: x86/modules: Skipping invalid relocation
target, existing value is nonzero for type 1, loc ffffffffc1453360,
val ffffffffc142f8a2

Tanks in advance.

Regards,
- Sedat -
