Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeCPJTr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:19:47 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:44322 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeCPJTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:19:43 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.91
Subject: Re: [PATCH] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180316064731.muiw5yumhmfnwxg2@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <658946b9-4f49-ff24-3b84-da1eb9b7d9ad@micronovasrl.com>
Date: Fri, 16 Mar 2018 10:19:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316064731.muiw5yumhmfnwxg2@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Il 16/03/2018 07:47, Maxime Ripard ha scritto:
> Hi Giulio,
> 
> On Thu, Mar 15, 2018 at 02:43:30PM +0100, Giulio Benetti wrote:
>> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
>> for the needed pins.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Like we discussed last time, we only merge this kind of patches if
> there's an immediate user.

You're right.
In few time(I hope), I'm going to send dts for Linova1-4_3 and Linova1-7,
where I use those pins.
I have also to send 2 patches for 2 new panels for panel-simple.

So I think I have to send 2 displays' patches before.
And a patchset for the 2 boards and rgb888 pins.

One question: do I have to wait for panels' patches to applied and then 
send patchset for boards dts?
Or can I send a unique patchset?
Because as I understand those patches should be applied to 2 different 
repositories, right?

Thanks in advance

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

> 
> Maxime
> 
