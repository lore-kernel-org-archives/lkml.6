Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754649AbeBGQYG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:24:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49228 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754328AbeBGQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:24:04 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180207162401epoutp02a636ca1d401b868943ed69b7d4ccbc3d~RF7sUi7bX0946409464epoutp02w
X-AuditID: b6c32a48-9c5ff70000000ff0-e8-5a7b28209635
Subject: Re: [PATCH 4/8] ASoC: samsung: i2s: Define the parameters list for
 SAMSUNG_I2S_OPCLK
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <7f86ec02-2235-7622-9298-f6edd367edb2@samsung.com>
Date: Wed, 07 Feb 2018 17:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAJKOXPf-6wFDSPttdDbc34Y2hiuc=TG2j5bb+2uQeScxGuxjZg@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7bCmqa6CRnWUwf8nuhZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xcUVX5gc
        eDw2fG5i89g56y67x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlXH1w032gn3cFbOn
        /mdqYHzE0cXIySEhYCLxcc9E1i5GLg4hgR2MEuvnXGOHcL4zSjyf/pwZpmrW4QXMEIndjBIf
        Ww5AOfcZJS7t2AbUz8EhLBAv8fujB0iDiICmxPW/38HGMgu8Y5I4c+oO2CQ2AUOJ3qN9jCA2
        r4CdxJQjG9lBbBYBVYntTYdZQWxRgQiJhVOfQtUISvyYfI8FxOYUCJa49PIeE4jNDLTgxZdJ
        LBC2uMSx+zcZIWx5ic1r3oIdJyHwnU1i8qorjBAvuEg0vlzLCmELS7w6voUdwpaWeLZqIyNE
        Qz+jxIk1zVDODEaJO+0TmCCqrCUOH7/ICrGCT6Lj8F92kJclBHglOtqEIEwPiZl9JhDVjhLL
        D32HhlAHk8TFd40sExjlZiF5aBaSJ2YheWIWkicWMLKsYhRLLSjOTU8tNiow0StOzC0uzUvX
        S87P3cQITkVaHjsYD5zzOcQowMGoxMNrsKEySog1say4MvcQowQHs5IIrzt7dZQQb0piZVVq
        UX58UWlOavEhRmkOFiVx3rYAlyghgfTEktTs1NSC1CKYLBMHp1QDY4pKx/wnHzbafX3wm8GQ
        22TXBm3tiWlSMUbOJQXWM2M8Wea4F5VVSkSLSNsETPvEt6Oy0boy8a7stuqv/Jv+vnl/qKj1
        6Jn3soZHS004p4YF3tXtPms7b61YJ8tuFjfeA3MPXz8RfLrxJV/SknDzon8fJfzcj138e/zc
        k46CmrAJz1bnWle+VmIpzkg01GIuKk4EACu5GQNBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e+xgK68RnWUwZzfFhZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xcUVX5gc
        eDw2fG5i89g56y67x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlXH1w032gn3cFbOn
        /mdqYHzE0cXIySEhYCIx6/AC5i5GLg4hgZ2MEtuXn2aEcB4yStw9/AjI4eAQFoiX+P3RA6RB
        REBT4vrf76wgNcwC75gkDsy6CNXdxSSx5OJsdpAqNgFDid6jfYwgNq+AncSUIxvB4iwCqhLb
        mw6zgtiiAhESnSvns0DUCEr8mHwPzOYUCJboal/GDLKYWUBdYsqUXJAws4C4xLH7NxkhbHmJ
        zWveMk9gFJiFpHsWQscsJB2zkHQsYGRZxSiZWlCcm55bbFRglJdarlecmFtcmpeul5yfu4kR
        GDfbDmv172B8vCT+EKMAB6MSD6/BhsooIdbEsuLK3EOMEhzMSiK87uzVUUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoYq9enBnaXpkuf8env8PgfqK7w
        YXbd/+o2Y/XImIOL7QUmrlC+mX9liotcSvXb0GL9rJc+fNWXGQPseJWeFMu2fVOwOa719umH
        DClek3wlzk1bLykUdsTM9PB9WPr6asLrIg2HLUccfAUOPeO9lL12/tP7OhsEmw88O9Wikvrn
        UMaB1pyXnfOVWIozEg21mIuKEwHKFH5KlwIAAA==
X-CMS-MailID: 20180207162400epcas2p3a5e50392ce7d1a922e1dd05ee7f88c23
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4
X-RootMTR: 20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4
References: <CGME20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4@epcas1p4.samsung.com>
        <20180205154403.13520-1-s.nawrocki@samsung.com>
        <20180205154403.13520-5-s.nawrocki@samsung.com>
        <CAJKOXPf-6wFDSPttdDbc34Y2hiuc=TG2j5bb+2uQeScxGuxjZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 01:26 PM, Krzysztof Kozlowski wrote:
> On Mon, Feb 5, 2018 at 4:43 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:

>> diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
>> index 79781de2f247..a9832a9555cb 100644
>> --- a/sound/soc/samsung/i2s.h
>> +++ b/sound/soc/samsung/i2s.h
>> @@ -16,11 +16,16 @@
>>  #define SAMSUNG_I2S_DAI        "samsung-i2s"
>>  #define SAMSUNG_I2S_DAI_SEC    "samsung-i2s-sec"
>>
>> -#define SAMSUNG_I2S_DIV_BCLK   1
>> +#define SAMSUNG_I2S_DIV_BCLK           1
>>
>> -#define SAMSUNG_I2S_RCLKSRC_0  0
>> -#define SAMSUNG_I2S_RCLKSRC_1  1
>> +#define SAMSUNG_I2S_RCLKSRC_0          0
>> +#define SAMSUNG_I2S_RCLKSRC_1          1
>>  #define SAMSUNG_I2S_CDCLK              2
>> +/* Operation clock for IIS logic */
>>  #define SAMSUNG_I2S_OPCLK              3
>> +#define  SAMSUNG_I2S_OPCLK_CDCLK_OUT   0       /* CODEC clock out */
>> +#define  SAMSUNG_I2S_OPCLK_CDCLK_IN    1       /* CODEC clock in */
>> +#define  SAMSUNG_I2S_OPCLK_BCLK_OUT    2       /* Bit clock out */
>> +#define  SAMSUNG_I2S_OPCLK_PCLK                3       /* Audio bus clock */
>>
>>  #endif /* __SND_SOC_SAMSUNG_I2S_H */
> 
> This part of patch seems to be unrelated (and it includes some cleanups).

This is actually the main part of the patch, an API exported to other
drivers.  The whitespace changes are for keeping the alignment uniform,
I could just drop them.

-- 
Regards,
Sylwester
