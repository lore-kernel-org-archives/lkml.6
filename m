Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755573AbeDZJ6X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:58:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33477 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755074AbeDZJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:58:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180426095815euoutp0126350eed63131b5a0deca176c3b97340~o8-JSgNVt0709907099euoutp01O
X-AuditID: cbfec7f4-b4fc79c0000043e4-3f-5ae1a2b66ad9
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] video: auo_k190x: Delete an error message for a failed
 memory allocation in auok190x_common_probe()
Date: Thu, 26 Apr 2018 11:58:13 +0200
Message-id: <12927877.qfyOtgPPrp@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <757f0d7c-e356-2e69-46e6-0bf5067877e1@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7rbFj2MMmg8K2Jx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsFqv/nWJ0YPPYtKqTzeN+93Emj6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGV8XraereAzS8XhRSdYGxj/MncxcnJICJhILD+2jqmLkYtDSGAFo8T2LTPYIZzPQM6M
        GXBVx96vh0osY5R4/f4yWEJI4DejxL6FnCA2m4CVxMT2VYxdjBwcIgKmEn9OhIDUMwusYpR4
        Pu8zI0iNsECVRG/XPHYQm0VAVeLA8nksIDavgJbEvy1rwWaKCnhJbNnXzgRicwp4Srxb+pcJ
        okZQ4sfke2D1zALyEvv2T2WFsHUkzh5bxwiyTEJgA5vEtbNfoK52kbh3bg4LhC0s8er4FnYI
        W0bi8uRuFoiGZkaJbzv2QDVMYJTYs14IwraWOHz8ItQGPolJ26Yzg3wmIcAr0dEGVeIBDLsp
        TBBhR4kpzyIhATSHUWLduunMExhlZyG5exaSu2chuXsBI/MqRvHU0uLc9NRio7zUcr3ixNzi
        0rx0veT83E2MwIRw+t/xLzsYd/1JOsQowMGoxMP7Y96DKCHWxLLiytxDjBIczEoivPGtD6OE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YWpBbBZJk4OKUaGA1L5R7x3OKV
        nuJ+kWWu0bHqmxMnXt1wfLPxwt1rfzEI1hVsWNzZuP/NNc22DV+MDp9OXjhXd/kFY3Xr47w+
        xQ9/TIxYyKi80fvRGtZMT2Ge3YVM2zMvasgs/thzu+X1ox6mw9N1LnPYl87/3j+/4mhc1iTR
        lElm86V2Hd13h2X/USF1Z6fAJ++VWIozEg21mIuKEwGvw6+6BAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xy7pbFz2MMuh5oWdx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsFqv/nWJ0YPPYtKqTzeN+93Emj6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGV8XraereAzS8XhRSdYGxj/MncxcnJICJhIHHu/nh3EFhJYwihxe08BhP2XUeLRnlwQ
        m03ASmJi+yrGLkYODhEBU4k/J0K6GLk4mAVWMUps3LGQDaRGWKBKordrHtgcFgFViQPL57GA
        2LwCWhL/tqwF2yUq4CWxZV87E4jNKeAp8W7pXyaQQUIC8xgltr7dxgrRICjxY/I9sGZmAXmJ
        ffunskLYWhLrdx5nmsDIPwtJ2SwkZbOQlC1gZF7FKJJaWpybnltspFecmFtcmpeul5yfu4kR
        GLTbjv3csoOx613wIUYBDkYlHt4f8x5ECbEmlhVX5h5ilOBgVhLhjW99GCXEm5JYWZValB9f
        VJqTWnyIUZqDRUmc97xBZZSQQHpiSWp2ampBahFMlomDU6qB8eBHm0UlMRdvPFW53241h6/0
        srH92Ucbp99k6NY4XrH6XeaRGzvPr/gfslXy+4tvjpn627L4Hgptuzv1RomrQME117u7un7F
        nTnhr8eULLNc+c+NeQ2uN/u//Lvb+3vr7Cdm6ow9+v/VKj/P+ll9lLvZaG/a0jXlk66vVPBy
        usNlx3fykmuPKr8SS3FGoqEWc1FxIgAw4bOtVgIAAA==
X-CMS-MailID: 20180426095813eucas1p24bbcc65517006d4de7af0eff53f5e282
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171127170150epcas3p2bd5a7ba3a64c7a4f03ab823cf3707ebe
X-RootMTR: 20171127170150epcas3p2bd5a7ba3a64c7a4f03ab823cf3707ebe
References: <CGME20171127170150epcas3p2bd5a7ba3a64c7a4f03ab823cf3707ebe@epcas3p2.samsung.com>
        <757f0d7c-e356-2e69-46e6-0bf5067877e1@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 27, 2017 06:01:41 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 27 Nov 2017 17:53:05 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I've done requested audit regarding multiple fb devices support
myself now and it is okay to apply this patch.

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
