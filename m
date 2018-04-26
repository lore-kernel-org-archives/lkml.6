Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755509AbeDZKcY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:32:24 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23995 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754723AbeDZKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:32:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180426103216epoutp02d530a8a11ca68d0aa08d4f566f7f6771~o9c11ZHMu3136431364epoutp02R
X-AuditID: b6c32a47-bdfff70000001011-f5-5ae1aab08876
Subject: Re: linux-next: build failure after merge of the clk-samsung tree
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <c5139744-ca32-cfaf-c79a-f718ddd3c3f9@samsung.com>
Date: Thu, 26 Apr 2018 12:32:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <CAJKOXPexiwOyPwmAV8KQj4JAnWHYYP4o8eVYodhvRYfKFGVbNw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCmme6GVQ+jDNbclLE4f34Du8XlXXPY
        LA4ubGO0mHF+H5PF1r1X2R1YPRpv3GDz2LSqk83j8ya5AOYoLpuU1JzMstQifbsErowLk+0L
        rrBVNE57x9TAuI61i5GDQ0LARGLZZvUuRi4OIYEdjBLrFi5mhHC+M0os/bgWrmjSPIcuRk6g
        +G5GidYpfBA19xklLr36wwiSEBbwkjg4u5sNxBYR0JS4/vc7K0gRs8ArRokXd68wgyTYBAwl
        eo/2gTXwCthJ/Lu9GsxmEVCVeDELYpCoQIRE0/Of7BA1ghI/Jt9jAbE5BYIl5k6bBRZnBlrw
        4sskFghbXOLY/ZuMELa8xOY1b5lBFksIbGCTWNDYCJaQEHCROPdjATuELSzx6vgWKFta4tmq
        jVA11RKdbV3sEM0tjBJ/pl1ig0hYSxw+fpEVYgOfRMfhv+yQYOGV6GgTgijxkDh19i4ThO0o
        0bxwEQskiC4ySpy+2cs4gVFuFpKHZiF5YhaSJ2YheWIBI8sqRrHUguLc9NRiowJjveLE3OLS
        vHS95PzcTYzgVKHlvoNx2zmfQ4wCHIxKPLwBCx9ECbEmlhVX5h5ilOBgVhLhjW99GCXEm5JY
        WZValB9fVJqTWnyIUZqDRUmct8H3TJSQQHpiSWp2ampBahFMlomDU6qBkavit8j8+1nG9xR1
        FYPf5X0IyvTacmzftLz0UPMj0g++aSpWbcqc8IDV+jFr+e8nIb9ufFk4f3aOY+wicxW/8htm
        2smXpuqd79Q2u36vdlVlxpOZz3V88kXkopZM/fvy9vXUpWtrim9EOab/yZ3eo7BkYkcxe062
        VH5dzrHwV94b7v3tOX3yhRJLcUaioRZzUXEiAB6z2vwRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t9jAd31qx5GGbydKGJx/vwGdovLu+aw
        WRxc2MZoMeP8PiaLrXuvsjuwejTeuMHmsWlVJ5vH501yAcxRXDYpqTmZZalF+nYJXBkXJtsX
        XGGraJz2jqmBcR1rFyMHh4SAicSkeQ5djJwcQgI7GSV2bRTqYuQCsh8ySuz+v5UNJCEs4CVx
        cHY3mC0ioClx/e93VpAiZoFXjBI3G8+wQnTXShw4MAGsiE3AUKL3aB8jiM0rYCfx7/ZqMJtF
        QFXixaw/YLaoQITEvfOf2CBqBCV+TL7HAmJzCgRLLH/+ixnkOGYBdYkpU3JBwswC4hLH7t9k
        hLDlJTavecs8gVFgFpLuWQgds5B0zELSsYCRZRWjZGpBcW56brFRgVFearlecWJucWleul5y
        fu4mRmBYbzus1b+D8fGS+EOMAhyMSjy8AQsfRAmxJpYVV+YeYpTgYFYS4Y1vfRglxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgXGpRbba8ecHcxcFZ19/
        1aZm/8z3RsgmUb5SocBcQ8dXNyc81LevuLaQv2xOZMLU01Mtrs845bb1ycdHtfLVTzYL+p/V
        Ny29/+ndGvOGGVlLdvrfC7rTUNq/UYbpiDhnQXFlsajRR3OhZ3dDC5JqNfMYD7SVL20wVsx9
        G5iZ9qsiNvG90Y0AbSWW4oxEQy3mouJEAGz4v2ZnAgAA
X-CMS-MailID: 20180426103215epcas2p32c60d927d618a82075b051b1f0624216
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180426103215epcas2p32c60d927d618a82075b051b1f0624216
X-RootMTR: 20180426103215epcas2p32c60d927d618a82075b051b1f0624216
References: <20180426091940.16bb1faf@canb.auug.org.au>
        <CAJKOXPexiwOyPwmAV8KQj4JAnWHYYP4o8eVYodhvRYfKFGVbNw@mail.gmail.com>
        <CGME20180426103215epcas2p32c60d927d618a82075b051b1f0624216@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 09:29 AM, Krzysztof Kozlowski wrote:
> On Thu, Apr 26, 2018 at 1:19 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>> After merging the clk-samsung tree, today's linux-next build (arm
>> multi_v7_defconfig) failed like this:
[...]
>> Caused by commit
>>
>>   f986c0e40ff5 ("clk: samsung: Remove support for Exynos5440")
>>
>> I used the version of the clk-samsung tree from next-20180424 for today.
> 
> Thanks for the report, kbuild also mentioned this. The DTS which are
> using this header are removed in first patch of patchset... which was
> not applied yet and anyway would end in different tree. I think the
> patch removing clk header should wait till DTS change get merged into
> mainline.

Yes, let's remove all related dts parts first and then drivers in
subsequent release.

--
Regards,
Sylwester
