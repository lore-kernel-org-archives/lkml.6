Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbeC1OIs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:08:48 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:64781 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeC1OIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:08:46 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180328140844epoutp04b3d81a98f7bb3841aa2cd9e61a1e33ee~gGsj4D9af2470924709epoutp042
X-AuditID: b6c32a46-b85ff70000000fe8-34-5abba1ec247d
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] video: matroxfb: Delete an error message for a failed
 memory allocation in matroxfb_crtc2_probe()
Date: Wed, 28 Mar 2018 16:08:40 +0200
Message-id: <6216878.7tvrGbX39k@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <f903f284-bdba-7eb7-c666-301577fcfa94@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCmue6bhbujDE628Vlc+fqezeJ853Jm
        i623pC1O9H1gtbi8aw6bA6vH/e7jTB5Np9pZPT5vkgtgjuKySUnNySxLLdK3S+DKOHljNltB
        A0vFh/m9jA2MC5m7GDk5JARMJPov/mTvYuTiEBLYwSjx8OoPVgjnO6PE4V0PgRwOsKrf60oh
        4hsYJS5PnQPV8ZVR4syGG+wgo9gErCQmtq9iBGkQETCV+HMiBKSGWaCDUWLj8SksIDXCAhUS
        fXcug9WzCKhKrPt6ng3E5hXQlJj2vwGsRlTAS2LLvnYmEJtTwFPi6NeDjBA1ghI/Jt8Dq2EW
        kJfYt38qK4StI3H22DpGkGUSAkvYJFYt2gbUzA7kuEi8SYb4Ulji1fEt7BC2tMSzVRuhypsZ
        Jb7t2AMNigmMEnvWC0HY1hKHj1+Ems8n0XH4LzskIHglOtqgSjwkPnz4yghhO0qc/LcRGnBz
        GCX2v9vLNIFRdhaSs2chOXsWkrMXMDKvYhRLLSjOTU8tNiow0itOzC0uzUvXS87P3cQIjnwt
        tx2MS875HGIU4GBU4uEtiNkVJcSaWFZcmXuIUYKDWUmE973G7igh3pTEyqrUovz4otKc1OJD
        jNIcLErivK0BLlFCAumJJanZqakFqUUwWSYOTqkGxqPC8w50bI9+/2Bd3eHd5i/tbO68L9cV
        P+f456btxrm3OHRab2mv79gm1a8XWnhmT73B611OYevn/f9yns3T9JLKlX6OCxz2vbaWG1df
        Vbd78rwz47xcyfpihSdzPDjfTzv9KeBBS/MDx6ByTnlb392LZvi/U1ttzdl1WmtHU+OBxNvv
        f5T4yimxFGckGmoxFxUnAgBbJxb++AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsVy+t9jQd3XC3dHGfz/Z2Bx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsDqwe97uPM3k0nWpn9fi8SS6AOYrLJiU1J7MstUjfLoEr4+SN2WwF
        DSwVH+b3MjYwLmTuYuTgkBAwkfi9rrSLkYtDSGAdo0RPWztbFyMnkPOVUeL5SQsQm03ASmJi
        +ypGkHoRAVOJPydCQOqZBToYJSb+W8IMUiMsUCHRd+cyO4jNIqAqse7rebA5vAKaEtP+N7CA
        2KICXhJb9rUzgdicAp4SR78eZIRYPI9RYl7bfEaIBkGJH5PvgTUwC8hL7Ns/lRXC1pJYv/M4
        0wRG/llIymYhKZuFpGwBI/MqRsnUguLc9NxiowKjvNRyveLE3OLSvHS95PzcTYzAUN12WKt/
        B+PjJfGHGAU4GJV4eAtidkUJsSaWFVfmHmKU4GBWEuF9r7E7Sog3JbGyKrUoP76oNCe1+BCj
        NAeLkjgvf/6xSCGB9MSS1OzU1ILUIpgsEwenVAPj7qq6VdMXr7/nYu38vVW1iKt335JM45dN
        GQFVa5O3PtSy7OF0m2eSz+Y0t+ZQz8mu1aZsVVnhPls3xTjq/Lv4sv7h2xWbDXkPWix+8vh/
        E9f+SG4NwTN2d6zbvpTn+lkwfbOVZTLe8qtXckZEHbNh3fSXv5sa3/gwFyl+63v3ouapXZGO
        yy4lluKMREMt5qLiRADKXUPeUQIAAA==
X-CMS-MailID: 20180328140843epcas2p16f5bdf5034e8783a2e73acc0deae70f6
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171126213211epcas5p16bb3e55e1ca996b6ee57286abf39ce44
X-RootMTR: 20171126213211epcas5p16bb3e55e1ca996b6ee57286abf39ce44
References: <CGME20171126213211epcas5p16bb3e55e1ca996b6ee57286abf39ce44@epcas5p1.samsung.com>
        <f903f284-bdba-7eb7-c666-301577fcfa94@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 26, 2017 10:32:06 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 22:13:55 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
