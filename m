Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754827AbeDPNJ1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:09:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52427 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754192AbeDPNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:09:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180416130922euoutp01e40790250282643b6368abbac4d950b1~l7JJ4Kdzx2474224742euoutp01M
X-AuditID: cbfec7f4-b4fc79c0000043e4-24-5ad4a07eba47
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] arm64: dts: exynos: remove no longer needed
 samsung thermal properties
Date: Mon, 16 Apr 2018 15:09:13 +0200
Message-ID: <3588882.B9zsMSkHUz@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <3af07b96-dd74-336e-1261-dda2cde9abaa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7p1C65EGXw+Ymwx77Osxfwr11gt
        +h+/ZrY4f34Du8XlXXPYLD73HmG0mHF+H5PFk4d9bA4cHjtn3WX3WLznJZPHplWdbB53ru1h
        8/i8SS6ANYrLJiU1J7MstUjfLoEro+3CZ+aCc6wVU6aqNzBeZ+li5OSQEDCROHDzKWMXIxeH
        kMAKRomWc8uYQBJCAl8YJc6+U4FIfGaUON/9ihWm43/LaiaIxHJGiTkvr7JAOB8YJW59OsAM
        UsUmYCUxsX0VI4gtIqAn0fi+DayDWeATo8TSpk52kISwQLLE+V1zwIpYBFQlHrdNA7N5BTQl
        /jw9BDZIVMBLYsu+drCbOAXsJC4+eMcKUSMocXLmE7AnmAXkJTouN7KCLJAQWMYu8aR5FhvE
        rS4SE48fZoawhSVeHd/CDmHLSPzfOZ8JoqGZUeLbjj1QRRMYJfasF4KwrSUOH78INJUDaIOm
        xPpd+hBhW4k5i7eyg4QlBPgkbrwVhLiBT2LStunMEGFeiY42qCFqEhuWbWCD2dq1cyXUIg+J
        SZ8eM09gVJqF5JtZSL6ZhbB3ASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMCUc/rf
        8S87GHf9STrEKMDBqMTDu+Ps5Sgh1sSy4srcQ4wSHMxKIrzLEoFCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeeM06qKEBNITS1KzU1MLUotgskwcnFINjBYXl23OF5TJO5u4xEVMXnGCavTT1F3z
        LJ8yPlX3kc34aMMne4E/cnKj2+XdEwxsuHLD9CM/NqxZE9UyY2biplDPijfOz+YoXJda/Kw9
        b2qR/ddrm0LlSy9s+eReIbrE0/xSZTVzaUmm4oxtBu/kb1uzf2Tq/ZweU73/yLFb8a+/1utl
        37t4XYmlOCPRUIu5qDgRACoAwrc1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7o1C65EGbR2ylnM+yxrMf/KNVaL
        /sevmS3On9/AbnF51xw2i8+9RxgtZpzfx2Tx5GEfmwOHx85Zd9k9Fu95yeSxaVUnm8eda3vY
        PD5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
        S9DLaLvwmbngHGvFlKnqDYzXWboYOTkkBEwk/resZupi5OIQEljKKDGlbRKQwwGUkJE4vr4M
        okZY4s+1LjaImneMEjuvPmQCSbAJWElMbF/FCGKLCOhJNL5vAxvELPCGUeLong+sIAlhgUSJ
        /Vf7mUFsFgFVicdt08AaeAU0Jf48PQQWFxXwktiyrx1sKKeAncTFB+9YIbbtYJRYcmY7O0SD
        oMTJmU/AzmYWkJfouNzICmHrSCzY/YltAqPgLCRls5CUzUJStoCReRWjSGppcW56brGRXnFi
        bnFpXrpecn7uJkZgNG079nPLDsaud8GHGAU4GJV4eHecvRwlxJpYVlyZe4hRgoNZSYR3WSJQ
        iDclsbIqtSg/vqg0J7X4EKMp0HcTmaVEk/OBkZ5XEm9oamhuYWlobmxubGahJM573qAySkgg
        PbEkNTs1tSC1CKaPiYNTqoHR/EueQVHA9KTugGlCW70MlcudH8t0hAYu2P1zrnfq+6fdq9+x
        Jp5MXbw575vB95rW5NK3nPbFqvvf8OR9mRT8x7j88R9N37bSzQqKu67VpUvknr9p3hHJb5Ms
        eo0l+eXN5ytS89XTTO8rRt7NyF59vJ5dj0XUY5Np/0MJdR9mCT/LPWE+rEosxRmJhlrMRcWJ
        AKoE1PC8AgAA
X-CMS-MailID: 20180416130917eucas1p10012e5d79bf59adc677e7e2364bae589
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180416130917eucas1p10012e5d79bf59adc677e7e2364bae589
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180416130917eucas1p10012e5d79bf59adc677e7e2364bae589
X-RootMTR: 20180416130917eucas1p10012e5d79bf59adc677e7e2364bae589
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <1523873525-23718-15-git-send-email-b.zolnierkie@samsung.com>
        <3af07b96-dd74-336e-1261-dda2cde9abaa@linaro.org>
        <CGME20180416130917eucas1p10012e5d79bf59adc677e7e2364bae589@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 16, 2018 03:02:45 PM Daniel Lezcano wrote:
> On 16/04/2018 12:12, Bartlomiej Zolnierkiewicz wrote:
> > Remove no longer needed samsung thermal properties.
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> Can you add an additional patch to remove the Documentation ?

"dt-bindings: thermal: remove no longer needed samsung thermal properties"
(https://www.spinics.net/lists/linux-samsung-soc/msg62324.html)
is already present in linux-soc-thermal-tree (Eduardo has not dropped it)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
