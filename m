Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCUHFN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:05:13 -0400
Received: from mleia.com ([178.79.152.223]:60740 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeCUHFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:05:11 -0400
Subject: Re: [PATCH 3/3] i2c: mux: pca9541: prepare for PCA9641 support
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>,
        Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au,
        linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-4-peda@axentia.se>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <7c14645a-3166-c793-550f-0db8cdfd8873@mleia.com>
Date: Wed, 21 Mar 2018 09:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320093200.19179-4-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180321_070510_520912_BF546BD2 
X-CRM114-Status: UNSURE (   6.63  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 11:32 AM, Peter Rosin wrote:
> Make the arbitrate and release_bus implementation chip specific.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>


The change is really good and correct, it is just too extended IMHO.

--
With best wishes,
Vladimir
