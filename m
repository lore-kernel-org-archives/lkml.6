Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966970AbeBPMhb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:37:31 -0500
Received: from mout.web.de ([212.227.17.11]:37555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966628AbeBPMh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:37:29 -0500
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] PATA-MacIO: Adjustments for five function implementations
Message-ID: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:37:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WFIl7W1J1nrazpODaRRmQaXK4mUDdUVGr9i6PA+kWdNHYCjAi7+
 8l3lXBWx5pX2ZKFFIcrY3A/hkKs85LF9v/BFyoQ3K7rHjAwOKAL+IzXSiKj24cktRqdMMcL
 fgVMowQsOt4XFd4SRs7NX9csEwC9fnY5l4DIxGWGAi0tlaos/MPzzFhNUPboQGUMBRHD1kf
 5E8tBl0Hw5jNebkQxfWiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9uTZcY7M8MQ=:BnwldcK0pIsqwJc3/DlQr6
 96mRi5QhmpBOFIP+GFP3ZAHL2TwVrepVjYxwQNG+CAS+w5OXim+Rdg+CFCY2eDGo/bjdgGIcE
 NWXvbv7ct8AlcFwjRXgUDsnyzGXWa3Q51JDnwUcKS12qgt3pFJa1WyciMzpSZ67vDATNRIOg3
 3bN36diS5N8L9Gfh+0NqEXrNg/I9WsIDjQFmFPK4EayeKuUY38z3J0hi+P1J6xatuXf0FU+VH
 XuzZTD+w5m8V7sghC9WwGzeuOiBamqJP050cfRM8Zki03f4We5UtHKhn+PzY+LRe0hY9/wsyu
 CaM7yCOONWQ4stA+ieEmxxBP3rdktmHr1FtLTw+Kr40j/xUOJTt5pbnkmhsvSVZbcFUNa0Vmb
 2GjzGzFIdpYvzONK6f8Jq6KUVU4J6iA03adDTIqKKjXFqT1M9cc+m8+hn3KuSzbHHw/64teE5
 jW1wN+++q+gsnVVEFeF7ohj71r1y4CG9ampJAbhPGX7fp9MdYGH3pvM7+tI3hQD83AN8FRaGd
 GW8Did+s48606ivko+Jo0m1xKbYsXBUck88m4obg8gu1Cc+Alq4lPx0HDa1N/57i89bU2YgXr
 tk1MvvNjzOV1Z/s0IUXZljlquMERKLEYO6LGpAz1wK/tpZ9K1+5SkZOXvr65votNY3sXdrxfn
 4y436w3Jf+AKa98d4OjJDpdNSR4h9OGEjH/1NBz3To6r/yzUmD/utCheLM+J8wZR52gbvwGgQ
 Lu57W/eavyrijweJZARYuK4X1K1CtizYHXBr/XeEWrQaLtfTBqwcaNlSNIaCzGPlqmABT4B9c
 KZnrN65kFQgUq7GeLd1wL3SOdNeTX4rK/UXjbL5KgjU5daQGR8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:32:23 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in two functions
  Adjust 11 checks for null pointers

 drivers/ata/pata_macio.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

-- 
2.16.1
