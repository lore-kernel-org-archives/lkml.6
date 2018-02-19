Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeBSKwy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:52:54 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50246 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeBSKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:52:53 -0500
Subject: Re: [PATCH v2] ARM: da8xx: use platform data for CFGCHIP syscon
 regmap
To: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC: Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1518924144-5308-1-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <7f7ea722-6563-0c11-68f9-947f8ae7a26f@ti.com>
Date: Mon, 19 Feb 2018 16:21:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518924144-5308-1-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 February 2018 08:52 AM, David Lechner wrote:
> This converts from using a platform device for the CFGCHIP syscon
> regmap to using platform data to pass the regmap to consumers.
> 
> A lazy getter function is used so that the regmap will only be
> created if it is actually used. This function will also be used
> in the clock init when we convert to the common clock framework.
> 
> The USB PHY driver is currently the only consumer. This driver is
> updated to use platform data to get the CFGCHIP regmap instead of
> syscon_regmap_lookup_by_pdevname().
> 
> Signed-off-by: David Lechner <david@lechnology.com>>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> ---
> 
> v2 changes:
> - add #ifndef/#define to header file

Thanks. Picked this instead of the earlier version I had queued.

Regards,
Sekhar
