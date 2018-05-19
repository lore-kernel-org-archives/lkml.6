Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeESTxH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 15:53:07 -0400
Received: from mout.web.de ([212.227.17.12]:54043 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752322AbeESTxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 15:53:04 -0400
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Christian_Kr=c3=bcger?= <C.Krueger.B@web.de>
Subject: =?UTF-8?B?U3VnZ2VzdGlvbjog4oCec3BlY3RyZV92Mj1vZmbigJwgYW5kIOKAnm5v?=
 =?UTF-8?Q?pti=e2=80=9c_per_default_in_=22Intel_Atom_N270=22_case=3f?=
Message-ID: <72a7122d-0020-f307-a76d-bb80a2c19842@web.de>
Date: Sat, 19 May 2018 21:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-LU
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7aQAZiJVtGSPgThanDtQqnBOHnFmFLuFa7KdwuZ4kEgIGMtt5PW
 Qn6IpL8I/VVe7HAfMJBJDxKoEgMgJ6zCO3SdAgZaXhT5hNnE8nah3GQ7dEuLxvjUaRzmLkr
 hn3rFicpI1RR+7WjlLKTyl2p4ZxO6LLGNnnecY3GKGNIbDRsYlvQfDGiWfy3YLJVWOsLyXo
 3UptIpN+pL+JNUotQdGnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qkch85R7dxs=:7QfvKgH73Xgj3KY74+TIyh
 OuqHzvN4m1bHy9siqth/6LhV8f9X1XTaymqGTyxCDmazVV+fK1vxOfFGbNdEJgM6DrKUKYKVG
 ro7Hu5HawqpQ5UMz0nc6VRV5kkolyDC4TQpCEvAQAZ/JvaXw/e8Nt0jHFZ2Ep5oTferKTs0eQ
 kO1+AhQ+HxOcJ+X9r/PGTxnXlOV8uHaEUZX5YF9oN9+ZlK5neesuWglLCtb9oTBKijI90sgr0
 TPVqnYaNUzS/XM72jfe8QImBiPp5fpPLbfbxILjnTRFNsHT9gXuGVNvf8YBW62xwZontlWrAg
 nLVQBy9blb+/TYIZFrKtyAAiIj62TQaP0YjsSCsub5Q1PczWAxeuQqN1NhoDyS4d6+VDbKGMD
 pNc25ys9Co+K7BHKHVG0GXg5UuCCnujes3mfuMoUukRn3322Vbpbf+pKkNpUJQlDC743DRbI/
 cF945S4Cb6YU90IRtDue2JF3rIDyekUBohIyrCEKZIZPlUandDbOrwzWmfQxyjNdf/IcVB1q0
 8OvZSqsGd0EvUfNA//PhfEFVR/VxmyO9pKheyTv11a81eE9d8FY0r2RFCg3FR8sXbqHA7kiSK
 ddNdV/JFYDmdqIoRzj/tOzgCLPdM0ZjyzDAuwp357evyVT01NqPn+u34t1f/PRW9UOTOB2cLH
 3b3ghYh6eRQTm/nbWUhie2lSWvvDbta0nhnI4t9AyEVRWrCQOFx880ogp4rInH6kqOWCti0Cr
 rC/tq22WS7IcKOVONIRIxFiq494u1af5mVJldndvNsn+naqrGmUrwPcBUK6f66d6jLo1isNKz
 oDaedc2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since the old "in-order-execution" Intel CPUs like the Intel Atom N270 
(known for being installed in many Netbooks and Nettops) are not 
sensitive for "Meltdown" & "Spectre" , wouldn't it be a good idea to 
exclude these anyway "weak" CPUs from the costly patches by default?

Browsing the web, I can "feel the difference" if the matching kernel 
options are applied on such a device.

BR
C.Krüger
