Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeFDJYZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:24:25 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55329 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:24:23 -0400
X-Google-Smtp-Source: ADUXVKLQ1rKsp71XATpWoG2fyXtIdxHc33vwF67N1UotUcR8TkwQmUmlxyscMkCaR7SMfs4wO5TQ0w==
To: linux-kernel@vger.kernel.org
Cc: kacper.pluta@gmail.com
From: Kacper Pluta <kacper.pluta@gmail.com>
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Message-ID: <be50dd15-9e5e-afb5-eda4-0ce30001bab9@gmail.com>
Date: Mon, 4 Jun 2018 11:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w549OU7H032504

Hey guys!

Just to let you know that I have the same problem on Dell Inspiron 13
7370. Yesterday, I made a test on 4.17RC7 together with the newest BIOS
1.8.0 (released the 1st June 2018) and the problem is still there.

dmesg | grep "error" gives

[    5.888091] ioremap error for 0x9f935000-0x9f936000, requested 0x2,
got 0x0
[    5.888158] ucsi_acpi: probe of USBC000:00 failed with error -12


Do not hesitate if you need more information.


Have a nice day,
Kacper
