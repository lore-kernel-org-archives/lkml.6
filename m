Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbeE1Iy2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:54:28 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:42760 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbeE1IyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:54:23 -0400
Subject: Re: [PATCH 1/2] ASoC: omap: sdma-pcm: add module license
To: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC: Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180525160248.4135506-1-arnd@arndb.de>
 <20180525173531.GP4828@sirena.org.uk>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <517750ec-5db4-fecb-3a26-271b2007b4aa@ti.com>
Date: Mon, 28 May 2018 11:55:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525173531.GP4828@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-25 20:35, Mark Brown wrote:
> On Fri, May 25, 2018 at 06:02:31PM +0200, Arnd Bergmann wrote:
>> Kbuild warns that we should have a MODULE_LICENSE() tag in the new module:
>>
>> WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o
> 
> This doesn't apply against current code, please check and resend.

'ASoC: omap: sdma-pcm: Fix modpost warning' is already applied which
adds the missing MODULE_LICENSE()

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
