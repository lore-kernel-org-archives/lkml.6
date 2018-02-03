Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeBCU4k (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 15:56:40 -0500
Received: from mout.web.de ([212.227.17.12]:64893 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752542AbeBCU4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 15:56:32 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] HID: N-Trig: Adjustments for ntrig_probe()
Message-ID: <86d02ef2-0ac2-5462-0ff0-a0cd87c3d1f7@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:56:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yFR4es01fZMuger1pVBH/I4XhhOl4Ovd2Bdu9BfmyxFcFsc/7AR
 8cs6OCmMfQfx7dCSNRM/7gXJGEHkmDwTIEtqovxPUP0HHvMSTfnsZCqM2QmO7c7//Ay3cMH
 mPCnOq4Zx8BYkgVSVtzF28U/jNzQ1eu4QkVTePCk888SLuU3qThr0xiTbOai26hOJIF7zF3
 VbwasceriszEAOMTqvnzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8TG6tg9FA+M=:Oqg2M1FCEeY2tp36mNOSei
 GEwhbfxipoOOOs6ycvWpz2pc3QgCiQKG6nyITMTpvRZaCovYw4aPf4ETihI4apRIPc9rnsiuH
 78yM+J46UURv6RZ8iRr/FIQODT71TOF/0yyToewZEgxaPeRE00nqsoBitpD/TW/c6QzZRxWIm
 m8cRJdcq2jU+Y1AMsxUW+SM3IcAi52FNFEyN8TnkLbBG5TTsBXeieqvNcsJGG8cqDgpmiWcXz
 NcTG0bGOfhCk25UVDzPpgT6m5UxtCDmszHvTEJBiNJuk3oEHMPo7U/NZ0sajPZk3Z+nlZDZb1
 J8wYTovIy6/p29TgMLD+s54lL+5Y61c8W+NjeOZyA1bEad1hq1EC+rqeoSqd1JI3iSkg7tgWV
 QC3XNzOfCbiyVmbWFyAZrsHf8fmdQ9AfxVmDSDMSI+JiWG0/z2G+juBHctV1FUWrXrHDVXRj1
 5aH2+5d3vtd/l/usqsciXbAJDVFhNmIRbY6oyDHaL2IQk6YqX5603WlGeNTxB+kT3G/hzb34z
 TD8X2aSdvltBubC6gZn2bFk/QMNXktfvXCYYCCaDFjCJnHJumgnM16sgsAJHWEH0xsjYM+Xhs
 L7g7WXVsyiOxVb9OgnDikaUjg/To4kv9+czhni4vVhWWQev6hz/tq9issr7hTHb+aSuAc456o
 c8LsS9+y863M0jav471xal31hZxVnvkJgSguEwNF6E2Lhtht0e2xHf7Kl6AMV5s22hP5ycutc
 yYj0nMU6mnSz3mav0aqALC/DJ6RG/aOpwAYCdVP/K7oA88lwae/B25pzugWy5XcSKFGg6+muA
 P0xv0fMdTPc9vUODlQDn7l/egE/8eOZyP1hOw3Xl9QGcMnxqkY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:54:32 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/hid/hid-ntrig.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.16.1
