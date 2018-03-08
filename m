Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756031AbeCHPTD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:19:03 -0500
Received: from cmta18.telus.net ([209.171.16.91]:46923 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755671AbeCHPTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:19:01 -0500
X-Authority-Analysis: v=2.2 cv=ebrSR/MH c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=7R1OktSSXV60aff11NoA:9 a=QEXdDO2ut3YA:10 a=7715FyvI7WU-l6oqrZBK:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Doug Smythies'" <dsmythies@telus.net>
References: <000a01d3b636$57b75c00$07261400$@net> thHZenCOVQdbpthHaeaJ1a tkIhevBcspApstkMJea2ob
In-Reply-To: tkIhevBcspApstkMJea2ob
Subject: RE: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
Date: Thu, 8 Mar 2018 07:18:54 -0800
Message-ID: <000a01d3b6f0$c870d380$59527a80$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdO2YUFyoX23OKWuSDqB3IDDCEMKzwAFca6QAB2782A=
X-CMAE-Envelope: MS4wfApwp/HThVR1NgJi+8raP+mCJ+VivE3Q0v7hSzPN1dnvzEKvLTCOIVgcc/+JBYRmQGh92npKmQJXrZq2tvJxsSdR8Qo+vJ4KVhFsMuT3u5ChAkmBKUzj
 uQ9sYnSRqTDwqlTBCeseXJCgJaoZgKolcYj0OEi5srFfCt7DJISWfa+BJIBFFy1pA8MPX/AW2ISw1kJi31FnQjTMPNedBuAouvAXd8cA0bo+YkIzNni0BSKx
 px3TGV5e2ZJNGDCBskstlzD3UlfNKXXLF6/LW28tLinPPbImV0phgfgvMPp+iLyfkZEBD+rjU0B+b5iU8Q5s0le7+9Gr4/nq0bwNBQHnwyXNw7C3LAAiGQLc
 U7tamCHV6Ijge9/Zq8Y5SWtNE9SK5DRYjJym2GKKuzKUDbo8Bj7fcimVFi3irK8vf6NlkGiRePKLVxqt+YkN8hRdAEZl7OawL01YyfxG+/xt1TMpvJitrTl6
 1Qo4JMVQblfYhdSdseaN6Yso+hh59zvUloqVQFPqWxTmszdiEjR5Ju7eFcKoXYJzWgqjiZ7zF3lj9ocvi0yx1b2HvuHougN2TdRhBw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.07 17:29 Doug wrote:
> On 2018.03.07 14:12 Rafael J. Wysocki wrote:
>> On Wed, Mar 7, 2018 at 6:04 PM, Doug Smythies <dsmythies@telus.net> wrote:
>>> On 2018.03.06 12:57 Rafael J. Wysocki wrote:
>>
>>> During the test I got some messages (I also got some with the V1 patch set):
>
>> Can you please check if that's reporoducible with just the first three
>> patches in the series applied?
>
> I will.

No issues. Test duration: 7 hours and 26 minutes.
Boot seems normal. Times re-booted 4.

... Doug
