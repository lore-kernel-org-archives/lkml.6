Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeBSJxk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:53:40 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:11062 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeBSJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:53:38 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180219095336epoutp039124dba0e33e304c166d635995f26713~UsWPceAlr1806718067epoutp03W
X-AuditID: b6c32a46-3c1ff70000001029-ee-5a8a9e9f6702
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A8A9E9F.8050603@samsung.com>
Date: Mon, 19 Feb 2018 18:53:35 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: intel-cht-wc: Also set direction and drv flags
 for V5 boost GPIO
In-reply-to: <20180215072450.7160-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmme78eV1RBrde21i8OT6dyeLyrjls
        FrcbV7A5MHu833eVzaNvyypGj8+b5AKYo1JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslaINDY30
        DA3M9YyMjPRMjGOtjEyBShJSM67eqCw4wVexYe5F9gbGR9xdjJwcEgImEvNbXjF1MXJxCAns
        YJT4+vYBO4TznVHi4dMnbDBVE1f0sUAkNjBK/NxxiwkkwSsgKPFj8j2gBAcHs4C8xJFL2SBh
        ZgFNia2717OD2EIC9xgl2m4rQJRrSTy+PAUsziKgKnF37h0WEJsNKL7/xQ2wXfwCihJXfzxm
        BLFFBSIkds7/BlYvIhAkceP7ClaI+QoSv+5tArOFBeIl1m58AnYOp4CFxLrpc8HulBCYwybR
        PauVDeQ2CQEXie+7oyB+EZZ4dXwLO4QtLfFs1UZGiPp2Ron2vfOYIZwpjBLnrt9jgqgylni2
        sIsJYjOfRMfhv+wQQ3klOtqEIEwPiW1/kiGqHSU+Pl3EBgmrbkaJs28+M01glJuFFFyzEME1
        Cym4FjAyr2IUSy0ozk1PLTYqMNIrTswtLs1L10vOz93ECE5YWm47GJec8znEKMDBqMTDK7Cx
        M0qINbGsuDL3EKMEB7OSCK9FSFeUEG9KYmVValF+fFFpTmrxIUZTYHBPZJYSTc4HJtO8knhD
        E0sDEzMzI3MzC2DyEudtDXCJEhJITyxJzU5NLUgtgulj4uCUamC8GrhQTevg5KD7i75HXP75
        l4t7x8P0LMajXXf3P8thSkiatJHhb9UZ9bhFfyIvLbxbeDG+e7JB+sRvXxjOZPLU1nyUd73j
        4xAg9L3ye+KmANs+70PVMpeTOXiu+/7fssyhIv/Vt3NrouKW7nkUWWt75+3Trkd7hY+4Oj55
        O2/lxNw13O8swzzilFiKMxINtZiLihMBkzzxBG4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsVy+t9jQd3587qiDF7eMrR4c3w6k8XlXXPY
        LG43rmBzYPZ4v+8qm0ffllWMHp83yQUwR3HZpKTmZJalFunbJXBlXL1RWXCCr2LD3IvsDYyP
        uLsYOTkkBEwkJq7oY+li5OIQEljHKHHozRtGkASvgKDEj8n3gBIcHMwC8hJHLmWDhJkF1CUm
        zVvEDFH/gFHi1cop7BD1WhKPL0PYLAKqEnfn3mEBsdmA4vtf3GADsfkFFCWu/njMCDJTVCBC
        ovtEJUhYRCBA4uepfnaI+QoSv+5tYgUpERaIl1hy1xViVS+jxPqmTrCRnAIWEuumz2WZwCgw
        C8mlsxAunYXk0gWMzKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS83M3MQJDddthrf4djI+X
        xB9iFOBgVOLhzdjcGSXEmlhWXJl7iFGCg1lJhNcipCtKiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OC9//rFIIYH0xJLU7NTUgtQimCwTB6dUA6NvTY3E78vtk7jSA/3CG03O/zcVrdflu7yh0e/2
        FJ4duq/OGEgUGN0Km/DTll2CjWWzwWHHG+mfHyr6/Ks7cFtf45MY8wv325yCx+otv87at19Z
        7PJReX/RVZsKK9e6806qXd5eHTojJfRlghrH3anVXmyl0j41EeXuC/aufLrry1/RWRsUSpRY
        ijMSDbWYi4oTAd3SMhtRAgAA
X-CMS-MailID: 20180219095335epcas2p3a8e38327315d9af5a6917b9213753deb
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180215072501epcas2p4242c83f76cdfd9fbc67a456e41b17988
X-RootMTR: 20180215072501epcas2p4242c83f76cdfd9fbc67a456e41b17988
References: <CGME20180215072501epcas2p4242c83f76cdfd9fbc67a456e41b17988@epcas2p4.samsung.com>
        <20180215072450.7160-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 02월 15일 16:24, Hans de Goede wrote:
> Sometimes (firmware bug?) the V5 boost GPIO is not configured as output
> by the BIOS, leading to the 5V boost convertor being permanently on,
> 
> Explicitly set the direction and drv flags rather then inheriting them
> from the firmware to fix this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

You need to add fixes tag and send stable mailing list.

> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 7c4bc8c44c3f..b7e9ea377d70 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -66,6 +66,8 @@
>  
>  #define CHT_WC_VBUS_GPIO_CTLO		0x6e2d
>  #define CHT_WC_VBUS_GPIO_CTLO_OUTPUT	BIT(0)
> +#define CHT_WC_VBUS_GPIO_CTLO_DRV_OD	BIT(4)
> +#define CHT_WC_VBUS_GPIO_CTLO_DIR_OUT	BIT(5)
>  
>  enum cht_wc_usb_id {
>  	USB_ID_OTG,
> @@ -183,14 +185,15 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
>  {
>  	int ret, val;
>  
> -	val = enable ? CHT_WC_VBUS_GPIO_CTLO_OUTPUT : 0;
> -
>  	/*
>  	 * The 5V boost converter is enabled through a gpio on the PMIC, since
>  	 * there currently is no gpio driver we access the gpio reg directly.
>  	 */
> -	ret = regmap_update_bits(ext->regmap, CHT_WC_VBUS_GPIO_CTLO,
> -				 CHT_WC_VBUS_GPIO_CTLO_OUTPUT, val);
> +	val = CHT_WC_VBUS_GPIO_CTLO_DRV_OD | CHT_WC_VBUS_GPIO_CTLO_DIR_OUT;
> +	if (enable)
> +		val |= CHT_WC_VBUS_GPIO_CTLO_OUTPUT;
> +
> +	ret = regmap_write(ext->regmap, CHT_WC_VBUS_GPIO_CTLO, val);
>  	if (ret)
>  		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
