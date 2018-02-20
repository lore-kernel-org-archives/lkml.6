Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBTUDy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:03:54 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:35504 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeBTUDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:03:53 -0500
Subject: Re: [PATCH] ARM: dtc: tegra: enable front panel leds in TrimSlice
To: Tomasz Maciej Nowak <tmn505@gmail.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180219201623.6987-1-tmn505@gmail.com>
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <57945bd2-d8c2-f7bc-f01f-29d679762446@wwwdotorg.org>
Date: Tue, 20 Feb 2018 12:55:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219201623.6987-1-tmn505@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2018 01:16 PM, Tomasz Maciej Nowak wrote:
> Adds device nodes for two front panel LEDs.

Why do you need to change the pinmux settings? Configuring a pin as a 
GPIO should override any pinmux special function selection and hence 
make it irrelevant, so I don't think you should need to change the pinmux.
