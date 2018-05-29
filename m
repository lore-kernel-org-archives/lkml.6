Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966401AbeE2TPB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:15:01 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:33284 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965614AbeE2TO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:14:56 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Tue, 29 May 2018 21:14:53 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Vinod <vkoul@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH] dmaengine: pxa: add a default requestor policy
References: <20180526095418.22960-1-robert.jarzmik@free.fr>
        <20180529072401.GG5666@vkoul-mobl>
X-URL: http://belgarath.falguerolles.org/
Date: Tue, 29 May 2018 21:13:54 +0200
In-Reply-To: <20180529072401.GG5666@vkoul-mobl> (Vinod's message of "Tue, 29
        May 2018 12:54:01 +0530")
Message-ID: <874liqtgul.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod <vkoul@kernel.org> writes:

> On 26-05-18, 11:54, Robert Jarzmik wrote:
>> @@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
>>  	dma_pool_destroy(chan->desc_pool);
>>  	chan->desc_pool = NULL;
>>  
>> +	chan->drcmr = (u32)-1;
>
> why not use U32_MAX for this?
But of course, anything else you see ?

Cheers.

-- 
Robert
