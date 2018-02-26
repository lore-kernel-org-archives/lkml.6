Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeBZF50 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 00:57:26 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61017 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBZF5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 00:57:24 -0500
Subject: Re: [PATCH] ARM: dts: da850-lego-ev3: use a correct fallback for at24
 compatible
To: David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180122125505.16806-1-brgl@bgdev.pl>
 <c4c07714-4937-48bd-466d-c2c9848c4725@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <134fc583-785c-0112-94f2-f94b9ff93065@ti.com>
Date: Mon, 26 Feb 2018 11:25:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c4c07714-4937-48bd-466d-c2c9848c4725@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 January 2018 10:20 PM, David Lechner wrote:
> On 01/22/2018 06:55 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We now require all at24 users to use the "atmel,<model>" fallback in
>> device tree for different manufacturers.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
> 
> Reviewed-by: David Lechner <david@lechnology.com>

Applied to v4.17/dt

Thanks,
Sekhar
