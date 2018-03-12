Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeCLPB6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:01:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30730 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeCLPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:01:55 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180312150153epoutp030e684b1746fbe9fcd657d7740273f27b~bNGZTaPCt1264112641epoutp03s
X-AuditID: b6c32a45-403ff70000001023-bd-5aa696600e07
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, viresh.kumar@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, daniel.vetter@ffwll.ch,
        christophe.leroy@c-s.fr, seanpaul@chromium.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] video: console: kconfig: Remove AVR32 dep. from
 VGA_CONSOLE
Date: Mon, 12 Mar 2018 16:01:45 +0100
Message-id: <12268684.R5uc9OLfbC@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180206225254.20036-1-ulfalizer@gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7bCmqW7CtGVRBp8u6ltMffiEzaKjmcni
        799Ki4UP7zJbXPn6ns3iRN8HVovLu+awWdy9u4rRovHjTXaLphZji7sbzjJa/Nw1j8Xiwq9b
        zBYbv3o48Hm09v9g85jdcJHFY++3BSweO2fdZffYtKqTzePOtT1sHve7jzN5fN4kF8ARxWWT
        kpqTWZZapG+XwJVxdHp8wVumir8bL7I0MK5m6mLk5JAQMJHYNX8aaxcjF4eQwA5GiSWbzjJD
        ON8ZJc79vsgCU/Vr3hp2EFtIYAOjxPs+MYiir4wSGyeuZgVJsAlYSUxsX8UIYosIqEvcm7Cf
        DaSIWeAek8STbzvBioQFgiSmH7kANJWDg0VAVeLFulgQk1dAS2Ll+0yQClEBL4kt+9rBruMU
        sJR4+2YvM4jNKyAo8WPyPbB7mAXkJfbtn8oKYetInD22jhFklYRAM7vEmSfb2CGOdpG4fu8Y
        M4QtLPHq+BaouLTEs1UbYRoYJb7t2ANVNIFRYs96IQjbWuLw8YtQG/gkOg7/ZQc5VEKAV6Kj
        DarEQ+LkhVPQAHKUuLjtDTTktgADZepC5gmMsrOQHD4LyeGzkBy+gJF5FaNYakFxbnpqsVGB
        oV5xYm5xaV66XnJ+7iZGcPrRct3BOOOczyFGAQ5GJR5eg+ZlUUKsiWXFlbmHGCU4mJVEeP2n
        AoV4UxIrq1KL8uOLSnNSiw8xSnOwKInztgW4RAkJpCeWpGanphakFsFkmTg4pRoYeWIPLhc7
        +fz7s9OXNib+Cn3j4eInw/3YpUmna8kKNcn+jO926prre24ULLgfqBE8J37eO4VHTLYR0m81
        ZmkWKLF9VfQWUY440nDmoo2e/BPtz/P5rI1mONro/c/VqbQ+efjnolXxvZ/fy32RNU6/pKg1
        Jyl4+cc7D1hcdu27fNWwb9bsR7uvK7EUZyQaajEXFScCAK2dCHs7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e+xoG7CtGVRBnOWcFpMffiEzaKjmcni
        799Ki4UP7zJbXPn6ns3iRN8HVovLu+awWdy9u4rRovHjTXaLphZji7sbzjJa/Nw1j8Xiwq9b
        zBYbv3o48Hm09v9g85jdcJHFY++3BSweO2fdZffYtKqTzePOtT1sHve7jzN5fN4kF8ARxWWT
        kpqTWZZapG+XwJVxdHp8wVumir8bL7I0MK5m6mLk5JAQMJH4NW8NexcjF4eQwDpGianzzjFC
        OF8ZJS40v2AEqWITsJKY2L4KzBYRUJe4N2E/G0gRs8A9JolJbd/BRgkLBEjcWvoMyObgYBFQ
        lXixLhbE5BXQklj5PhOkQlTAS2LLvnawak4BS4m3b/YyQ+zawiixYek/FpAEr4CgxI/J98Bs
        ZgF5iX37p7JC2FoS63ceZ5rAyD8LSdksJGWzkJQtYGRexSiZWlCcm55bbFRglJdarlecmFtc
        mpeul5yfu4kRGDHbDmv172B8vCT+EKMAB6MSD29H67IoIdbEsuLK3EOMEhzMSiK8/lOBQrwp
        iZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZODilGhjDlr3c6L2m7/dG
        l00G16uMlv9wjdPp/HAl40EIv9Xj7wHyT/8kJ+Sf3eq0Pj/8wilfw0Uaa7adMDx240GCwZrr
        yQd/6dT+1rh417vzuOCls6V66uo/blUxL7sXYLWw/4xxg+i1xr9HGO0jt8tOvtacFRP0td1F
        Kb/eo6hbWn9CX862HzFeptuVWIozEg21mIuKEwGS3t89lAIAAA==
X-CMS-MailID: 20180312150152epcas2p1de7922ce9b6b81485a1aa48e761e6cf0
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180206225334epcas4p3f1bf4f40c1fbc4bed23dd79445df1b3a
X-RootMTR: 20180206225334epcas4p3f1bf4f40c1fbc4bed23dd79445df1b3a
References: <20180206120825.GF5681@sirena.org.uk>
        <CGME20180206225334epcas4p3f1bf4f40c1fbc4bed23dd79445df1b3a@epcas4p3.samsung.com>
        <20180206225254.20036-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 06, 2018 11:52:46 PM Ulf Magnusson wrote:
> The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
> support for AVR32 architecture").
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
