Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755373AbeDZK0U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:26:20 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49304 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754536AbeDZK0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:26:16 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180426102614epoutp03885bee8a9758edeffc42402a5176b32b~o9XkhhU2m3190831908epoutp03T
X-AuditID: b6c32a47-bc7ff70000001011-5e-5ae1a946533f
Subject: Re: linux-next: build failure after merge of the clk-samsung tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <1a16ef47-ad28-5fc3-a06f-7bd21fd463ea@samsung.com>
Date: Thu, 26 Apr 2018 12:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180426091940.16bb1faf@canb.auug.org.au>
Content-type: text/plain; charset="windows-1252"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCmqa7byodRBkenCFicP7+B3eLyrjls
        FgcXtjFabN17ld2BxaPxxg02j02rOtk8Pm+SC2CO4rJJSc3JLEst0rdL4Mr4OX03U8FUtop9
        p7azNjC2s3YxcnJICJhI/Hp0nR3EFhLYwSix4l9lFyMXkP2dUeL9jMdMMEWnJk1mhCjawChx
        aakORNF9RokpKz6CJYQFvCQOzu5m62Lk4BAR0JY48FsApIZZYC6jxP9Ly9hAatgEDCV6j/aB
        1fMK2Els3boF7AoWAVWJOQd3gV0hKhAh0fT8JztEjaDEj8n3WEBsTgFziUsLHoH1MgsYSMyY
        cpgJwhaXOHb/JlRcXmLzmrfMIIslBDawSRw5sh3qAxeJ0827oF4Wlnh1fAs7hC0t8WzVRkYI
        u1qis62LHaK5hVHiz7RLbBAJa4nDxy+yQmzgk+g4/Jcd5EsJAV6JjjYhiBIPiSuvL0DtcpR4
        fewJCySEuhglenctZJ/AKDcLyUOzkDwxC8kTs5A8sYCRZRWjWGpBcW56arFRgbFecWJucWle
        ul5yfu4mRnCK0HLfwbjtnM8hRgEORiUe3oCFD6KEWBPLiitzDzFKcDArifDGtz6MEuJNSays
        Si3Kjy8qzUktPsQozcGiJM7b4HsmSkggPbEkNTs1tSC1CCbLxMEp1cC45kCii3/WjvWz43va
        tx5ydOswC5u89P6TH0KiPmeX1J+Y7JkwXVpd4cLMjbfiY+9stnrzladE6WF71BunTUY6ujtF
        Q64nWn9YfPnyp4VHuj+63vrRe+lx1Z6G44ZLFhw8/zIhW+e68LqfM0NVZjHIT1t0ucJlqW7K
        hijZzI/H93z+bReztGZjsRJLcUaioRZzUXEiAGJcluENAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t9jQV23lQ+jDI6vYLY4f34Du8XlXXPY
        LA4ubGO02Lr3KrsDi0fjjRtsHptWdbJ5fN4kF8AcxWWTkpqTWZZapG+XwJXxc/pupoKpbBX7
        Tm1nbWBsZ+1i5OSQEDCRODVpMmMXIxeHkMA6Rokz9w6xQzgPGSU23H3KBlIlLOAlcXB2N5DN
        wSEioC1x4LcASA2zwFxGiYk3JrFBNPQwSizb08IM0sAmYCjRe7SPEcTmFbCT2Lp1C9g6FgFV
        iTkHd7GD2KICERL3zn9ig6gRlPgx+R4LiM0pYC5xacEjRpBlzAJ6EvcvaoGEmQXEJY7dv8kI
        YctLbF7zlnkCo8AsJN2zEDpmIemYhaRjASPLKkbJ1ILi3PTcYqMCo7zUcr3ixNzi0rx0veT8
        3E2MwJDedlirfwfj4yXxhxgFOBiVeHgDFj6IEmJNLCuuzD3EKMHBrCTCG9/6MEqINyWxsiq1
        KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QD4/pDyxJb9iZ2uV41Czs2
        b0ra8VfGDxWzKuVmMrLPNF8aYFlb9L5SXZqjcsuDqSl3/q/TObV+09ugxSEPtd6enaxx6b/e
        NYuazof8KWz3yjVr+WpVD05+rin5IvmPim/+Ru7syszLX65scJMq1i66vYFNgL09YPrfKaY/
        npf+clrJffjnupjWViWW4oxEQy3mouJEACX5CiVlAgAA
X-CMS-MailID: 20180426102614epcas2p21d820163a6ae9b64a0411af11f14e967
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180425232126epcas2p1e5673f9dfc42c5e8c5e05acb70a6e352
X-RootMTR: 20180425232126epcas2p1e5673f9dfc42c5e8c5e05acb70a6e352
References: <CGME20180425232126epcas2p1e5673f9dfc42c5e8c5e05acb70a6e352@epcas2p1.samsung.com>
        <20180426091940.16bb1faf@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 04/26/2018 01:19 AM, Stephen Rothwell wrote:
> After merging the clk-samsung tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> In file included from arch/arm/boot/dts/exynos5440-sd5v1.dts:10:0:
> arch/arm/boot/dts/exynos5440.dtsi:9:10: fatal error: dt-bindings/clock/exynos5440.h: No such file or directory
>  #include <dt-bindings/clock/exynos5440.h>
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> Caused by commit
> 
>   f986c0e40ff5 ("clk: samsung: Remove support for Exynos5440")
> 
> I used the version of the clk-samsung tree from next-20180424 for today.

My apologies, somehow I didn't notice the build break earlier.
I drop the above mentioned commit from the for-next branch for now.

-- 
Regards,
Sylwester
