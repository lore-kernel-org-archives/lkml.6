Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163263AbeCAXcs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:32:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64582 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163222AbeCAXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:32:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180301233240epoutp02c8784be470f0b41888c0fb654982d9e7~X7_PNSx_K3106531065epoutp02Z
X-AuditID: b6c32a39-47fff70000000fc5-d8-5a988d9896bc
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A988D97.9080805@samsung.com>
Date: Fri, 02 Mar 2018 08:32:39 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Linus Walleij <linus.walleij@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] extcon: gpio: Localize platform data
In-reply-to: <CACRpkdanbnodBa335hM5DYpgeW-6pU_oB_vbbUSxR2wRS6FPsw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmvu6M3hlRBqt+yFhM+bOcyWLz/D+M
        Fpd3zWGzeLLwDJPF7cYVbA6sHneu7WHz2Pm9gd2jb8sqRo/Pm+QCWKJSbTJSE1NSixRS85Lz
        UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJWiDQ2N9AwNzPWMjIz0TIxjrYxMgUoSUjM2Nh1mL5jDUdG5eAljA+Mpti5G
        Tg4JAROJp6cOs3YxcnEICexglFiw/SMjhPOdUWLmmYOsMFVrmx6zQCQ2MEpc+v4crJ1XQFDi
        x+R7QAkODmYBeYkjl7JBwswCmhIvvkyCqr/HKLH21iZWiHotiW23rzCD2CwCqhIdC+cygdhs
        QPH9L26AzeQXUJS4+uMxI4gtKhAhsXP+N3YQW0QgXGLfsQPMIEOZBRYxSix7uxOsWVjAVuLD
        ul1gDZwCwRK/j91nBymSENjBJnHy736oR10kPq85wQxhC0u8Or6FHeRqCQFpiUtHbSHq2xkl
        2vfOY4ZwpjBKnLt+jwmiwVji2cIuJojf+CTefe1hhWjmlehoE4Io8ZDY3PSfESLsKPF1vTjE
        9zcYJQ5fecs0gVFuFlKAzUIE2CykAFvAyLyKUSy1oDg3PbXYsMBUrzgxt7g0L10vOT93EyM4
        qWlZ7mA8ds7nEKMAB6MSD+8OzhlRQqyJZcWVuYcYJTiYlUR4T2+fFiXEm5JYWZValB9fVJqT
        WnyI0RQY3hOZpUST84EJN68k3tDE0sDEzAiYviwNDZXEeQMCXKKEBNITS1KzU1MLUotg+pg4
        OKUaGIW+ruqx83pzZP2bEx4GSzk3V+9TmnrSrnTJgyfsD7c6/QsJnVx14NfM3Wn3O+e/j99e
        znrRnntqtc3XRXZ1b06w3bY//2tSkfUH4TNVp55ZZ4fbnbd014wtLFTfn5+bdOS86Mv5ko3/
        FnRcWnp76sUvqwo33Jy/I/Rmflt08NKzy86lX2VXufJSiaU4I9FQi7moOBEAsOn/jYADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t9jQd3pvTOiDB6ft7SY8mc5k8Xm+X8Y
        LS7vmsNm8WThGSaL240r2BxYPe5c28PmsfN7A7tH35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVw
        ZWxsOsxeMIejonPxEsYGxlNsXYycHBICJhJrmx6zdDFycQgJrGOUuLd8MgtIgldAUOLH5HtA
        NgcHs4C8xJFL2RCmusSUKbkQ5Q8YJTp2bmGFKNeS2Hb7CjOIzSKgKtGxcC4TiM0GFN//4gbY
        Ln4BRYmrPx4zgswRFYiQ6D5RCRIWEQiXmL3gPTPITGaBRUAnnGtgB0kIC9hKfFi3ixFi2Q1G
        ib6LE8GWcQoES9y6fotxAqPALCSnzkI4dRbCqQsYmVcxSqYWFOem5xYbFRjmpZbrFSfmFpfm
        pesl5+duYgSG8rbDWn07GO8viT/EKMDBqMTDu4NzRpQQa2JZcWXuIUYJDmYlEd7T26dFCfGm
        JFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cBoP/vv3/q1J2yP
        vrp7j7nHge/47BeMV9TU1M+W/05wElaLT/S72c25YOWLP0zNbmGWWZ9jvH5uZZ7LViAbw5X2
        rLfXefZbYQO5TZpLo+XLG2LW94pZnLCXNfqgIeew2G9jwAU5cdUEp6qdcgt2zI0qnl9145Pp
        mavyd5f8OSlWO/XgZbn36xiVWIozEg21mIuKEwEqtR/eYQIAAA==
X-CMS-MailID: 20180301233239epcas1p4a77e7bcfd12429346cec10330cf8e557
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180301091450epcas3p2a8ee4986c2f9e24c05c0132e659232bb
X-RootMTR: 20180301091450epcas3p2a8ee4986c2f9e24c05c0132e659232bb
References: <20180212085314.23014-1-linus.walleij@linaro.org>
        <CGME20180301091450epcas3p2a8ee4986c2f9e24c05c0132e659232bb@epcas3p2.samsung.com>
        <CACRpkdanbnodBa335hM5DYpgeW-6pU_oB_vbbUSxR2wRS6FPsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 03월 01일 18:14, Linus Walleij wrote:
> On Mon, Feb 12, 2018 at 9:53 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> Nothing in the entire kernel #includes <linux/extcon/extcon-gpio.h>
>> so move the platform data declaration inside of the driver.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> No reply on these patches so far,
> if you prefer I can just apply them to the GPIO
> tree.

I'm sorry for late reply. The extcon-gpio.c should be solved
how to to get the unique id such as EXTCON_USB, EXTCON_DISP_HDMI and so on.
As you knew, you already tried to develop it with device-tree.
But, it is not accepted.

Even if extcon-gpio.c has a problem still to get the extcon id,
I'll apply this series. Because I don't want to remove extcon-gpio.c
and you need to clean-up the gpio library. On later, I'll try to fix this issue.

I added the 'FIXME' comment which explains the extcon_id issue
and then applied this series.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
