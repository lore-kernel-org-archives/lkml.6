Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755913AbeD3UOP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:14:15 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36600 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755548AbeD3UOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:14:12 -0400
X-Google-Smtp-Source: AB8JxZppqyi7YhSF47ECLdTuYtBZC7hQyk40MuQeAYi/aoIuyDkMWja6plLClGMITDdGNLgcBBE6ZGLlR3I8MufDkuw=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From: tedheadster <tedheadster@gmail.com>
Date: Mon, 30 Apr 2018 16:13:51 -0400
Message-ID: <CAP8WD_YwYbYs-c+DpuuvAT0MiDDt9cRoTChmRSdPG9r_4+oQcA@mail.gmail.com>
Subject: sar reporting zero cpu usage for everything
To: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas and Steven,
  I am running the 4.16 kernel and I found some odd behavior in sar.
It shows zero usage time in ALL categories.

12:12:36        CPU     %user     %nice   %system   %iowait    %steal     %idle
12:34:10        all      0.00      0.00      0.00      0.00      0.00      0.00
12:58:04        all      0.00      0.00      0.00      0.00      0.00      0.00
13:06:01        all      0.00      0.00      0.00      0.00      0.00      0.00

This is run every two minutes via cron with '/usr/lib/sa/sa1 30 4 -S DISK'.

You both helped me before with a similar problem, so I thought I would
ask you first for a place to start debugging this.

(apologies, had to be re-sent in text-only mode)

- Matthew Whitehead
