Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeEOAvs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:51:48 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34857 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeEOAvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:51:46 -0400
X-Google-Smtp-Source: AB8JxZpb3mep21UAF08A/wNAEoI4Y9K5WAsyyxl7aUB17OOOHzoAHdghrq+AyBekaxwBMefnT7SqctFxGe4tQtSSOaU=
MIME-Version: 1.0
From: Joshua Hudson <joshudson@gmail.com>
Date: Mon, 14 May 2018 17:51:45 -0700
Message-ID: <CA+jjjYTDCPSxDrK43yQA2BR8hSDSygW_aCggPL2D9VSPxKtWDg@mail.gmail.com>
Subject: USB Floppy Disk Driver
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4F0purf023303

Has anybody tried the USB floppy disk driver in awhile? I just did to
read an old disk, and I couldn't read a single byte.

I started thinking maybe the hardware's bad, but dd didn't raise en
error even after I pulled it out and got "USB Disconnect" on the
screen from kernel log.

I still don't know if the code is broken or if my hardware's bad. It
worked 15 years ago with a 2.6 series kernel.

Kernel version:

joshua@nova:~ϟ uname -a
Linux nova 4.9.0-6-amd64 #1 SMP Debian 4.9.82-1+deb9u3 (2018-03-02)
x86_64 GNU/Linux
joshua@nova:~ϟ
