Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeC3KiS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:38:18 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:17878 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeC3KiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:38:16 -0400
Subject: Re: [PATCH 1/3] iio: adc: meson-saradc: squash and share the common
 adc platform data
To: Jonathan Cameron <jic23@kernel.org>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
 <20180326084629.100070-2-yixun.lan@amlogic.com>
 <20180330104813.7dd79bd5@archlinux>
CC: <yixun.lan@amlogic.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>, <linux-iio@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <c0dde5a6-c490-c8ea-5652-bcc27ee9f0e7@amlogic.com>
Date: Fri, 30 Mar 2018 18:37:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180330104813.7dd79bd5@archlinux>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/18 17:48, Jonathan Cameron wrote:
> On Mon, 26 Mar 2018 16:46:27 +0800
> Yixun Lan <yixun.lan@amlogic.com> wrote:
> 
>> Extract and promote common adc platform data into a new structure,
>> to make it better share the info between several SoCs,
>> this will avoid duplicating the code all over the place,
>> Save a few memory and make the code more maintainable.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Hi Jonathan

  Great! Thanks for taking these

Yixun
