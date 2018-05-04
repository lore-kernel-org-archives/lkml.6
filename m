Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEDKKt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:10:49 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:39967 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeEDKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:10:47 -0400
X-Google-Smtp-Source: AB8JxZracSk4WaD/nWHdvQHFT2iUBJzdZ/kXbsDsatrrFmg1YUW5ADYPuubhZ4NeANdD3Ql/uHMm8XlYfepvIp7Oses=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 May 2018 12:10:46 +0200
X-Google-Sender-Auth: o7-pt5K5KMhYkBrFHEezrmRw1WE
Message-ID: <CAJZ5v0h_9dJ3Hcen7J759-=qHW-c4f9mntMMRi2pNhgK1j5ZtQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.17-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.17-rc4

with top-most commit 755396163148b50fe1afb4bdd3365e47f3ff7a42

 tools: power/acpi, revert to LD = gcc

on top of commit 6da6c0db5316275015e8cc2959f12a17584aeb64

 Linux v4.17-rc3

to receive an ACPI tools fix for 4.17-rc4.

This fixes an ACPICA utilities (acpidump) build regression from the
4.16 cycle by setting LD in the CFLAGS passed to the linker to $(CC)
again (Jiri Slaby).

Thanks!


---------------

Jiri Slaby (1):
      tools: power/acpi, revert to LD = gcc

---------------

 tools/power/acpi/Makefile.config | 1 +
 1 file changed, 1 insertion(+)
