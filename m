Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCTRwU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:52:20 -0400
Received: from cmta17.telus.net ([209.171.16.90]:41991 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbeCTRwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:52:16 -0400
X-Authority-Analysis: v=2.2 cv=StJ/0LG0 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=5N0elIdOQmKS7G9AUawA:9
 a=CjuIK1q_8ugA:10
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> yKMSef9P3FfdwyKMYeuPWj
In-Reply-To: yKMSef9P3FfdwyKMYeuPWj
Subject: RE: [RFT][PATCH v7 3/8] sched: idle: Do not stop the tick upfront in the idle loop
Date: Tue, 20 Mar 2018 10:52:12 -0700
Message-ID: <002901d3c074$2e315280$8a93f780$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPAauoS2vctArRJTG6EDPR8uf7TRAACLJ/Q
X-CMAE-Envelope: MS4wfDaAxCID2OhoNFL3BkPDgipZru9olVb5rDhdVefusHg17GWNNo3Z8tXU5xzHr0srE8/+L+3APf0rJT+265gVL9pC842+QnOfccEaYdfpeVJgFmJcXEO5
 PZD+/WJcyo5Tg/WyWU8WSwh4D/1HALzVH1J+57GchifkfOy61MMyai/LpPULWOUwmaKB/hEZGwogrPp8ufl95o5SpONWGmUv+Vou8fthyhyN8a2jVtXTCw6g
 cTgC+jiwacmkE/0zbZvpy2NsXI2KrwpW4fR8hq40TplJWQNx7dsUKv88xTkLFY1yOJrP3t2ZBzQy+c78t2Q+MRsYFq9ItQKInlvv/612g1FH/OGcVMqPTXSg
 VEItDKFx6O3y8a+G0m627fkfyCPdujmIvlXPzN3r2JQ6Ea3UdNk2nh561zODjAF+RGoH/Qd/Js8grSxaghU/5I2kkSsmLJbzdeI8xkxhIQlJyzDVyJuF90kI
 bHANwChF+OrL68lUfAz0ThYUyFm/FPfP7K05ksiqjj4UwKbCvm2+1t+7NZ4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am just trying to catch up. Switching to 4.16-rc6 and
this new patch set.

I think this patch 3/8 is incorrect, and is actually
patch 2/8 repeated.

I'll see if I can just apply the old v5 patch 3/7,
and move on.

On 2018.03.20 08:16 Rafael J. Wysocki wrote:

...[snip]...
