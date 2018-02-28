Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeB1DPb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 22:15:31 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33534 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeB1DPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 22:15:30 -0500
X-Google-Smtp-Source: AG47ELtEDMl8LQa36lC0LwC0Q5OJDT5GYVO2fLsRjfLyFw2d2YvnCWQFklqbnAjs0BLQVDtz4ru1wK+jSbW/znEmu9s=
MIME-Version: 1.0
From: Hanasaki Jiji <hanasaki@gmail.com>
Date: Tue, 27 Feb 2018 22:14:49 -0500
Message-ID: <CAMr-kF1SUVg1VCa2ZWS_iFnJGEBcmk6JOnzcBG_Xthb3Q2fEHw@mail.gmail.com>
Subject: 4.15.6 : .config does not find boot partition
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default .config created from make menuconfig builds fine and boots fine.

The config at the below URL times out trying to boot the root
partition.  Then ls /dev does not show the disks

This is a UEFI system that also boots fine with the standard debian
kernel install.

config at https://pastebin.com/iuSLBGMX

Thank you.
