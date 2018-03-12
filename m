Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeCLHgR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeCLHgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:36:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A349205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 12 Mar 2018 15:35:26 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daniel Vetter <daniel.vetter@intel.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: zte: Fix an error handling path in 'zx_crtc_bind()'
Message-ID: <20180312073524.GM3217@dragon>
References: <20180311223203.3669-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311223203.3669-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Daniel

On Sun, Mar 11, 2018 at 11:32:03PM +0100, Christophe JAILLET wrote:
> 'ret' is known to be 0 at this point. It must be updated by the value
> returned by 'clk_prepare_enable()'.
> 
> Fixes: 0a886f59528a ("drm: zte: add initial vou drm driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Shawn Guo <shawnguo@kernel.org>
