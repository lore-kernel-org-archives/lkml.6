Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeCNKQf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:16:35 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:52118 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeCNKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:16:33 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Add Mali node
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1520936205-64723-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180314080500.whywwskhp5546z7m@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <1269750b-5190-a167-8d34-91794e6d0a8c@micronovasrl.com>
Date: Wed, 14 Mar 2018 11:16:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314080500.whywwskhp5546z7m@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 14/03/2018 09:05, Maxime Ripard ha scritto:
> On Tue, Mar 13, 2018 at 11:16:45AM +0100, Giulio Benetti wrote:
>> The H3 has an ARM Mali 400 GPU, so add binding to our DT.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> How was this tested?

I wanted you asked me about this to ask you:
if I can't test it on HW, but others tested it all around,
for example using this patch:
https://github.com/armbian/build/blob/master/patch/kernel/sunxi-next/32-h3-DT-add-mali-node.patch

Is it enough? Or do I have to test it directly?
Or maybe I can invite those people to tag this patch as tested-by ?

> 
> Is there any specific reason not to share it with the H5?

Yes, H5 has dual GPU but quad PP and on IRQ you can clearly see:
- GPU_GP
- GPU_GPMMU
- GPU_PMU
- GPU_PP
- GPU_PP0
- GPU_PPMMU0
- GPU_PP1
- GPU_PPMMU1
- GPU_PP2
- GPU_PPMMU2
- GPU_PP3
- GPU_PPMMU3

So I think they should be placed in specific dts files.
What do you think?

Thanks

> 
> Maxime
> 


-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
