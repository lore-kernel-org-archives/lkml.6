Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeB0D7n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:59:43 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:23040 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeB0D7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:59:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180227035939epoutp01420eb3e6c318a9fd5252824324665363~XErethr9V2734427344epoutp01g
X-AuditID: b6c32a35-879ff70000001031-8e-5a94d7ab8025
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A94D7AD.6020402@samsung.com>
Date: Tue, 27 Feb 2018 12:59:41 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1] extcon: int3496: Ignore incorrect IoRestriction for
 ID pin
In-reply-to: <20180226193444.69883-1-andriy.shevchenko@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmvu7q61OiDJpmsFr0Nk1nsnhzHEhc
        3jWHzeJ24wo2BxaPeScDPd7vu8rm0bdlFaPH501yASxRqTYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QBuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZK0YaGRnqGBuZ6RkZGeibGsVZGpkAlCakZE3cvZCx4LVBxtaODpYHxLm8XIyeHhICJxLcp
        axm7GLk4hAR2MEpsfr6YFcL5zijxZsJOdpiqdc33mUBsIYENjBIPXriD2LwCghI/Jt9j6WLk
        4GAWkJc4cikbJMwsoCmxdfd6dog59xglJt3exghRryXx5skGMJtFQFVi8da3rCA2G1B8/4sb
        bCA2v4CixNUfj8FqRAUiJHbO/wY2SESggVHi3sNNbBAb1CVWf3kM1iwsECKxcPYcsAZOAXeJ
        rnPdTCANEgIb2CTm/mthg/jAReL3x9+MELawxKvjW9hBrpYQkJa4dNQWor6dUaJ97zxmCGcK
        o8S56/eYIBqMJZ4t7GKC2Mwn8e5rDytEM69ER5sQRImHxMz2dqj5jhIT5kHsFRKYxShxaLf+
        BEa5WUgBNgsRYLOQAmwBI/MqRrHUguLc9NRiwwJDveLE3OLSvHS95PzcTYzgNKZluoNxyjmf
        Q4wCHIxKPLwz5KZECbEmlhVX5h5ilOBgVhLhXbl4cpQQb0piZVVqUX58UWlOavEhRlNgeE9k
        lhJNzgem2LySeEMTSwMTMyNg8rI0NFQS5w0IcIkSEkhPLEnNTk0tSC2C6WPi4JRqYNzN49Oz
        6NL2qRe4yi+fOX6p68vydd4Hqo7vuPFtxl793sYzLyRE51neu+plLf/8W+Ptt7NnHQ6ZksmS
        6Wq3Wi5B2uzdLvkn/yfpbnrAye0gtEzNwW2rx+fIhdcj2hfYq67eoDf3zpxZj1u1l6sfX9et
        5/EzrvCDG/9sVm4GBU0hFulaYYGFR7KVWIozEg21mIuKEwHqJnRkeQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t9jQd1V16dEGayfrmXR2zSdyeLNcSBx
        edccNovbjSvYHFg85p0M9Hi/7yqbR9+WVYwenzfJBbBEcdmkpOZklqUW6dslcGVM3L2QseC1
        QMXVjg6WBsa7vF2MnBwSAiYS65rvM3UxcnEICaxjlFi6bx4zSIJXQFDix+R7LF2MHBzMAvIS
        Ry5lg4SZBdQlJs1bxAxR/4BRYtaqOWwQ9VoSb55sYASxWQRUJRZvfcsKYrMBxfe/uAFWwy+g
        KHH1x2NGkJmiAhES3ScqQeaICDQwSqw7+5wRZsHqL49ZQWqEBUIk5k0oBQkLCcxhlJj3JRzE
        5hRwl+g61800gVFgFpJLZyFcOgvJpQsYmVcxSqYWFOem5xYbFRjmpZbrFSfmFpfmpesl5+du
        YgSG77bDWn07GO8viT/EKMDBqMTDO0NuSpQQa2JZcWXuIUYJDmYlEd6ViydHCfGmJFZWpRbl
        xxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cCY6RSw115kx9y39o3ntm1q
        n13zNfm6w2fRGb/fzf34099f3aDg9ie3eDWzFUHTrFj/R0icWG9zJ0CNcx8Xl1zFohCTUIZX
        kUevle5an9a+pOhJj143u9Bipv61xw5kWMooRl+s2Glgey+73FtPxKwgIWsy48cPHTmMR3vd
        mKO2GAgYtAjJZiixFGckGmoxFxUnAgAZJmC5WwIAAA==
X-CMS-MailID: 20180227035938epcas1p39ba5c5a06a389e522867c06d4d429c83
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180226193456epcas3p39565d818a6a57db386bd5e81aed20674
X-RootMTR: 20180226193456epcas3p39565d818a6a57db386bd5e81aed20674
References: <CGME20180226193456epcas3p39565d818a6a57db386bd5e81aed20674@epcas3p3.samsung.com>
        <20180226193444.69883-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 02월 27일 04:34, Andy Shevchenko wrote:
> The commit 70216fd937fe introduced a workaround for incorrect

You better to specify the commit id and patch name as following:
commit 70216fd937fe -> commit 70216fd937fe ("extcon: int3496: Set the id pin to direction-input if necessary")

> IoRestriction mode in ACPI table.

> 
> Now, when GPIO ACPI library does it in generic way, just set

I recommend that you specify clearly which patch you mention
about GPIO ACPI library.

> an appropriate quirk flag instead.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
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


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
