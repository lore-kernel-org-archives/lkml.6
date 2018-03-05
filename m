Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeCEPZL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeCEPZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:25:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBDC20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=dinguyen@kernel.org
Subject: Re: [PATCH] arm64: dts: stratix10: enable i2c, add i2c periperals
To: Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180221202541.3258-1-atull@kernel.org>
From: Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <6661d0f4-79b5-91d2-7507-e15e7004ebe5@kernel.org>
Date: Mon, 5 Mar 2018 09:25:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221202541.3258-1-atull@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 02/21/2018 02:25 PM, Alan Tull wrote:
> Add clock for i2c
> Enable i2c1
> Set the i2c bus speed to 100KHz
> Add the following i2c peripherals
> * ds1339 RTC
> * 24c32 EEPROM
> * max1619 temperature monitor
> * ltc2497 ADC
>   * Add a fixed regulator for the ADC's Vref.
> 
> This requires Dinh Nguyen's Stratix10 clock driver
> ("clk: socfpga: stratix10: add clock driver for Stratix10 platform")
> 

Thanks for the patch! I've staged this patch based on the clock driver
patch.

Dinh
