Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeCPKen (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:34:43 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:27925 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeCPKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:34:42 -0400
Subject: Re: [PATCH] ARM: davinci: DA8XX: simplify CFGCHIP regmap_config
To: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC: Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-kernel@vger.kernel.org>
References: <1521137621-6491-1-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <9e517194-2189-4e05-388b-a0a97cb751b1@ti.com>
Date: Fri, 16 Mar 2018 16:03:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521137621-6491-1-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 March 2018 11:43 PM, David Lechner wrote:
> Since commit 8253bb3f8255 ("regmap: potentially duplicate the name
> string stored in regmap"), the name field of struct regmap_config
> is copied in __regmap_init(), so we no longer need to worry about
> keeping our own copy of the name.
> 
> Just use a string literal in the initialization of da8xx_cfgchip_config
> instead of creating a separate variable for the name.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.17/soc of my tree.

Thanks,
Sekhar
