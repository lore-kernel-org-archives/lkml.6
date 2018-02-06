Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeBFR3I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:29:08 -0500
Received: from mout.web.de ([212.227.15.14]:52881 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeBFR3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:29:01 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] HID-Asus: Adjustments for two function implementations
Message-ID: <5289ace9-8927-9803-4692-c7c621ab0a8d@users.sourceforge.net>
Date: Tue, 6 Feb 2018 18:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:v3EypTsQkZuFMecU74GvyTiZyptySZUzqahQzqGTwVvXqMsG9A+
 mmLrJiKnPdG0ESkGKUWvpK6rKgSXuC2Eex6Cl4hTRwgcrcEqvYEP67tDVOQw1mBoKxz9B6p
 ic5LxTxsblr3KsujXInrxJRQjO1v+ifacA/kVeYr6TwTcvx1juBEE8/nCLdDcrMOS8UvXpG
 ywwv9f/7Xph9oOd5ksSMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V1oUk/Qshoc=:kSBjRec8BQAXwQNj3wj7XJ
 CnFpYeEpSLg18aGFqLLKyKncowpfvwX+/Kr4LmTqsAAfNVeoX4TrzslY1PmcXwKwk+JLFIRG8
 Luyw+vUtRQylSOs8YncpenpueNeh8sRf9Zv1OHPIIvJcWr3u3EGY40lROqO2ykRp9L5XPlfwa
 I2h1awTIjyXTSS1hNioMnAthD6Exl6oC93k7YeyYQHPqpWLF2XeFSv+Ucmkr6uNbj70178qi/
 /nFfSF6Ouhr5qLetUbo/wKCNGVMraFoNBWlicT0y4uN0I78QNydXts0KZelyPn76ElyEXC7EB
 C5eCWATkl+G0kg72DjYjBFQA3HYv6IOyr+xV3F7i/mkwtXYl3spqP4ERXRvM94ZeJIEGqQfCJ
 wiHPalzadoDLOOdpGLpfBUSR8BZrrzwsLar+MF7n74KkZsrSI/km3O7JtsLDLRNvseicR+hlo
 KH0Z05j2LgZ/v9lS+uxFxmy2tAfr2+MyKhUqka7f5qL4v6uu8N8CTaSoP1KVK6xqdCDnGFzYy
 cnPvaHyLDAxjtSMhWtDXPc7feJLn2TI7sEH6XGroAAOFAeQn1fy4BVGjGgn+HVra2yq0HjG/O
 MBANQk8R1JNe+dlu/3Uu80xszGDpHLWPV/e0ltQQjFZsQV8kgQhZxDYGj8zhfSJHwz92LxUFC
 3piH5TLyplT3RGI4DWmSad85xyFid5NiC+GmcnzRWrWi4U1Y0XIOMSXfBmTTabgHgZdwkLV4v
 uPiLwmLaS74F/0ylgZtDugYmvMbSFZ4ENl3z4cSq5hYwztEc4l4iezH8Ts8TQ1/vvwtCGyTHf
 Bl/E3KlkUNtBwu3WlsKODPSFw0iba3t0L5kI8Hdyce41YWJrcE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 18:24:56 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in two functions
  Return an error code only as a constant in asus_start_multitouch()

 drivers/hid/hid-asus.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.16.1
