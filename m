Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbeDRLn6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:43:58 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:43690 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754004AbeDRLnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:43:53 -0400
X-Google-Smtp-Source: AIpwx49cXC9k+GwO2hIa/dDwO0S0b5fVcInMNfQQCYom5Y1SBgN1VUf85IsmBz97FZT3eT7ep2dMCsjNFmb2UxK5taQ=
MIME-Version: 1.0
From: AIAMUZZ <muzafsh.113@gmail.com>
Date: Wed, 18 Apr 2018 17:13:12 +0530
Message-ID: <CAC_t1utCe40bTZjC0DZ8BeOZ9ugGPtpsfWAWcB-L+CCgWjMvJw@mail.gmail.com>
Subject: sysrq option to save the boot log to a file for the purpose of
 troubleshooting booting issues ?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When the system boots i often encounter the boot process hanging. I
usually hit 'Ctrl+Alt+Del' to reboot.

After coming across Magis Sysrq option, i have even tried sysrq+b to
boot my system from the frozen boot state.

after repeated attempts when i successfully log into the system. I
don't find the unsuccessful boot attempts i previously had encounterd
in syslog or any other log files in ' /var/log/ ' forder.

As a result i am unable to identify the root cause of the boot freezes
my system experiences.

I would like to know if there is any 'sysrq' option that will enable
me to record/capture the boot message from the boot freeze which i can
later use to troubleshoot why the boot freeze's occurrence on my
system ?

If there is no such 'sysrq' option at present, wouldn't it be a great
idea to have an option that will help one to capture/save the system
boot messages to a file in ' /var/log ' folder each time he/she
encounters a boot freeze ?

thanks.
