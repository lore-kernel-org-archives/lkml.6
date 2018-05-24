Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970021AbeEXX5y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:57:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964970AbeEXX5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:57:49 -0400
Date: Thu, 24 May 2018 16:57:46 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v2 5/7] platform/x86: mlx-platform: Add LED platform
 driver activation
Message-ID: <20180524235746.GB10172@fury>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
 <1525675735-125547-3-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525675735-125547-3-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 06:48:53AM +0000, Vadim Pasternak wrote:
> Add LED platform driver activation from mlx-platform. This LED driver uses
> the same regmap infrastructure as others Mellanox platform drivers, so LED
> specific registers description is added.
> 
> System LED configuration depends on system type. To support all the
> relevant types per system type LED descriptions are defined for passing
> to LED platform driver.
> 
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> v1->v2:
>  Fixes added by Vadim:
>  - Remove inline functions from mlxreg.h file;

Please remember to put the patch changelog below the --- line below.

> ---

Here

Queued up for testing, thanks.
-- 
Darren Hart
VMware Open Source Technology Center
