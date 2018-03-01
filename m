Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162734AbeCAWly (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:41:54 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51656 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162650AbeCAWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:41:51 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180301224149epoutp015625ba66adc263a659651ed4c63a715a~X7R08qQm_3196331963epoutp01D
X-AuditID: b6c32a36-ca9ff70000001028-87-5a9881acbf4b
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A9881AB.6030203@samsung.com>
Date: Fri, 02 Mar 2018 07:41:47 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] extcon: int3496: Ignore incorrect IoRestriction for
 ID pin
In-reply-to: <20180228162208.42497-1-andriy.shevchenko@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7bCmvu6axhlRBsdmKFv0Nk1nsnhzHEhc
        3jWHzeJ24wo2BxaPeScDPd7vu8rm0bdlFaPH501yASxRqTYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZK0YaGRnqGBuZ6RkZGeibGsVZGpkAlCakZWyccYCvoE6y4+PsJWwPjL94uRg4OCQETiQdP
        3LsYuTiEBHYwSjSca2HsYuQEcr4zSpz/YQ9Tc/NpIETNBkaJb7/2M4HU8AoISvyYfI8FpIZZ
        QF7iyKVskDCzgKbE1t3r2SHq7zFKLHz5gwmkhldAS+JuXxlIDYuAqsTuzWfZQGw2oPD+FzfA
        bH4BRYmrPx6DnSAqECGxc/43sDkiAssZJZ7eWcIOkhAWCJHo39EGZnMKuEtcf/ycDaRIQmAF
        m8Sir6fBuiUEXCT+r34JZQtLvDq+hR3iGWmJS0dtIerbGSXa985jhnCmMEqcu36PCaLBWOLZ
        wi4miHf4JN597WGFaOaV6GgTgjA9JDoepUNUO0osOrWJEeLhWcBwu/GZbQKj7CykMJqFCKNZ
        SGG0gJF5FaNYakFxbnpqsWGBkV5xYm5xaV66XnJ+7iZGcKLSMtvBuOiczyFGAQ5GJR7eHZwz
        ooRYE8uKK3MPMUpwMCuJ8J7ePi1KiDclsbIqtSg/vqg0J7X4EKMpMIwnMkuJJucDk2heSbyh
        iaWBiZkRMD1ZGhoqifMGBLhECQmkJ5akZqemFqQWwfQxcXBKNTB2np1hJuqQ08HSvtftKR/b
        RVmTR8IzmPIvynDsLWcTz/w1K/rWPvHq0oyDbvMzJyfrFS2PjLz97YH54Q1rTLx+b5zAIxyg
        MWGrRhFTs3yirFLcnDl/0yOtl6zew7moKmlCmUXF7oPf1l9euVZRI+3gMU522bLAxRYh0VZV
        8x0uJM7gu2P6216JpTgj0VCLuag4EQBjE0GSagMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsVy+t9jQd3VjTOiDO5sNLXobZrOZPHmOJC4
        vGsOm8XtxhVsDiwe804Gerzfd5XNo2/LKkaPz5vkAliiuGxSUnMyy1KL9O0SuDK2TjjAVtAn
        WHHx9xO2BsZfvF2MHBwSAiYSN58GdjFycQgJrGOUuP71FEsXIycHr4CgxI/J91hAapgF5CWO
        XMoGCTMLqEtMmreIGaL+AaPExzMf2EFqeAW0JO72lYHUsAioSuzefJYNxGYDCu9/cQPM5hdQ
        lLj64zEjSLmoQIRE94lKkDEiAssZJR6fW8QOUiMsECLxeO0tRoj5cxglzsw4xwqS4BRwl7j+
        +DnbBEb+WUjOm4Vw3iwk5y1gZF7FKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREYptsO
        a/XtYLy/JP4QowAHoxIP7w7OGVFCrIllxZW5hxglOJiVRHhPb58WJcSbklhZlVqUH19UmpNa
        fIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAPjnBPCl/n/WQYpn2/+9cGrfM/G5fc2
        KjjXGcX+tjvBJaays+UFz+zHas/jm0+/+PGPnV3senXYvNCnaktCFrUd+aB60qT+SebFfXNi
        dqgYK6rq7jvy6Yd34o6DX5QUr//m/LLL+KavScml07VKQsL3BJkbbrGV2ObYf5obXMXnny3w
        /Ou5lsd5SizFGYmGWsxFxYkA4k0Cp08CAAA=
X-CMS-MailID: 20180301224147epcas1p4f96081dafa8e89350791f5800acc02c6
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180228162213epcas3p3e05172d30ecd01c2b99a4435a1bce0b7
X-RootMTR: 20180228162213epcas3p3e05172d30ecd01c2b99a4435a1bce0b7
References: <CGME20180228162213epcas3p3e05172d30ecd01c2b99a4435a1bce0b7@epcas3p3.samsung.com>
        <20180228162208.42497-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 03월 01일 01:22, Andy Shevchenko wrote:
> The commit
> 
>   70216fd937fe ("extcon: int3496: Set the id pin to direction-input if necessary")
> 
> introduced a workaround for incorrect IoRestriction mode in ACPI table.
> 
> Now, when GPIO ACPI library does it in generic way, see the commit
> 
>   1b2ca32ab0b8 ("gpiolib: acpi: Introduce NO_RESTRICTION quirk")
> 
> for the details, just set an appropriate quirk flag instead.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - add tags
> - address comments from Chanwoo
>  drivers/extcon/extcon-intel-int3496.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index 191e99f06a9a..acaccb128fc4 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -50,7 +50,11 @@ static const struct acpi_gpio_params vbus_gpios = { INT3496_GPIO_VBUS_EN, 0, fal
>  static const struct acpi_gpio_params mux_gpios = { INT3496_GPIO_USB_MUX, 0, false };
>  
>  static const struct acpi_gpio_mapping acpi_int3496_default_gpios[] = {
> -	{ "id-gpios", &id_gpios, 1 },
> +	/*
> +	 * Some platforms have a bug in ACPI GPIO description making IRQ
> +	 * GPIO to be output only. Ask the GPIO core to ignore this limit.
> +	 */
> +	{ "id-gpios", &id_gpios, 1, ACPI_GPIO_QUIRK_NO_IO_RESTRICTION },
>  	{ "vbus-gpios", &vbus_gpios, 1 },
>  	{ "mux-gpios", &mux_gpios, 1 },
>  	{ },
> @@ -112,9 +116,6 @@ static int int3496_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(data->gpio_usb_id);
>  		dev_err(dev, "can't request USB ID GPIO: %d\n", ret);
>  		return ret;
> -	} else if (gpiod_get_direction(data->gpio_usb_id) != GPIOF_DIR_IN) {
> -		dev_warn(dev, FW_BUG "USB ID GPIO not in input mode, fixing\n");
> -		gpiod_direction_input(data->gpio_usb_id);
>  	}
>  
>  	data->usb_id_irq = gpiod_to_irq(data->gpio_usb_id);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
