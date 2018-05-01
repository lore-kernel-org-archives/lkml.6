Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755935AbeEAPQq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:16:46 -0400
Received: from muru.com ([72.249.23.125]:39400 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755849AbeEAPQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:16:44 -0400
Date: Tue, 1 May 2018 08:16:31 -0700
From: Tony Lindgren <tony@atomide.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap1: osk: use device properties for at24 eeprom
Message-ID: <20180501151631.GL5671@atomide.com>
References: <20180404123822.5664-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404123822.5664-1-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bartosz Golaszewski <brgl@bgdev.pl> [180404 05:39]:
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
> 
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Applying into omap-for-v4.18/omap1 thanks.

Tony
