Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeBAPh5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:37:57 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:45390 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeBAPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:37:56 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH] arm: dts: sun7i: include correct ccu clock header
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1517427086-66480-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180201151900.2zabioxbq7iehl4v@flea.lan>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <3ae29cfa-a87e-c8da-60a7-4f8792fe52cf@micronovasrl.com>
Date: Thu, 1 Feb 2018 16:37:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180201151900.2zabioxbq7iehl4v@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/02/2018 16:19, Maxime Ripard ha scritto:
> Hi,
> 
> On Wed, Jan 31, 2018 at 08:31:26PM +0100, Giulio Benetti wrote:
>> Include correct clock header sun7i-a20-ccu.h
>> instead of sun4i-a20-ccu.h.
> 
> You should wrap at 72 characters.

Ok, keep in mind for next patches. Thanks

> 
>> Including sun4i header instead of sun7i
>> prevents using sun7i specific defines.
>>
>> Substitute header inclusion in sun7i-a20.dtsi
>> using right one.
> 
> This sentence is redundant with the first one.

Yes, you're right. Thanks

> 
> Dropped the first one, corrected the wrapping and applied, thanks
> 
> Maxime
> 


-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
