Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEESUp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 14:20:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbeEESUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 14:20:44 -0400
To: Arnd Bergmann <arnd@arndb.de>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: crosstool requirements?
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <1b8328d1-4e41-c4f9-c07b-87530e85eb7c@infradead.org>
Date: Sat, 5 May 2018 11:20:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

I was trying to use the x86_64 hosted openrisc/or1k gcc compiler (7.3.0-nolibc)
but I mostly what I get are errors like the following:

crosstool/gcc-7.3.0-nolibc/or1k-linux/bin/../libexec/gcc/or1k-linux/7.3.0/cc1: error while loading shared libraries: libisl.so.15: cannot open shared object file: No such file or directory


I do have /usr/lib64/libisl.so.10 (not .15) installed on my system.
Am I just outofluck for doing this?

thanks,
-- 
~Randy
