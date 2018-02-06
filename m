Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBFCJ6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:09:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:18110 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeBFCJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:09:49 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180206020947epoutp01ea6725d98374850cd8502d14aa4b44c4~QmojbZ_CI1916919169epoutp016
X-AuditID: b6c32a36-c91ff70000001028-db-5a790e4ebad1
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A790E4F.7060701@samsung.com>
Date: Tue, 06 Feb 2018 11:09:19 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, tomasz.figa@gmail.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH] clk: samsung: Add git tree entry to MAINTAINERS
In-reply-to: <20180205144158.10500-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTV9ePrzLK4NcEYYuNM9azWpw/v4Hd
        4mPPPVaLy7vmsFnMOL+PyWLtkbvsFhdPuVocftPOavHjTDeLxapdfxgduDze32hl97jc18vk
        sXPWXXaPTas62Tz6tqxi9Pi8SS6ALSrVJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DS
        wlxJIS8xN9VWycUnQNctMwfoMiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVK0oaGRnqGB
        uZ6RkZGeiXGslZEpUElCasalMz8ZC3rYKzpuODQw/mTtYuTkkBAwkViw8ClTFyMXh5DADkaJ
        h+8PMUI43xkl5r88zAxTdW7eBKiq3YwS5xvbmUASvAKCEj8m32PpYuTgYBaQlzhyKRskzCyg
        KbF193p2iPp7jBJ3/86EqteS+DhlJthQFgFViYXLIRawAcX3v7jBBmLzCyhKXP3xmBHEFhWI
        kNg5/xs7yHwRAS+JeQ26IDOZBa4wSvy7uA7sBWEBF4kph/eA1XMK2Eis3j2FCeLo12wS7z7F
        QNguEjtv9zNC2MISr45vAZspISAtcemoLchMCYF2Ron2vfOYIZwpjBLnrt+DGmQs8WxhFxPE
        Z3wS7772sEI080p0tAlBlHhInNhyiAXCdpQ4d+IuM8Tz/YwSra+62Scwys1CCq9ZiPCahRRe
        CxiZVzGKpRYU56anFhsWGOkVJ+YWl+al6yXn525iBCdFLbMdjIvO+RxiFOBgVOLhFcioiBJi
        TSwrrsw9xCjBwawkwut0vTxKiDclsbIqtSg/vqg0J7X4EKMpMLgnMkuJJucDE3ZeSbyhiaWB
        iZkRMHVZGhoqifMGBLhECQmkJ5akZqemFqQWwfQxcXBKNTDGSyy+vD2Y2Sb6mEaZ0cfjbBWz
        Tgu+mrboLff1R9Krp0zz/HnwxZ/mKX/WnGrSvSEvOJl9Xnewi67Oh27hZvn5H/2iujZlBdWZ
        Kc5NXOQa8y9KePdedl7nJQ9MPmft7twlGhJ0+M/xOdf3Rn6ynCArrv1IQy35xydhdRutF3P4
        2I7sM9L7I1igxFKckWioxVxUnAgAj5qrO6ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsVy+t9jAV0/vsoog2mTWC02zljPanH+/AZ2
        i48991gtLu+aw2Yx4/w+Jou1R+6yW1w85Wpx+E07q8WPM90sFqt2/WF04PJ4f6OV3eNyXy+T
        x85Zd9k9Nq3qZPPo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujEtnfjIW9LBXdNxwaGD8ydrF
        yMkhIWAicW7eBKYuRi4OIYGdjBK7/n5hA0nwCghK/Jh8j6WLkYODWUBe4silbJAws4C6xKR5
        i5gh6h8wSnydDOKA1GtJfJwyE8xmEVCVWLj8MJjNBhTf/+IG2Ex+AUWJqz8eM4LMFBWIkOg+
        UQliigh4Scxr0AUZySxwhVFiy/6PLCDlwgIuElMO72GE2DWRUeLHA5BeTg5OARuJ1bunME1g
        FJiF5NRZCKfOQnLqAkbmVYySqQXFuem5xUYFhnmp5XrFibnFpXnpesn5uZsYgfGw7bBW3w7G
        +0viDzEKcDAq8fBmZFVECbEmlhVX5h5ilOBgVhLhdbpeHiXEm5JYWZValB9fVJqTWnyIUZqD
        RUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDo7z7E/d5wjMaTkQ5hQfuT58fHbvmWp5LuZt2
        RuiTzozKpPiNExjFK3tkvso2+7rebsieFtEa8GEJn+5DyydXjyZzsjv/sPyxY0lfUMuCkvwQ
        RymJgBdfwmsWX3e3S3rDO4P9o922vzfVE89Krah406Vbmx97c+Hp/9nmviXt368pm6lcYjJQ
        YinOSDTUYi4qTgQA8oxYz4MCAAA=
X-CMS-MailID: 20180206020918epcas1p4cc42cd8946474f5bff7513af6e327b53
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4
X-RootMTR: 20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4
References: <CGME20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4@epcas1p4.samsung.com>
        <20180205144158.10500-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 2018년 02월 05일 23:41, Sylwester Nawrocki wrote:
> Add a missing git tree entry for drivers/clk/samsung.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa71ab52fd76..502442dc08eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12001,6 +12001,7 @@ M:	Tomasz Figa <tomasz.figa@gmail.com>
>  M:	Chanwoo Choi <cw00.choi@samsung.com>
>  S:	Supported
>  L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git
>  F:	drivers/clk/samsung/
>  F:	include/dt-bindings/clock/exynos*.h
>  F:	Documentation/devicetree/bindings/clock/exynos*.txt
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
