Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034174AbeBPOVN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:21:13 -0500
Received: from mout.web.de ([217.72.192.78]:43757 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034158AbeBPOVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:21:11 -0500
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] PATA-IT821x: Adjustments for it821x_firmware_command()
Message-ID: <6cdadc5e-bfbd-9866-a69f-d225e68c3b22@users.sourceforge.net>
Date: Fri, 16 Feb 2018 15:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bMKndbHPTi6+e2cWdVJBN1coyVFnAJW1WRLKqpUHbfxSZXW0Ipd
 95lZA9YnVAELmCW3WHu36VJHq5ZTzUWOrZ4cRQMaZsj62ev0V7SEJshONDK2oopnxNDmwfk
 afwQPLK2hRexEFXhk93OpUZkdGq4R0BcCvi8DcJAZfkpQQM5HBmvFRYRqjE0ekndbZCQzJa
 jZpzy3tDp2KMMRrJoCEoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xxlseca2VAo=:ZQilsrG3PxzW7uGqODpN34
 IJvhgsXeRv0qA+h2Vu1WpdFCPhf+DBTSmvdtcp8L6EBwhga2FfEFzCOVI6h/MvqTtAB5sZduB
 0irfJrSBCAw4fioKSabkBUxPtX9/WyuKVKqnhooz2d2YhEqusV5JrwDA01W1Xg8tC5LHp/pag
 MYFZnGk/uYcdQLoacTTHdsLsQdh0gSbFKj9D8Z6ZYriagWsfF1T494bCZaZuG2QkJOU6hbT+O
 3+OrPqx4Iv6VjYL/gyLijmxlb1MRwyaT5ElRMJVVftU+922zqz1DCyqnjx4i3U+a4C9L7gCti
 oBLill5NPQ/MRtoh36HWFlc7x9Ef/NlBW7F/4J+1yxJ+uZGs0rncgPzkWdunuyn7AM6t+IBUl
 8Qy7L5kqoXVNU+j6LHmlw9PLzWK6F5azRP9CzRlChexKThkeWP1Kx+2O1xqBFhMX7dpe89+jt
 HUgiKqtWnVQwTZ/s3rpg5GW5YoWGM2itWUJPDTUQ7UFIEbk5SfYN8tJTtf6p9m/ueYpub+nyT
 OzBcrro4fRPt1A5oS4FUbH/Wr0/3ibXoAZWShq2wyqvL6KiGGHAgGZ4H7AGeg4m0VR4aTHp7G
 hG6vVckCFBpBIaC4M9a6RHS4U++Yst+pJv11/qgiEDAclarRHHPHywJbcWi0QJgjuRXpGhQgw
 lLVNSkaPxOI/Iuj7AWf+EW9Axp91RHBhsYU3mdf7QNfd/XjS6mE/76cv0Y6uNfqaqo5el66jo
 EnW0ONl2TRyAtT485kfUDTutTWzEnTHn9mqB88x1pJ3/ZSGtFkmZEpapXIPrnmBitFgEUMLxp
 9Gc1Nb8m16gmgeGo+3pWnuRiHFdW6j1s/IdKqrO5csfDXH/7eQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 15:03:45 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Use common error handling code

 drivers/ata/pata_it821x.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.16.1
