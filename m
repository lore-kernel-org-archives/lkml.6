Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeENV5x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:57:53 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52038 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbeENV5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:57:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180514215746epoutp0345e279582d3cf9a11796d817e67ce4ff~uoafcb2YB1251112511epoutp036
X-AuditID: b6c32a45-8f3ff70000001020-f4-5afa0656d41b
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AFA0656.6040701@samsung.com>
Date: Tue, 15 May 2018 06:57:42 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: myungjoo.ham@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dbasehore@chromium.org" <dbasehore@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "hl@rock-chips.com" <hl@rock-chips.com>
Subject: Re: [PATCH v4 6/6] devfreq: rk3399_dmc: fix spelling mistakes.
In-reply-to: <20180514102355epcms1p5baf3df2741827f9b9bf3e1de37e27880@epcms1p5>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUYRTt29mZHaOtac36MNJtQChJc3bdHCsjy2wgEaHoYZQOOrnmPmRn
        17KCVql89MAsRE0qIyo2DdMePjN2xUJxe2i6lQq9zdJKe5hgNrtj5K/v3MO5373ncHFEcRXz
        xVMNZs5kYHUkNlN6x7FUE7QNG48P6fwqoQdrGjH6QosTpSte2gHdNngFoSdff0Lpsao2hK5x
        nkDpjuzPMrqzvgyjR0+2APpl1jWMPtrUIqMfVG5bK2fOWZ9Imdq+y4CptuVhTG93I8ZMlDZL
        mVO3bIC5230eYUar/eLweG61lmOTOZOSMyQZk1MNKRHkps0J6xM0K0KoICqcDiOVBlbPRZBR
        MXFB0ak6YWVSmcHqLAIVx/I8uXzNapPRYuaUWiNvjiB3UpQqmAoJC1aphFe9a6VKI0gSOW32
        JxdIz0X3D2XrrOC4NB944ZAIhSP3K7B8MBNXELUADjuyZGLxC8DC2wNCgXtUzfk+7gYFUQXg
        i8Hlbiwn5sKxM/1StwQh/GHL0zQ3jRBL4cD3Qqn4TR+AR0bOIqI+EPZ2OzyDpUQAbP3W4MGY
        wDcPuDA3nkMshs/G3gA39iG2w7oLPz37zCMqAbw80u4pEOIRAv+cuYO6J3sTG+G9yVXuBi8i
        Ftb86vC4gUSODBYVXZKJNqNg8ZcriIi94eCDW1P8QvjedhNMNQCY03QeEYuzADp7+iWiSg3f
        l+dLRHOzYa5jYioWOcw9phAlDCz52I6KOBJedLVO+T8qgcOF9ZIC4Fc6LbLS/5GVTovsIkBs
        YD6XzutTOF6VTgXzrJ63GFKCk4z6auA50sANtaDYGWMHBA7IWfLEot/xCpTN4DP1dgBxhJwn
        b1AJlDyZzTzAmYwJJouO4+1AIyR+GvH1STIKJ28wJ1AalVqtpjVh4eqQcHKBvIL8Ea8gUlgz
        l8Zx6ZzpX58E9/K1gtYbsO1D9bqqIWpL83OZJtJunf8ODbWV99B7luXNCHUtyfn+JCA6dtSo
        zyJ7KzcyhzRfuybKfK4v1mr9d9cVDFPKqq3jeVGN6EHL2/KDx9uWdPi/nl3cuXflo5jMKGuP
        y2/HinMFr3Jwvy7jovCymsaGfY5o72PtJc5lDw/3bn36mJTyWpYKREw8+xfIca6SugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e+xoG4Y268og94VihavNu9hs5h/5Byr
        xZrbhxgtTr1axmzx/9FrVosfG04xW2w+18NqcbbpDbvF5V1z2Cw+9x5htLjduILNonXvEXaL
        42vDHXg9ZjdcZPHYcXcJo8emVZ1sHneu7WHz+DtrP4tH35ZVjB7br81j9vi8SS6AI4rLJiU1
        J7MstUjfLoEro+n1DcaCDtaKt005DYzdLF2MHBwSAiYS+7tEuxg5OYQE1jFKfO2rBLF5BQQl
        fky+B1bCLCAvceRSNoSpLjFlSi5E9X1GiSdb9SCqtSTuXDvMAmKzCKhKHPu4G8xmA4rvf3GD
        DcTmF1CUuPrjMSPIGFGBCInuE2CLRATWM0rsO8/RxcgFNP0ys8SF05+YQWqEBdwl9v23BokL
        CbQySUxY1ccK0sAp4Cex+ftZtgmMArOQHDoL4dBZCIcuYGRexSiZWlCcm55bbFRglJdarlec
        mFtcmpeul5yfu4kRGDfbDmv172B8vCT+EKMAB6MSD2/CtJ9RQqyJZcWVuYcYJTiYlUR4dxsB
        hXhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTCmMkgJlf2P
        t2d/kv9x14cnhyI65DT051seCmWTC3s+b8uEF4a7ZhjOFjI/t6Y1403Zx/9+1zinnBRg2XLT
        8hO/zqLHFVq6ZT++aa3/YbtKMYFnRXXuA+XstTdvFjHetP1zsp9XhX/m5T3WW7KcGc53nFvo
        e/J825MTq5pmMc5nnztnxvnvkq+mKbEUZyQaajEXFScCAK61DnqXAgAA
X-CMS-MailID: 20180514215742epcas2p276f9519d47450c9c29b2969e6b55d8fe
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180509125806epcas3p42927285eece7f031ad7c9e422ee0a43c
X-RootMTR: 20180509125806epcas3p42927285eece7f031ad7c9e422ee0a43c
References: <20180509125749.31318-7-enric.balletbo@collabora.com>
        <20180509125749.31318-1-enric.balletbo@collabora.com>
        <CGME20180509125806epcas3p42927285eece7f031ad7c9e422ee0a43c@epcms1p5>
        <20180514102355epcms1p5baf3df2741827f9b9bf3e1de37e27880@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 05월 14일 19:23, MyungJoo Ham wrote:
>> Fix some spelling mistakes in error and debug messages.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v4:
>> - [6/6] Introduce this new patch that fixes some spelling.
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>> drivers/devfreq/rk3399_dmc.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Maybe, when you apply this patch on devfreq.git,
you are missing the my reviewed-by tag.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
