Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbeFDRM3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:12:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51289 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeFDRM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:12:27 -0400
X-Google-Smtp-Source: ADUXVKKntpe3ATlzcae+YGSuQB+STIuJw+5htZvvye+RMfwOS9Ggf3hCIbA4xEmUggja9PxT9AkSnbhPf6j5KUHwnaw=
MIME-Version: 1.0
In-Reply-To: <20180604085900.GN25455@dell>
References: <20180530031704.18597-1-fparent@baylibre.com> <20180530031704.18597-2-fparent@baylibre.com>
 <20180604085900.GN25455@dell>
From: Fabien Parent <fparent@baylibre.com>
Date: Mon, 4 Jun 2018 10:12:26 -0700
Message-ID: <CAOwMV_xyqj027+iRAQtZ5Hv8NDUc6s9OfS0vAkumUyyc4LUjzw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: cros: add charger port count command definition
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guillaume Pain <gpain@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w54HCYms031592

On Mon, Jun 4, 2018 at 1:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 29 May 2018, Fabien Parent wrote:
>
>> A new more command has been added to the ChromeOS embedded controller
>> that allows to get the number of charger port count. Unlike
>> EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
>> port if present.
>>
>> This command will be used to expose the dedicated charger port
>> in the ChromeOS charger driver.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> ---
>>  include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>
> Does not want to apply.  I didn't investigate why.
>
> Please rebase and resend?

Sorry, I forgot to add you as "to:" to the patch series.
This patch applies on top of https://lkml.org/lkml/2018/5/2/590
([PATCH v4 1/3] mfd: cros_ec: Add USBPD charger commands and struct
definitions)

> --
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
