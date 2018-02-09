Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeBIFLO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 00:11:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55530 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeBIFLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 00:11:12 -0500
X-Google-Smtp-Source: AH8x227YBeQr+PFSeOn076T7C+62tJH0+adf3FDLbdQyWFOxQhN32yLFyppdgpQB/kwslgjY3gy49Q==
From: Kai Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.9\))
Subject: tg3 crashes under high load, when using 100Mbits
Message-Id: <AC2EED55-6D9F-4942-B1E4-A515FA283D6C@canonical.com>
Date: Fri, 9 Feb 2018 13:11:05 +0800
Cc: netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanley Hsiao <stanley.hsiao@canonical.com>,
        Tim Chen <tim.chen119@canonical.com>
To: siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com
X-Mailer: Apple Mail (2.3445.6.9)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Broadcom folks,

We are now enabling a new platform with tg3 nic, unfortunately we observed  
the bug [1] that dated back to 2015.
I tried commit 4419bb1cedcd ("tg3: Add workaround to restrict 5762 MRRS to  
2048”) but it does’t work.

Do you have any idea how to solve the issue?

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1447664

Kai-Heng
