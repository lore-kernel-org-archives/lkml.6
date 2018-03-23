Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeCWLzQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:55:16 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:60605 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbeCWLzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:55:14 -0400
Subject: Re: linux-next: Signed-off-by missing for commits in the drm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20180321202705.708b8f1a@canb.auug.org.au>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3c732eda-70f8-c410-f66e-de42a7fc5096@ti.com>
Date: Fri, 23 Mar 2018 13:55:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321202705.708b8f1a@canb.auug.org.au>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/18 11:27, Stephen Rothwell wrote:
> Hi all,
> 
> A series of commits
> 
>   a82f034765fa ("drm: omapdrm: Split init and cleanup from probe and remove functions")
> to
>   663ac57b285d ("drm: omapdrm: venc: Allocate the venc private data structure dynamically")
> 
> are missing a Signed-off-by from their commiter.

Sorry about that again. I now have a script to check this, so I hope
this was the last time...

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
