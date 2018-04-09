Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeDIHbk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:31:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50273 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeDIHbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:31:38 -0400
Subject: Re: [PATCH 2/2] HID: i2c-hid: Fix resume issue on Raydium touchscreen
 device
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com
References: <20180102173006.506-1-aaron.ma@canonical.com>
 <20180102173006.506-2-aaron.ma@canonical.com>
From: Aaron Ma <aaron.ma@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=aaron.ma@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFffeLkBCACi4eE4dPsgWN6B9UDOVcAvb5QgU/hRG6yS0I1lGKQv4KA+bke0c5g8clbO
 9gIlIl2bityfA9NzBsDik4Iei3AxMbFyxv9keMwcOFQBIOZF0P3f05qjxftF8P+yp9QTV4hp
 BkFzsXzWRgXN3r8hU8wqZybepF4B1C83sm2kQ5A5N0AUGbZli9i2G+/VscG9sWfLy8T7f4YW
 MjmlijCjoV6k29vsmTWQPZ7EApNpvR5BnZQPmQWzkkr0lNXlsKcyLgefQtlwg6drK4fe4wz0
 ouBIHJEiXE1LWK1hUzkCUASra4WRwKk1Mv/NLLE/aJRqEvF2ukt3uVuM77RWfl7/H/v5ABEB
 AAHNIUFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPsLAdwQTAQgAIQUCV994uQIb
 AwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDNxCzQfVU6ntJ9B/9aVy0+RkLqF9QpLmw+
 LAf1m3Fd+4ZarPTerqDqkLla3ekYhbrEtlI1mYuB5f+gtrIjmcW27gacHdslKB9YwaL8B4ZB
 GJKhcrntLg4YPzYUnXZkHHTv1hMw7fBYw82cBT+EbG0Djh6Po6Ihqyr3auHhfFcp1PZH4Mtq
 6hN5KaDZzF/go+tRF5e4bn61Nhdue7mrhFSlfkzLG2ehHWmRV+S91ksH81YDFnazK0sRINBx
 V1S8ts3WJ2f1AbgmnDlbK3c/AfI5YxnIHn/x2ZdXj1P/wn7DgZHmpMy5DMuk0gN34NLUPLA/
 cHeKoBAF8emugljiKecKBpMTLe8FrVOxbkrazsBNBFffeLkBCACweKP3Wx+gK81+rOUpuQ00
 sCyKzdtMuXXJ7oL4GzYHbLfJq+F+UHpQbytVGTn3R5+Y61v41g2zTYZooaC+Hs1+ixf+buG2
 +2LZjPSELWPNzH9lsKNlCcEvu1XhyyHkBDbnFFHWlUlql3nSXMo//dOTG/XGKaEaZUxjCLUC
 8ehLc16DJDvdXsPwWhHrCH/4k92F6qQ14QigBMsl75jDTDJMEYgRYEBT1D/bwxdIeoN1BfIG
 mYgf059RrWax4SMiJtVDSUuDOpdwoEcZ0FWesRfbFrM+k/XKiIbjMZSvLunA4FIsOdWYOob4
 Hh0rsm1G+fBLYtT+bE26OWpQ/lSn4TdhABEBAAHCwF8EGAEIAAkFAlffeLkCGwwACgkQzcQs
 0H1VOp6p5Af/ap5EVuP1AhFdPD3pXLNrUUt72W3cuAOjXyss43qFC2YRjGfktrizsDjQU46g
 VKoD6EW9XUPgvYM+k8BJEoXDLhHWnCnMKlbHP3OImxzLRhF4kdlnLicz1zKRcessQatRpJgG
 NIiD+eFyh0CZcWBO1BB5rWikjO/idicHao2stFdaBmIeXvhT9Xp6XNFEmzOmfHps+kKpWshY
 9LDAU0ERBNsW4bekOCa/QxfqcbZYRjrVQvya0EhrPhq0bBpzkIL/7QSBMcdv6IajTlHnLARF
 nAIofCEKeEl7+ksiRapL5Nykcbt4dldE3sQWxIybC94SZ4inENKw6I8RNpigWm0R5w==
Message-ID: <db86b856-7d7f-e0f6-36d1-c79681d67f8a@canonical.com>
Date: Mon, 9 Apr 2018 15:31:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180102173006.506-2-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri:

Re-send this patch.

Thanks,
Aaron

On 01/03/2018 01:30 AM, Aaron Ma wrote:
> When Rayd touchscreen resumed from S3, it issues too many errors like:
> i2c_hid i2c-RAYD0001:00: i2c_hid_get_input: incomplete report (58/5442)
> 
> And all the report data are corrupted, touchscreen is unresponsive.
> 
> Fix this by re-sending report description command after resume.
> Add device ID as a quirk.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/hid/hid-ids.h         |  3 +++
>  drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5da3d6256d25..753cc10aa699 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -516,6 +516,9 @@
>  #define I2C_VENDOR_ID_HANTICK		0x0911
>  #define I2C_PRODUCT_ID_HANTICK_5288	0x5288
>  
> +#define I2C_VENDOR_ID_RAYD		0x2386
> +#define I2C_PRODUCT_ID_RAYD_3118	0x3118
> +
>  #define USB_VENDOR_ID_HANWANG		0x0b57
>  #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
>  #define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 09404ffdb08b..57a447a9d40e 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -47,6 +47,7 @@
>  /* quirks to control the device */
>  #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
>  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
> +#define I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2)
>  
>  /* flags */
>  #define I2C_HID_STARTED		0
> @@ -171,6 +172,8 @@ static const struct i2c_hid_quirks {
>  		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>  	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>  		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> +	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
> +		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>  	{ 0, 0 }
>  };
>  
> @@ -1211,6 +1214,16 @@ static int i2c_hid_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/* RAYDIUM device (2386:3118) need to re-send report descr cmd
> +	 * after resume, after this it will be back normal.
> +	 * otherwise it issues too many incomplete reports.
> +	 */
> +	if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
> +		ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
> +		if (!ret)
> +			return ret;
> +	}
> +
>  	if (hid->driver && hid->driver->reset_resume) {
>  		ret = hid->driver->reset_resume(hid);
>  		return ret;
> -- 2.14.3
> 
