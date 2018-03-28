Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbeC1OTq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:19:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43085 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbeC1OTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:19:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180328141935epoutp01718a56db3389b60eb0231f84b1ce183b~gG2CaLnCG0497504975epoutp01h
X-AuditID: b6c32a35-139ff70000000fee-25-5abba476ab43
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        "James E. J. Bottomley" <jejb@parisc-linux.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] video/console/sticore: Delete an error message for a
 failed memory allocation in sti_try_rom_generic()
Date: Wed, 28 Mar 2018 16:19:31 +0200
Message-id: <1899328.6kM0nNg5W5@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <6b8dde60-0550-5fb3-c7a5-5f6282259186@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCmnm7Zkt1RBsv3ilrc/3Sb0eLK1/ds
        Fuc7lzNb3F+3itVi6y1pixN9H1gtLu+aw2bx6NQFJgcOjw8f4zzudx9n8riw6DerR9OpdlaP
        z5vkAlijuGxSUnMyy1KL9O0SuDLe90xhK2hgqZi5ZwF7A+NC5i5GTg4JAROJ/WcaWLsYuTiE
        BHYwShx+tpQZwvnOKPHl+zl2mKpHkz6xQyQ2MErcWD4VquUro8SUUwfZQKrYBKwkJravYuxi
        5OAQETCV+HMiBKSGWeAno8TN+zdYQWqEBWol7m1bAGazCKhKHDu2FayXV0BT4t7il4wgtqiA
        l8SWfe1MIDangKfEi+55TBA1ghI/Jt9jAbGZBeQl9u2fygph60icPbaOEWSZhMAJNomGD7tZ
        QY6QEHCRmPkvBeIDYYlXx7ewQ4SlJS4dtYUob2aU+LZjDzQsJjBK7FkvBGFbSxw+fhFqPp/E
        u689UCN5JTraoEo8JM5vvAnV6ihx+9ZXNkiYzGGUWNSzln0Co+wsJGfPQnL2LCRnL2BkXsUo
        llpQnJueWmxYYKhXnJhbXJqXrpecn7uJEZwqtEx3ME4553OIUYCDUYmH12LR7igh1sSy4src
        Q4wSHMxKIrzvNYBCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQMCXKKEBNITS1KzU1MLUotgskwc
        nFINjL1X/G+5FFzf18364YmHZeejvTL/pZ4o+/Nu1BPavUo1Zelkg8VKHMVF0o92TEg87HDT
        RtH6xJ434Rxt31umb4srO/hk6WSj+x37JqlLRYrGOssw3XG265b5+nu+xBNZz+MsP5iKeK+u
        v6ZS7HY3TcVlrWisyuer833UNv07y6r0O/rMCl8+HSWW4oxEQy3mouJEAApPcbcRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsVy+t9jQd2yJbujDJpuMVnc/3Sb0eLK1/ds
        Fuc7lzNb3F+3itVi6y1pixN9H1gtLu+aw2bx6NQFJgcOjw8f4zzudx9n8riw6DerR9OpdlaP
        z5vkAlijuGxSUnMyy1KL9O0SuDLe90xhK2hgqZi5ZwF7A+NC5i5GTg4JAROJR5M+sXcxcnEI
        CaxjlOh9fZYVwvnKKLGg6TojSBWbgJXExPZVQDYHh4iAqcSfEyEgNcwCPxkldt7qYwGpERao
        lbi3bQEriM0ioCpx7NhWNhCbV0BT4t7il2BzRAW8JLbsa2cCsTkFPCVedM9jglg2j1Fi0r/J
        zBANghI/Jt8DG8osIC+xb/9UVghbS2L9zuNMExj5ZyEpm4WkbBaSsgWMzKsYJVMLinPTc4uN
        CgzzUsv1ihNzi0vz0vWS83M3MQLDe9thrb4djPeXxB9iFOBgVOLhtVi0O0qINbGsuDL3EKME
        B7OSCO97DaAQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFIN
        jNujlwfz8PoWnXkVf39mRuXrPRrMLl8eurYsv/bhpe7K7/s/OVX315xfO0dcpzRuuoZwc0HS
        aYmEF+efr1O4fm7P48oPqWtUlP9bzZ64gumDquqjKc31Rn573vz2CuCsOtim9Vzjs6NPu/0u
        1W8XJA0rZt7xMX2wVG+74e5dbqn5xZfsLY9o/FViKc5INNRiLipOBAByHax/awIAAA==
X-CMS-MailID: 20180328141934epcas1p35287a5e36e4c79370c50e5800990e3db
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171205180033epcas4p3cb5142e079695c72736e1f27489466d3
X-RootMTR: 20171205180033epcas4p3cb5142e079695c72736e1f27489466d3
References: <CGME20171205180033epcas4p3cb5142e079695c72736e1f27489466d3@epcas4p3.samsung.com>
        <6b8dde60-0550-5fb3-c7a5-5f6282259186@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 05, 2017 07:00:22 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 5 Dec 2017 18:45:42 +0100
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
