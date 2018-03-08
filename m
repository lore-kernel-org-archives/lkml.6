Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbeCHTpc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:45:32 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40222 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHTpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:45:31 -0500
X-Google-Smtp-Source: AG47ELseUbsvjIHa+/uxEVBIKmstUClpguIHYGfzVG2HYIB5OPQ9+4DXGZs22eMn3l0i5OB0oIrnow==
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amlogic: meson-gx-socinfo: Update soc ids
Organization: BayLibre
References: <1518620335-17716-1-git-send-email-narmstrong@baylibre.com>
        <1518689694.2883.68.camel@baylibre.com> <7ho9jzgyr2.fsf@baylibre.com>
        <37263741-e817-9a48-615e-13c5b1e2cec0@baylibre.com>
Date: Thu, 08 Mar 2018 11:45:28 -0800
In-Reply-To: <37263741-e817-9a48-615e-13c5b1e2cec0@baylibre.com> (Neil
        Armstrong's message of "Thu, 8 Mar 2018 10:36:34 +0100")
Message-ID: <7hina6fj1j.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hi Kevin,
>
> On 08/03/2018 02:08, Kevin Hilman wrote:
>> Jerome Brunet <jbrunet@baylibre.com> writes:
>> 
>>> On Wed, 2018-02-14 at 15:58 +0100, Neil Armstrong wrote:
>>>> Updates the Amlogic Meson SoCs IDs for the Armv8 based SoCs.
>>>> It includes the new families and packages.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>  drivers/soc/amlogic/meson-gx-socinfo.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
>>>> index f2d8c3c..a7efe30 100644
>>>> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
>>>> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
>>>> @@ -33,6 +33,10 @@ static const struct meson_gx_soc_id {
>>>>  	{ "GXL", 0x21 },
>>>>  	{ "GXM", 0x22 },
>>>>  	{ "TXL", 0x23 },
>>>> +	{ "TXLX", 0x24 },
>>>> +	{ "AXG", 0x25 },
>>>> +	{ "GXLX", 0x26 },
>>>> +	{ "TXHD", 0x27 },
>>>>  };
>>>>  
>>>>  static const struct meson_gx_package_id {
>>>> @@ -47,6 +51,10 @@ static const struct meson_gx_package_id {
>>>>  	{ "S905L", 0x21, 0xc0 },
>>>>  	{ "S905M2", 0x21, 0xe0 },
>>>>  	{ "S912", 0x22, 0 },
>>>> +	{ "962X", 0x24, 0x10 },
>>>> +	{ "962E", 0x24, 0x20 },
>>>> +	{ "A113X", 0x25, 0x37 },
>>>> +	{ "A113D", 0x25, 0xd0 },
>>>>  };
>>>>  
>>>>  static inline unsigned int socinfo_to_major(u32 socinfo)
>>>
>>> Tested on my s400 board which, according to the marking, features an AXG A113D.
>>> AXG is detected correctly but the package id read is 0x22 instead of 0xd0.
>> 
>> Neil, can you update accordingly?  Have you seen 0xd0 on other A11x
>> chips?  or is this from the docs?
>
> I got it from the Amlogic lastest Linux and U-boot code.
> I will set 0x22 and squash the "meson-gx-socinfo: Add package id for S905H" patch, is it ok ?

Sure, that's fine.

Kevin
