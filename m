Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeFEUJc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:09:32 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:8058 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeFEUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:09:31 -0400
Subject: python errors in tools/testing/selftests/tc-testing (was: Linux 4.17)
To: Linus Torvalds <torvalds@linux-foundation.org>, <bjb@mojatatu.com>
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <11f16994-d704-10e3-e4f7-a490b6ae1fad@mageia.org>
Date: Tue, 5 Jun 2018 23:09:42 +0259
MIME-Version: 1.0
In-Reply-To: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C0205.5B16EDFA.016A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 
/usr/src/kernel-linus-4.17.0-1.mga7/tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py 
...
   File 
"/usr/src/kernel-linus-4.17.0-1.mga7/tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py", 
line 18
     print('This script must be run with root privileges', file=sys.stderr)
                                                               ^
SyntaxError: invalid syntax


Caused by:

commit f6926e85eee9be08d05170af3a2266b8d7f9cdef
Author: Brenda J. Butler <bjb@mojatatu.com>
Date:   Wed Feb 14 14:08:55 2018 -0500

     tools: tc-testing: rootPlugin

     Move the functionality that checks for root permissions into a plugin.



and:

Compiling 
/usr/src/kernel-linus-4.17.0-1.mga7/tools/testing/selftests/tc-testing/tdc.py 
...
   File 
"/usr/src/kernel-linus-4.17.0-1.mga7/tools/testing/selftests/tc-testing/tdc.py", 
line 167
     print('', file=sys.stderr)
                   ^
SyntaxError: invalid syntax


Caused by:

commit 93707cbabcc8baf2b2b5f4a99c1f08ee83eb7abd
Author: Brenda J. Butler <bjb@mojatatu.com>
Date:   Wed Feb 14 14:08:54 2018 -0500

     tools: tc-testing: Introduce plugin architecture





And this system has:

$ python3 -V
Python 3.5.3

$ python -V
Python 2.7.15


--

Thomas
