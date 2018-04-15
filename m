Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeDOHr3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 03:47:29 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33183 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeDOHr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 03:47:28 -0400
X-Google-Smtp-Source: AIpwx49A/7ZwCiwrfXH1/qsam3hTulqcQh6JhN8EGPbb8Yytjh30nej42XKXikbzXn4RbJ47GcGKJJ4ZQEo1tFDsguQ=
MIME-Version: 1.0
From: Ivid Suvarna <ivid.suvarna@gmail.com>
Date: Sun, 15 Apr 2018 13:17:27 +0530
Message-ID: <CABXF_ACzu=+AKYqPyZwFzFw95KrczVEKaYifmOVuv=YhsvcTtQ@mail.gmail.com>
Subject: Softlockup and Hardlockup sample test module
To: Kernel development list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Could you please provide some sample test module for causing a
Softlockup and Hardlockup in latest kernel for SMP for testing
purposes. I assume there are some Kconfigs to be enabled as well for
this.

I had tried with the module where I put a busy loop inside spinlock
but was not able to cause any lockups. Maybe this is because of SMP
which schedule the job to other CPU. "How do I make a task to run on
single CPU only?"

I only get RCU stalls sometimes instead of softlockup when I use busy
loop inside a spinlock. Is there any explanation for difference
between these stalls and softlockup.

Thanks,
IVID
