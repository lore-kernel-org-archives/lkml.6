Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBIAt5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:49:57 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37301 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeBIAtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:49:55 -0500
X-Google-Smtp-Source: AH8x225ZobPvxqWMf6MxBz1tUUjqy71/eop7czQqP4/ukswNhuhmIfVTobz8Xz5Jt26h6qw2YL4HWw==
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, Carlo Caione <carlo@caione.org>,
        Arnaud Patard <arnaud.patard@rtp-net.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] meson-gx-socinfo: make local function meson_gx_socinfo_init static
Organization: BayLibre
References: <1515593988-78626-1-git-send-email-weiyongjun1@huawei.com>
        <3cb83737-bb60-7648-e72e-2d39590c8418@baylibre.com>
Date: Thu, 08 Feb 2018 16:49:52 -0800
In-Reply-To: <3cb83737-bb60-7648-e72e-2d39590c8418@baylibre.com> (Neil
        Armstrong's message of "Tue, 6 Feb 2018 13:25:19 +0100")
Message-ID: <7hh8qr9ebz.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 10/01/2018 15:19, Wei Yongjun wrote:
>> Fixes the following sparse warnings:
>> 
>> drivers/soc/amlogic/meson-gx-socinfo.c:100:12: warning:
>>  symbol 'meson_gx_socinfo_init' was not declared. Should it be static?
>> 
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/soc/amlogic/meson-gx-socinfo.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
>> index f2d8c3c..ea091f1 100644
>> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
>> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
>> @@ -97,7 +97,7 @@ static const char *socinfo_to_soc_id(u32 socinfo)
>>  	return "Unknown";
>>  }
>>  
>> -int __init meson_gx_socinfo_init(void)
>> +static int __init meson_gx_socinfo_init(void)
>>  {
>>  	struct soc_device_attribute *soc_dev_attr;
>>  	struct soc_device *soc_dev;
>> 
>> 
>> 
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for v4.17, with Neil's ack.

Kevin
