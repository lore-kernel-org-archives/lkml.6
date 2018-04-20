Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeDTSD4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:03:56 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33193 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753726AbeDTSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:03:55 -0400
X-Google-Smtp-Source: AIpwx4+GZzKUqezIxUtBCcp163MtYuaOykAPPP0In9PIoCeQg7iTKsw08+dmUTGikbWmNCkrgSLuO3N7DZypZGvO2zc=
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 20 Apr 2018 23:33:53 +0530
Message-ID: <CAG=yYwnMXFxHxCnYNWCb-HhpAb21kc5_e_6q-N_DRGhMVurPMQ@mail.gmail.com>
Subject: PROBLEM: error due to conflicting types during build of kselftests
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3KI41O8011656

hello,

the following is the error found...
-----------------------------------------------------------------------------------
protection_keys.c:421:5: error: conflicting types for ‘pkey_set’
 int pkey_set(int pkey, unsigned long rights, unsigned long flags)
     ^~~~~~~~
------------------------------------------------------------------------------------

to reproduce this error...
make -C tools/testing/selftests

Details about software:

Linux debian 4.17.0-rc1+ #1 SMP Thu Apr 19 18:59:45 IST 2018 x86_64 GNU/Linux

GNU Make             4.2.1
Binutils             2.30
Util-linux           2.31.1
Mount                2.31.1
Linux C Library      2.27
Dynamic linker (ldd) 2.27
readlink: missing operand
Try 'readlink --help' for more information.
Procps               3.3.14
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils             8.28
Udev                 238

-- 
software engineer
rajagiri school of engineering and technology
