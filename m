Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDSUtr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:49:47 -0400
Received: from mleia.com ([178.79.152.223]:49724 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbeDSUtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:49:46 -0400
Subject: Re: [PATCH 7/7] i2c: pnx: move header into the driver
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-8-wsa@the-dreams.de>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <9f2ced1e-6988-2c4d-88aa-da48dd478446@mleia.com>
Date: Thu, 19 Apr 2018 23:49:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180419200015.15095-8-wsa@the-dreams.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180419_214945_424637_0457A92A 
X-CRM114-Status: UNSURE (   7.96  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 04/19/2018 11:00 PM, Wolfram Sang wrote:
> There are no platform_data users anymore. Move the structs into the
> driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

Thank you for the nice change!

--
With best wishes,
Vladimir
