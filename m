Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeCLPJC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:09:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58891 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:08:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180312150857epoutp042c311c598ed57b7b4b16e3bb93613053~bNMkHtdAT1311613116epoutp04b
X-AuditID: b6c32a35-879ff70000001031-99-5aa698084c85
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: kconfig: Add help text to FB_I810_I2C
Date: Mon, 12 Mar 2018 16:08:46 +0100
Message-id: <4626326.T7PS2VtTaQ@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180213140248.h4yyc77futu74xg7@huvuddator>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7bCmgS7HjGVRBt9mSVr8nXSM3eL1v+ks
        Fle+vmezeH2kidXiRN8HVos/u3YwWVzeNYfN4saEp4wW715GWCy6dYbZ4u0doNoLv24xW+y9
        95nRgdfj969JjB47Z91l99i8Qstj06pONo/73ceZPD4+vcXicWL6dxaPjdufMHl83iTnsffz
        b5YArigum5TUnMyy1CJ9uwSujMeTtrEWdLJUfJ//jqmBcTlzFyMnh4SAiUTj9fesXYxcHEIC
        OxglGpu/QznfGSUmvbvNBFM183ELO4gtJLCbUaL1SSZE0VdGiYVXFoIVsQlYSUxsX8UIYosI
        qEvcm7CfDaSIWeAfs8T+M6fYQBLCAh4Sf/efBLNZBFQlbuz9C2bzCmhKfJ21FqxZVMBLYsu+
        drChnAKWEudu/GGBqBGU+DH5HpjNLCAvsW//VFYIW0fi7LF1jCDLJAT62SXuXP3ECHG2i8Ty
        JYugXhCWeHV8C9ALHEC2tMSlo7YQ9c2MEt927IEGxgRGiT3rhSBsa4nDxy9CLeCTePe1hxWi
        l1eiow2qxENiwZSnUOMdJVbcbmWGhMpNRonrVw8wTWCUnYXk7llI7p6F5O4FjMyrGMVSC4pz
        01OLDQsM9YoTc4tL89L1kvNzNzGCE5KW6Q7GKed8DjEKcDAq8fB2tC6LEmJNLCuuzD3EKMHB
        rCTC6z8VKMSbklhZlVqUH19UmpNafIhRmoNFSZw3IMAlSkggPbEkNTs1tSC1CCbLxMEp1cAY
        cTuv//HOTJWlVx8f0GX3P3NILc34+4+NyYk881ffdH0fadX7Tu9+5Oy9TElXzbelJYoziAa1
        Xmx7erhu+cXvE1JcXH0Tc7dmibyPX/dA8/WR+Ye63zm26tWazfIurV/9Islm6+TjJ2b/lvsc
        /qS2UX3C58/dfPpvy55cmlR6ru9UzCGJN/VvlFiKMxINtZiLihMBbbV/TUQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e+xgC77jGVRBpNmq1n8nXSM3eL1v+ks
        Fle+vmezeH2kidXiRN8HVos/u3YwWVzeNYfN4saEp4wW715GWCy6dYbZ4u0doNoLv24xW+y9
        95nRgdfj969JjB47Z91l99i8Qstj06pONo/73ceZPD4+vcXicWL6dxaPjdufMHl83iTnsffz
        b5YArigum5TUnMyy1CJ9uwSujMeTtrEWdLJUfJ//jqmBcTlzFyMnh4SAicTMxy3sXYxcHEIC
        OxklXq/qg3K+Mko0bv/GAlLFJmAlMbF9FSOILSKgLnFvwn42kCJmgQYWifeP94MlhAU8JP7u
        P8kGYrMIqErc2PsXzOYV0JT4OmstWI2ogJfEln3tTCA2p4ClxLkbf1ggtrUyStxac5IRokFQ
        4sfke2CbmQXkJfbtn8oKYWtJrN95nGkCI/8sJGWzkJTNQlK2gJF5FaNkakFxbnpusVGBYV5q
        uV5xYm5xaV66XnJ+7iZGYBRtO6zVt4Px/pL4Q4wCHIxKPLwdrcuihFgTy4orcw8xSnAwK4nw
        +k8FCvGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cA4y6cm
        3/D0nGMnFPKNBBqWCmzUS/vR8uRFTMiG2aaH2jeyb+O5ddZmxm2NuI+bN19/N+GVBd+zf86V
        B4N8ch9/LVy0pWppwUdJjXkzuS1nbwjp6Zz22Pv5Vt/oXa3r9ircvnnCbPrk6ONTtzTfveF4
        8sLks2zzI/jm7/h/6uhHoztz9gUe+ng+6JwSS3FGoqEWc1FxIgBRHp/zngIAAA==
X-CMS-MailID: 20180312150855epcas1p36b1377471a2a0d69362fa3cf57295209
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180312150855epcas1p36b1377471a2a0d69362fa3cf57295209
X-RootMTR: 20180312150855epcas1p36b1377471a2a0d69362fa3cf57295209
References: <20180131093434.20050-1-ulfalizer@gmail.com>
        <2836658.i9VlN9LAid@amdc3058> <20180213140248.h4yyc77futu74xg7@huvuddator>
        <CGME20180312150855epcas1p36b1377471a2a0d69362fa3cf57295209@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 13, 2018 03:02:48 PM Ulf Magnusson wrote:
> The FB_I810_I2C symbol previously had a blank help text, which was
> removed in e9829ac4e5fd ("video: fbdev: kconfig: Remove blank help
> text").
> 
> Give it a proper help text, derived from commit 74f6ae84b23 ("[PATCH]
> i810fb: Add > i2c/DDC support").
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
