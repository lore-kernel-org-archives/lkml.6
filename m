Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934647AbeEIM2V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:28:21 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:44792 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934083AbeEIM2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:28:20 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
References: <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
 <20180424084137.7xfwji2gcibxavvt@flea>
 <03a02abb-e95c-b4ec-748f-907c0af67969@micronovasrl.com>
 <20180425184016.xktppxw7egddr7li@flea>
 <42feccc9-1d09-9ff2-3ccc-1dea63bacfb6@micronovasrl.com>
 <839d2560-0250-9b3a-8019-4e83d9e931e2@micronovasrl.com>
 <20180504080652.dniwaqqhbeuknp7y@flea>
 <afc78821-2d08-3f4f-d008-5b2d216e96c0@micronovasrl.com>
 <20180507073013.dvtbmwi4ora6tdj2@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <102bc56e-f746-6d2c-d3a5-f9d0449781ff@micronovasrl.com>
Date: Wed, 9 May 2018 14:28:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507073013.dvtbmwi4ora6tdj2@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 07/05/2018 09:30, Maxime Ripard ha scritto:
>> Otherwise as in-tree dts with make dtbs "-@" argument is not passed.
>> Right?
> 
> You should use DTC_FLAGS='-@'

Thank you, I'm going to use that.


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
