Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeEaKBs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:01:48 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37904 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754453AbeEaKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:01:41 -0400
X-Google-Smtp-Source: ADUXVKIOZgYCEOINXqMvgIiuO/XNAidDILGEz4xYt6FF4bo2JYEIB7ktvgMyqNF/ExQ6/ykEgcq3JVicNFra/oYOSjA=
MIME-Version: 1.0
From: Vishnu Motghare <vishnumotghare@gmail.com>
Date: Thu, 31 May 2018 15:31:39 +0530
Message-ID: <CADSz7_cqdKnmOm07Ykv5L9d2qscfKNmf7Vz=yW2Nf8PWsnsJaA@mail.gmail.com>
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
