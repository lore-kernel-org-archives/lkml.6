Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeEOKkd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:40:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59665 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbeEOKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:40:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180515104028euoutp02f6f7962634e21cefba6f467ddb7ec422~uy0bGAfhM2740327403euoutp02G
X-AuditID: cbfec7f5-f95739c0000028a9-e5-5afab91b580a
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Colin King <colin.king@canonical.com>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: nvidia: fix spelling mistake: "scaleing"
 -> "scaling"
Date: Tue, 15 May 2018 12:40:26 +0200
Message-id: <4852033.6YcN95eNri@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180508223619.25557-1-colin.king@canonical.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djP87rSO39FGcx+rWzxs/sLm8Xv1b1s
        Fle+vmez2HpL2uJE3wdWi8u75rA5sHnMauhl89g56y67x/3u40wenzfJBbBEcdmkpOZklqUW
        6dslcGWs2P2XreAfU8WJqa3MDYzbmboYOTkkBEwkjs7aw97FyMUhJLCCUWJb4yFGCOczo8Tf
        RU3sMFXf/l9jBrGFBJYxSvw6lQFR9JtR4tP8h2wgCTYBK4mJ7auAujk4RAQ0Jc6fKwKpYQaZ
        umLZErAaYYEoiQf/21lBbBYBVYmJW3rBFvAC1S/vXwgWFxXwktiyrx3sPE4BO4lz548wQdQI
        SvyYfI8FxGYWkJfYt38qK4StI3H22DpGiEPXsEn0rTCHsF0kZr6cwQJhC0u8Or4F6hkZic6O
        g0wgx0kINDNKfNuxhxkiMYFRYs96IQjbWuLw8YtQC/gkJm2bzgzymIQAr0RHG1SJh8S/pmts
        ELajxK0D69gggTKRUaJzyTLWCYyys5DcPQvJ3bOQ3L2AkXkVo3hqaXFuemqxcV5quV5xYm5x
        aV66XnJ+7iZGYEI4/e/41x2M+/4kHWIU4GBU4uHdMeNnlBBrYllxZe4hRgkOZiUR3t1GQCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQbGWZMbF1bzn2oT
        FVi067J6odWLuaEWq/en7liefivWNP9x2j7tmRdtF66bPadniZafQ3lseWnjnsflUX69J44K
        Gl/cyLVry727S3O4H3kJNfs6anfcOZayjtdAWm9VHCcz9/Jtqx7G39+vcLQgd+/irIO5N02N
        7syavv7pmqi5Eslz72UdkdfUVGIpzkg01GIuKk4EAJlY/VsEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xa7rSO39FGXzoYrf42f2FzeL36l42
        iytf37NZbL0lbXGi7wOrxeVdc9gc2DxmNfSyeeycdZfd4373cSaPz5vkAliiuGxSUnMyy1KL
        9O0SuDJW7P7LVvCPqeLE1FbmBsbtTF2MnBwSAiYS3/5fY+5i5OIQEljCKHFq/SoWCOcvo8ST
        nV+YQarYBKwkJravYuxi5OAQEdCUOH+uCKSGWWAFo8TlKxcYQWqEBaIkzj+dyQ5iswioSkzc
        0gtm8wLVL+9fyApiiwp4SWzZ1w62mVPATuLc+SNMEMsmM0qsOvuOCaJBUOLH5HssIDazgLzE
        vv1TWSFsLYn1O48zTWDkn4WkbBaSsllIyhYwMq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQI
        DNxtx35u3sF4aWPwIUYBDkYlHt4dM35GCbEmlhVX5h5ilOBgVhLh3W0EFOJNSaysSi3Kjy8q
        zUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cA4SdfTT6RHrl04ReFqeq7f6oUR
        4mdcNj541KznWVNyPH22irxtPRNfRmXPtL81F89e9Vox4cvih096Cu4Vqlw/suFHcCRr8hKZ
        vEfxvmo+q/xEHdKFZI2aLs0+aLTwukiNwrfzQmXGSh27DihNfVbhKBdS9endsiQzi/6Xmr2L
        lLbXh/DMfK/EUpyRaKjFXFScCABIlL6EWAIAAA==
X-CMS-MailID: 20180515104027eucas1p122da87db149d329c46e503b67e490e2f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180508223625epcas4p11ee0896ceeab3370f3f70be708ce514a
X-RootMTR: 20180508223625epcas4p11ee0896ceeab3370f3f70be708ce514a
References: <CGME20180508223625epcas4p11ee0896ceeab3370f3f70be708ce514a@epcas4p1.samsung.com>
        <20180508223619.25557-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 08, 2018 11:36:19 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in module parameter description text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
