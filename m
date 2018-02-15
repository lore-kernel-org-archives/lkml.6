Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033097AbeBOOEx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:04:53 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:56834 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032283AbeBOOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:04:51 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH] ARM: sun7i: dt: Add Mali node
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1518702362-115625-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180215135840.vt4ujoecvirpidbr@flea.lan>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <1dd9f126-b209-a6f6-2159-6727744a6c6e@micronovasrl.com>
Date: Thu, 15 Feb 2018 15:04:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215135840.vt4ujoecvirpidbr@flea.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/02/2018 14:58, Maxime Ripard ha scritto:
> On Thu, Feb 15, 2018 at 02:46:02PM +0100, Giulio Benetti wrote:
>> The A20 has an ARM Mali 400 GPU, so add binding to our DT.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> The prefix should have been ARM: dts: sun7i. Fixed and applied, thanks!
> Maxime
> 

Oh, right.
Thank you!

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
