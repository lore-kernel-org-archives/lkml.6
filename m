Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEDCHC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:07:02 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:50282 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeEDCHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:07:01 -0400
Subject: Re: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
To: Mark Brown <broonie@kernel.org>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-4-yixun.lan@amlogic.com>
 <20180503231604.GD13402@sirena.org.uk>
CC: <yixun.lan@amlogic.com>, Sunny Luo <sunny.luo@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <e5610b7f-9e34-3925-cb40-1c62a3c470d2@amlogic.com>
Date: Fri, 4 May 2018 10:07:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180503231604.GD13402@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On 05/04/18 07:16, Mark Brown wrote:
> On Thu, May 03, 2018 at 09:36:44PM +0000, Yixun Lan wrote:
>> From: Sunny Luo <sunny.luo@amlogic.com>
>>
>> The SPICC controller in Meson-AXG SoC is capable of using
>> a linear clock divider to reach a much fine tuned range of clocks,
>> while the old controller only use a power of two clock divider,
>> result at a more coarse clock range.
>>
>> Also convert the clock registeration into Common Clock Framework.
> 
> This would be better split into two patches - one adding the new linear
> clock divider and the other one doing the CCF conversion.  Splitting
> things out like that makes them much easier to review as each change is
> only doing one thing.
> 

it's maybe obscure in my previous commit message, the clock divider
support is actually achieved via CCF framework, it can be split as two
independent patches..

I'm CCing clock mailing list (will do if I need to send a v2)

Yixun
