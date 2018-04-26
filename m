Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755608AbeDZJz7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:55:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32777 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754801AbeDZJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:55:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180426095545euoutp0165f618bed98e5a5c40f6f59a1b0826ec~o889Wb5y90612706127euoutp01N
X-AuditID: cbfec7f2-1c1ff70000011644-81-5ae1a220f65e
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] video: sh_mobile_lcdcfb: Delete an error message for a
 failed memory allocation in two functions
Date: Thu, 26 Apr 2018 11:55:43 +0200
Message-id: <4464673.qDa0qndI0l@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <478c51ab-b4ef-47e1-0b53-8b4e1f3b931a@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOV2FRQ+jDNo3yVpc613IbHHl63s2
        i/Ody5kt5s6exGhxpjvXYustaYsTfR9YLS7vmsNmcfjLLjYHTo/ZDRdZPCae1fXYOesuu0fL
        kbesHve7jzN5NJ1qZ/X4vEkugD2KyyYlNSezLLVI3y6BK+Pbxmbmgq8sFUfvPmRrYPzP3MXI
        ySEhYCLxaNF1ti5GLg4hgRWMErfX/GKEcD4zSrz6+BOoigOs6lKTPkR8GaPE1uW3mUC6hQR+
        M0ocvVcBYrMJWElMbF/FCFIvImAq8edECEg9s8B6JolXE0+ygtQIC5RLLLr8lwXEZhFQlWhq
        6QCL8wpoSpy7/ZQRxBYV8JLYsq8dbD6ngKdE95z1LBA1ghI/Jt8Ds5kF5CX27Z/KCmHrSJw9
        tg7saAmB62wS5yZeZYd4zUVi9cLNjBC2sMSr41ug4jISlyd3s0A0NDNKfNuxBxoWExgl9qwX
        grCtJQ4fvwi1gU9i0rbp0JDglehogyrxkLh2/TYrhO0ocbTlOCskhOYwSvS0zGGawCg7C8nh
        s5AcPgvJ4QsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJpLT/45/2sH49VLSIUYB
        DkYlHt4f8x5ECbEmlhVX5h5ilOBgVhLhjW99GCXEm5JYWZValB9fVJqTWnyIUZqDRUmcN06j
        LkpIID2xJDU7NbUgtQgmy8TBKdXAWHj3SYX+lRds/zJmn1uh/OrMzJm/mu4edxfZfdc9Za1a
        4RxP0V9nWQ7sy3ldfXju0Vqnh+d+H7y356TweZEUxkq3JcmPFjt9YPpnKHhGWCp5wUbb09/+
        sGUJf+b2Nlj57KH/bjHWc+JOC1KDJd4mt7V2NwYeD9yudOGQh8OcW4Zq0gayMb0KoUosxRmJ
        hlrMRcWJAGJdnV4gAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsVy+t/xa7ryix5GGVztMrG41ruQ2eLK1/ds
        Fuc7lzNbzJ09idHiTHeuxdZb0hYn+j6wWlzeNYfN4vCXXWwOnB6zGy6yeEw8q+uxc9Zddo+W
        I29ZPe53H2fyaDrVzurxeZNcAHsUl01Kak5mWWqRvl0CV8a3jc3MBV9ZKo7efcjWwPifuYuR
        g0NCwETiUpN+FyMXh5DAEkaJx1vfskE4fxklzj84wN7FyMnBJmAlMbF9FSNIg4iAqcSfEyEg
        NcwC65kktv9eywpSIyxQLrHo8l8WEJtFQFWiqaUDLM4roClx7vZTRhBbVMBLYsu+diYQm1PA
        U6J7znoWiGXzGCXObv/CDtEgKPFj8j2wQcwC8hL79k9lhbC1JNbvPM40gZF/FpKyWUjKZiEp
        W8DIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw3Lcd+7llB2PXu+BDjAIcjEo8vD/mPYgS
        Yk0sK67MPcQowcGsJMIb3/owSog3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB9MSS1OzU
        1ILUIpgsEwenVANj1ZG7CmL/DezS7l71tgkIfVJuoP3aeHlu+d3SiKT0SUY+8moCKzkuldws
        nBm/5djFo2sE8uZe9ReYIZUWtL3y9X6lvdILRNTyZ5u/b7OWev92j+CGfRW5kgH1AbMsnvhc
        m6u3e9XXO5viXf/UelTfnTfhZ63d75/591xO2K8Izt7EpPe9eGWmEktxRqKhFnNRcSIAMaX2
        FHMCAAA=
X-CMS-MailID: 20180426095543eucas1p205797209c30e6d08673a6b1b829990ec
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171126130035epcas1p3facfaae6b81c00dc4c9d255e5b8b8bc0
X-RootMTR: 20171126130035epcas1p3facfaae6b81c00dc4c9d255e5b8b8bc0
References: <CGME20171126130035epcas1p3facfaae6b81c00dc4c9d255e5b8b8bc0@epcas1p3.samsung.com>
        <478c51ab-b4ef-47e1-0b53-8b4e1f3b931a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 26, 2017 02:00:16 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 13:48:55 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
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
