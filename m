Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeDXI5Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:57:16 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:46086 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeDXI5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:57:13 -0400
Subject: Re: [PATCH] davinci_all_defconfig: enable support for remoteproc
 drivers
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        David Lechner <david@lechnology.com>, Suman Anna <s-anna@ti.com>,
        Aparna Balasubramanian <aparnab@ti.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Adam Ford <aford173@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Kevin Hilman <khilman@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180419120313.31359-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <4ccf3288-a934-4e79-b609-e27313c016e0@ti.com>
Date: Tue, 24 Apr 2018 14:25:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419120313.31359-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 April 2018 05:33 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Enable the remoteproc framework and the da8xx remoteproc driver by
> default in the davinci defconfig.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to v4.18/defconfig. Please note that subject like convention is
"ARM: davinci_all_defconfig: .."

Thanks,
Sekhar
