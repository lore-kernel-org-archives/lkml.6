Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeBSSaP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:30:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753272AbeBSSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:30:13 -0500
Subject: Re: linux-next: Tree for Feb 19 (gpu/drm/pl111/)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20180219131426.14ecac87@canb.auug.org.au>
 <5a671632-f746-52d2-1a9c-1e72a7e2f42b@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b1028c02-9633-47bf-e930-a20926e14ca9@infradead.org>
Date: Mon, 19 Feb 2018 10:30:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5a671632-f746-52d2-1a9c-1e72a7e2f42b@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add Eric + dri-devel]

On 02/19/18 09:26, Randy Dunlap wrote:
> On 02/18/18 18:14, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20180216:
>>
>> The nand tree gained a conflict against Linus' tree.
>>
>> The drm tree gained conflicts against Linus' tree.
> 
> on i386 (randconfig):
> 
> warning: (DRM_PL111) selects DRM_DUMB_VGA_DAC which has unmet direct dependencies (HAS_IOMEM && DRM && DRM_BRIDGE && OF)
> 
> and then
> 
> ../drivers/gpu/drm/bridge/dumb-vga-dac.c: In function 'dumb_vga_probe':
> ../drivers/gpu/drm/bridge/dumb-vga-dac.c:207:13: error: 'struct drm_bridge' has no member named 'of_node'
>   vga->bridge.of_node = pdev->dev.of_node;
>              ^
> 
> 


-- 
~Randy
