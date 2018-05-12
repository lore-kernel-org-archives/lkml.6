Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbeELI1J (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 04:27:09 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:43290 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeELI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 04:27:07 -0400
X-Google-Smtp-Source: AB8JxZo222xP+TYF8wYQfsXxWss7vr22VkTXPMj+5Cf+MzHXJCz35abuTzxlk2fOrfK3pM3djkzeV/3GPLu8r6NRmh8=
MIME-Version: 1.0
From: Weiwei Jia <harrynjit@gmail.com>
Date: Sat, 12 May 2018 16:27:04 +0800
Message-ID: <CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com>
Subject: [RFC][PATCH] KVM: APPLES can improve the performance of applications
 and virtualized systems by up to 49%
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, xen-devel@lists.xenproject.org, dingxn@gmail.com,
        jianchen.shan@gmail.com, Weiwei Jia <harryxiyou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Recently, we made a few improvements on effectively utilizing Pause
Loop Exiting (PLE) support for higher throughput on virtualized
systems. Basically, it solves two problems: 1) how to adjust
PLE_Window; 2) how to select virtual CPUs to schedule on VM_EXITs
caused by PLE. Our tests with standard benchmarks show that the
approach can improve performance by up to 49%. The approach shows
promising performance and is easy to implement. We think that it would
be wonderful if Linux/KVM and XEN can consider the approach.

We already have a prototype implementation based on KVM (Linux Kernel
3.19.8). Our patch for Linux Kernel 3.19.8 and the paper describing
our idea are available in Github repository [1][2][3]. We are pleased
to revise our patch in order to merge it into Linux/KVM and XEN. We
hope that you can test and adopt our approach/techniques. We are
pleased to get some comments/suggestions on the approach and on how
the idea can be adopted/tested by Linux/KVM and XEN. Thank you.

[1] APPLES paper: https://github.com/sysmen/apples/tree/master/paper
[2] APPLES patch:
https://github.com/sysmen/apples/blob/master/patches/3.19.8-APPLES.patch
[3] APPLES patch README:
https://github.com/sysmen/apples/blob/master/patches/README.txt

Best Regards,
Sysmen Research Group
