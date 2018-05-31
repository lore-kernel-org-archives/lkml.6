Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeEaKHV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:07:21 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:46724 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754271AbeEaKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:07:20 -0400
X-Google-Smtp-Source: ADUXVKKTLEo1reC3KlD/7q/8dQACHXawkoBwAriX+8vpy23UAtlSzGRNR4tYPd2LtOQ7XgwMvIfbjMGb6J8AbAAtSWQ=
MIME-Version: 1.0
From: Vishnu Motghare <vishnumotghare@gmail.com>
Date: Thu, 31 May 2018 15:37:18 +0530
Message-ID: <CADSz7_dsv91M4tsuxpxtA+_gdX34gYes6u8UnbGz9Jzgit2zqA@mail.gmail.com>
Subject: How to print stack uses of IRQ in ARM64
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found this discussion (https://lwn.net/Articles/657969/) regarding
implementation of separate IRQ stack for  ARM64.

My understanding is each CPU  getting its own IRQ stack. So is it
possible to print the stack uses of each IRQ handler? like, How much
stack is used & how much left free ?

like in process context we have API like stack_not_used(struct
task_struct *p) to get the unused stack  of processes. So, is it
possible to get the similar result for IRQ?
