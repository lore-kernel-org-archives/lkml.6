Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeC1N3a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:29:30 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53721 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeC1N32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:29:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180328132926epoutp03b1194904112806ced4652819b352b94a~gGKPs5y7e0096000960epoutp03g
X-AuditID: b6c32a38-d73ff70000001082-12-5abb98b6be45
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: aty128fb: use true and false for boolean
 values
Date: Wed, 28 Mar 2018 15:29:23 +0200
Message-id: <3978155.69BmuUMc09@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180322201332.GA28960@embeddedgus>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCmvu62GbujDM7M4La48vU9m8XWPaoW
        J/o+sFpc3jWHzWLNkcXsDqwe6w6qetzvPs7kMXdXH6PH501yASxRXDYpqTmZZalF+nYJXBmd
        G7YyF0xhrni/Zz1TA+MRpi5GDg4JAROJldsVuxi5OIQEdjBKHN+3jRnC+c4oceHybcYuRk6w
        ogVblrFCJDYwSvSueM0I4XxllOif3wVWxSZgJTGxfRWYLSJgJDF7RjdYB7NAM6PEzFOT2UES
        wgIhEkt2f2EFsVkEVCVu7G1jArF5BTQlXixZywZiiwp4SWzZ1w4W5xQwlNj39B4jRI2gxI/J
        91hAbGYBeYl9+6eyQtg6EmePrQO7SEJgBZvEliun2SDudpHYMWs7lC0s8er4FnaIp6UlLh21
        hagHOu7bjj3MEDUTGCX2rBeCsK0lDh+/CLWAT+Ld1x5WiF5eiY42qBIPiU+be1kgbEeJr2fa
        2SGh0sIoMbX3HOsERtlZSO6eheTuWUjuXsDIvIpRLLWgODc9tdiwwESvODG3uDQvXS85P3cT
        IzgJaFnsYNxzzucQowAHoxIPb0HMrigh1sSy4srcQ4wSHMxKIrzvNXZHCfGmJFZWpRblxxeV
        5qQWH2KU5mBREucNCHCJEhJITyxJzU5NLUgtgskycXBKNTAeErnn+1dtwS8TQb1vp97Lqq0+
        JqF/lnc+2yH9jsIDql3nN0bWScmtK9NTUFhnx3BI3l9q1s7rKluKOApMU27e8Kn88qjk1qRV
        dWHPGH/kBRxbsK1zzvzZCn/26TRKJnefeZnIeGNF8Lp9Setbv/23D5a6uGxu2QOB0NlO6fOP
        bEtSFEm9qcivxFKckWioxVxUnAgA8SWgcf4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t9jQd2tM3ZHGaz8LWhx5et7Noute1Qt
        TvR9YLW4vGsOm8WaI4vZHVg91h1U9bjffZzJY+6uPkaPz5vkAliiuGxSUnMyy1KL9O0SuDI6
        N2xlLpjCXPF+z3qmBsYjTF2MnBwSAiYSC7YsY+1i5OIQEljHKHG++SUThPOVUWLe6YnsIFVs
        AlYSE9tXMYLYIgJGErNndIN1MAs0M0rc2XuIGSQhLBAisWT3F1YQm0VAVeLG3jawFbwCmhIv
        lqxlA7FFBbwktuxrB4tzChhK7Ht6jxFiWxujxLGdN6EaBCV+TL7HAmIzC8hL7Ns/lRXC1pJY
        v/M40wRG/llIymYhKZuFpGwBI/MqRsnUguLc9NxiowLDvNRyveLE3OLSvHS95PzcTYzAwN12
        WKtvB+P9JfGHGAU4GJV4eAtidkUJsSaWFVfmHmKU4GBWEuF9r7E7Sog3JbGyKrUoP76oNCe1
        +BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQbGSQeTFhlo9GW5zmfZaPr7/n+V0vB9
        X/QaF3Ec3N/nIFX7tX2a0fQ0tmabtukOx8W+5lbMNroostHd0ni/TURsDvP5vcbrlxz164q1
        OHXSXTTLpEHj/vJ6nwsS2zYu2W/kdeRWyLKm+YVHmZ7c/X++/dujpdw/26Z0XM3q64/yjZI/
        LrLtzpJ7SizFGYmGWsxFxYkAo4ZRP1gCAAA=
X-CMS-MailID: 20180328132925epcas1p4a3978d60ac29da642a8f8e863b779419
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180322201504epcas5p329c931766457a81d6dbf4ed70127cf9f
X-RootMTR: 20180322201504epcas5p329c931766457a81d6dbf4ed70127cf9f
References: <CGME20180322201504epcas5p329c931766457a81d6dbf4ed70127cf9f@epcas5p3.samsung.com>
        <20180322201332.GA28960@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 22, 2018 03:13:32 PM Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
