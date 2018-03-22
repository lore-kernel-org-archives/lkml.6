Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeCVTLm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:11:42 -0400
Received: from cmta19.telus.net ([209.171.16.92]:33823 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeCVTLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:11:40 -0400
X-Authority-Analysis: v=2.2 cv=TI+qcxta c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=SSZsOMKSBQPNBdVzpjgA:9
 a=QEXdDO2ut3YA:10
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rik van Riel'" <riel@surriel.com>
Cc: "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "Doug Smythies" <dsmythies@telus.net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan>  <20180314120450.GT4043@hirez.programming.kicks-ass.net> z38ge3YFh1Konz38iel45g
In-Reply-To: z38ge3YFh1Konz38iel45g
Subject: RE: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
Date: Thu, 22 Mar 2018 12:11:33 -0700
Message-ID: <003f01d3c211$9a094e10$ce1bea30$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPB+2Knq1MUfUhjTr6ehdQ6RKf0qwAFSacQ
X-CMAE-Envelope: MS4wfKf6jbN8aGXPfBvwxnUB0jHNr+SQ+v/feU553d5E9w+j8U8nKPxFCZ/aPeE/JIsLeE3IPN6SlmfgeAnjdHGi28GlTLoMHKLCcQnKDdV9bFTuD3JDT/mA
 +XiGFUAGV/MM4ZvxdlTYLgOh91/ROO+CMYEYdxV+Qzsoc11JywEfF/l383wHN7KDnzR8MS8R7tKeO6IlKBwzg129rI2/4RMa/zpk5R41Dy13VBr1yuh9DJzR
 VbNwKCcoMQkfLSQWD66fMl46lK4S6/DgNKFdv/cruWYKdZtbHQswvZSoIbyitcXbD1P9So5Wj2ezqxKrJJ8hEb5XKmRRGDCSy1unkIvHUVFb4Pvuq39TCK/a
 mBBmjOlY6ETroQiamPM2JIuYoBrginYTBtZVCw31YTeyd49/Awc9erF0Woekjs1KC2vvF58JQDBHQLnFlmr0CuHMLBKcukWT6MaD9V9cwUhblal0e8mxyL5r
 BZ34qHLdG6Q6rlBTpHYUcDhBrO17UbqphCamBUEMfefi80VcwDTfBwjG4Uo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.22 09:32 Rik van Riel wrote:
> On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:
>
>> On x86 we don't have to use that time_check_counter thing,
>> sched_clock()
>> is really cheap, not sure if it makes sense on other platforms.
>
> Are you sure? I saw a 5-10% increase in CPU use,
> for a constant query rate to a memcache style
> workload, with v3 of this patch.

I would very much like to be able to repeat your test results.
However, I am not sure what you mean by "memcache style workload".
Is there a test you can point me to? Say a Phoronix type test, for example.

All of my tests with the V3 of this patch have been fine.

... Doug
