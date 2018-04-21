Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeDUPLg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 11:11:36 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:40612 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753058AbeDUPLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 11:11:35 -0400
X-Google-Smtp-Source: AB8JxZpo4F56cVh9qodmF6uDVeon1f2hsFxAD969cVeT0mrXBDBWqHlyKoBQs13HFu7yneTGlnSOKutav6TIA625/Ok=
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 21 Apr 2018 20:41:34 +0530
Message-ID: <CAG=yYw=ugyQ9HyVPszZNmUYgEZ=TqGfZNvoDkNCVBnC2110Vyw@mail.gmail.com>
Subject: possible BUG: selftests: proc-loadavg-001 failed during kernel testing
To: shuah@kernel.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

selftests: proc-loadavg-001
========================================
not ok 1..1 selftests:  proc-loadavg-001 [FAIL]

To reproduce :
make -C tools/testing/selftests/proc run_tests

Linux debian 4.17.0-rc1+ #3 SMP Sat Apr 21 03:41:44 IST 2018 x86_64 GNU/Linux

GNU Make            4.2.1
Binutils            2.30
Util-linux          2.31.1
Mount                2.31.1
Linux C Library      2.27
Dynamic linker (ldd) 2.27
readlink: missing operand
Try 'readlink --help' for more information.
Procps              3.3.14
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                238



-- 
software engineer
rajagiri school of engineering and technology
