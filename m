Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030739AbeEXQXO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:23:14 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:20183 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030515AbeEXQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:23:13 -0400
Subject: Re: omapdrm regression in v4.17-rc series
To: Tony Lindgren <tony@atomide.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, <ivo.g.dimitrov.75@gmail.com>,
        <abcloriens@gmail.com>, <sre@kernel.org>, <martijn@brixit.nl>,
        <filip.matijevic.pz@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>, <clayton@craftyguy.net>,
        <patrikbachan@gmail.com>, <serge@hallyn.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20180523220320.GX98604@atomide.com>
 <2f803bfc-3ffe-332a-7b9a-d59a39db4630@ti.com>
 <20180524135407.GB98604@atomide.com>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <39fbfd28-42cb-82d4-4d18-2d674041dff4@ti.com>
Date: Thu, 24 May 2018 19:22:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524135407.GB98604@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/05/18 16:54, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [180524 08:00]:
>>
>> On 24/05/18 01:03, Tony Lindgren wrote:
>>> Hi all,
>>>
>>> I bisected the n900 LCD issue to commit 24aac6011f70 ("drm: omapdrm:
>>> sdi: Allocate the sdi private data structure dynamically"). Reverting
>>> this patch makes LCD work for me again on n900.
>>>
>>> Any ideas?
>>
>> This should help to get the SDI enabled.
> 
> Thanks yes that fixes it:
> 
> Fixes: 24aac6011f70 ("drm: omapdrm: sdi: Allocate the sdi private data
> structure dynamically")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> 

Thanks, pushed to drm-misc-fixes.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
