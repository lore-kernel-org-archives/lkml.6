Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933384AbeBMDcx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 22:32:53 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:38608 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933323AbeBMDcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 22:32:51 -0500
X-Google-Smtp-Source: AH8x227dpTtR873M7mnWtHBqPwq37XtX7reZinjtfXRi/saRlLOgasqTSSD5UJ92Gx6Ld4De53R3qg==
To: linux-kernel@vger.kernel.org
From: Aidan Hahn <aidanjacobhahn@gmail.com>
Subject: Linux input driver issue with Elan touchscreen on 4.15 and 4.16-rc1
Message-ID: <7927412e-ad49-f682-e62c-29e060df6799@gmail.com>
Date: Mon, 12 Feb 2018 19:32:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a kernel.org bug 
(https://bugzilla.kernel.org/show_bug.cgi?id=198715) that I am trying to 
raise the visibility of.

The documentation on Bug Reporting mentioned emailing this list with my 
issue so I figured I would post about it here.

I am running an HP Envy x360 powered by a Ryzen mobile chip and I am 
having trouble getting the touchscreen to work. I have attached DMESG 
logs from kernel 4.15 and 4.16 to the bugzilla ticket and I also decided 
to upload a disassembled ACPI table after reading the following email 
thread that is related to the issue I am having 
(https://www.spinics.net/lists/linux-input/msg50784.html)

Thank you,
Aidan Hahn
