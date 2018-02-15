Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967851AbeBOLTW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:19:22 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36209 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966589AbeBOLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:19:20 -0500
X-Google-Smtp-Source: AH8x224lJGT9Lz8DgR7BW0/APE5nFNvi9e1+EulEehrk8Xk3X2TF7O0VQFU+MQJlYxeOz8mBhYAwyg==
Subject: Re: [PATCH v2 0/2] Fix broken bananapi m2 devicetree/regulators
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180214141025.22171-1-embed3d@gmail.com>
 <20180215090838.fnenymzrejs6vhcf@flea.home>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <89d2da32-82c5-84d9-507e-aa17d782d766@gmail.com>
Date: Thu, 15 Feb 2018 12:19:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215090838.fnenymzrejs6vhcf@flea.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2018 10:08, Maxime Ripard wrote:
> On Wed, Feb 14, 2018 at 03:10:23PM +0100, Philipp Rossak wrote:
>> This patchseries fixes the bananapi m1 devicetree, to be able to boot again.
>> The first two patches update/improve the devicetree and the last patch adds
>> all missing regulators.
>>
>> Regards,
>> Philipp
>>
>> Changes since v1:
>> 	* squashed commit 1 and 3
>> 	* fix wrong mmc regulator
>>
>> Philipp Rossak (2):
>>    arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
>>    arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators
> 
> Applied both.
> 
> I had to make a couple of changes though, in the commit title arm
> should be uppercase, and the fix isn't needed.
> 
> I also added stable in Cc, since these patches have been there for
> quite some time.
> 
> Maxime
> 

Thanks!

Philipp
