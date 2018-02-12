Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeBLVuO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:50:14 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:22839 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeBLVuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:50:12 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180212215010epoutp0185a190bf29e1769fce344ba2b341ef3c~Ssm498pXY1945019450epoutp01i
X-AuditID: b6c32a36-ca9ff70000001028-a0-5a820c127f37
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A820C12.3000307@samsung.com>
Date: Tue, 13 Feb 2018 06:50:10 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] extcon: axp288: Constify the
 axp288_pwr_up_down_info array
In-reply-to: <20180212194630.7216-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7bCmrq4QT1OUwc2DLBZvjk9nsri8aw6b
        xe3GFWwOzB7v911l8+jbsorR4/MmuQDmqFSbjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0Nd
        Q0sLcyWFvMTcVFslF58AXbfMHKBFSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpWhDQyM9
        QwNzPSMjIz0T41grI1OgkoTUjAtnVjMVrOeqeLi+sIFxNkcXIyeHhICJxK/P/9i7GLk4hAR2
        MEp8aPsL5XxnlOhfvZoRpur0m4msILaQwG5GiY+/NEBsXgFBiR+T77F0MXJwMAvISxy5lA0S
        ZhbQlNi6ez3UnHuMEvcmH2CEqNeSeP7qCDNIPYuAqsTld1kgYTag8P4XN9hAbH4BRYmrPx6D
        lYsKREjsnP+NHcQWEQiSuPF9BSvEfAWJX/c2gdnCQDXve9eygNicAhYSN9a/ZAXZKyGwgE3i
        4ZaFLBD3u0hc2X0SyhaWeHV8CzvIDRIC0hKXjtpC1LczSrTvnccM4UxhlDh3/R4TRIOxxLOF
        XUwQm/kk3n3tYYVo5pXoaBOCKPGQuH/oCxNE2FHiwNpSSFB1M0rsvcY1gVFuFlJozUKE1iyk
        0FrAyLyKUSy1oDg3PbXYsMBIrzgxt7g0L10vOT93EyM4WWmZ7WBcdM7nEKMAB6MSD2/H7MYo
        IdbEsuLK3EOMEhzMSiK8f5qBQrwpiZVVqUX58UWlOanFhxhNgYE9kVlKNDkfmEjzSuINTSwN
        TMyMgEnL0tBQSZw3IMAlSkggPbEkNTs1tSC1CKaPiYNTqoHRUNbVOftHatmMEN85s5jiv32q
        fzqzf8aa/hQdty6+quNcPudOzNj7+kLp59C74n6umk6WTReVkj8tEgrMmfV2X1VKVOjt1fu2
        vhD7JPWhf/7aZz3zXO/NmHySe8bMZm979dQJMbuuPJgxf4XGgtafk7Pms+4okfkYLXLsYekc
        VdutO+2fWVvPUWIpzkg01GIuKk4EAC9nTmVsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsVy+t9jAV1BnqYogw8XhSzeHJ/OZHF51xw2
        i9uNK9gcmD3e77vK5tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZF86sZipYz1XxcH1hA+Ns
        ji5GTg4JAROJ028msoLYQgI7GSXmXJEHsXkFBCV+TL7H0sXIwcEsIC9x5FI2SJhZQF1i0rxF
        zF2MXEDlDxgl7v+4zQxRryXx/NURZpB6FgFVicvvskDCbEDh/S9usIHY/AKKEld/PGYEKREV
        iJDoPlEJEhYRCJD4eaqfHWK8gsSve5vArhEGKnnfu5YFYlUv0Kr1V8FWcQpYSNxY/5J1AqPA
        LCSXzkK4dBaSSxcwMq9ilEwtKM5Nzy02KjDMSy3XK07MLS7NS9dLzs/dxAgM1G2Htfp2MN5f
        En+IUYCDUYmHt2N2Y5QQa2JZcWXuIUYJDmYlEd4/zUAh3pTEyqrUovz4otKc1OJDjNIcLEri
        vLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGKcvs3n580/IjRkM7S9FnTNex8jPZf3uK1p8QWDe
        YneD1SeiFXPSLqx/4K+4vvvZIeMVlubb9Os/Oyds/LbNublv3u/OgDWnFdy7Nfu5i9o47NQs
        ylOOnju0ICFlW2/DysPyne9cyi++/TfN+nr5tHlrahdvkp5U/7XeM8HI9gaj5wS9F0KLXyux
        FGckGmoxFxUnAgD05FyAUAIAAA==
X-CMS-MailID: 20180212215009epcas1p1de81bb46bfb84ceee78b2c4405305743
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180212194646epcas3p4de9a5b929ea45edb11f7e5b509b6cf98
X-RootMTR: 20180212194646epcas3p4de9a5b929ea45edb11f7e5b509b6cf98
References: <CGME20180212194646epcas3p4de9a5b929ea45edb11f7e5b509b6cf98@epcas3p4.samsung.com>
        <20180212194630.7216-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 13일 04:46, Hans de Goede wrote:
> Make the axp288_pwr_up_down_info array const char * const, this leads
> to the following section size changes:
> 
> .text     0x674 -> 0x664
> .data     0x148 -> 0x0f0
> .rodata   0x0b4 -> 0x114
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-axp288.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 0a44d43802fe..c8f7b6435679 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -106,7 +106,7 @@ struct axp288_extcon_info {
>  };
>  
>  /* Power up/down reason string array */
> -static char *axp288_pwr_up_down_info[] = {
> +static const char * const axp288_pwr_up_down_info[] = {
>  	"Last wake caused by user pressing the power button",
>  	"Last wake caused by a charger insertion",
>  	"Last wake caused by a battery insertion",
> @@ -124,7 +124,7 @@ static char *axp288_pwr_up_down_info[] = {
>   */
>  static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>  {
> -	char **rsi;
> +	const char * const *rsi;
>  	unsigned int val, i, clear_mask = 0;
>  	int ret;
>  
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
