Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756054AbeDXFpf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:45:35 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:32824 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755809AbeDXFpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:45:33 -0400
X-Google-Smtp-Source: AIpwx4/99GJhOP29agWN9NTFv/LjKLgLkXNpcmH5qBtKeMhNo95rG1uedHR1JLyWhtsr5FjCgQCTXw==
Date: Tue, 24 Apr 2018 06:45:29 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180424054529.2gv2l24muxzh2n6b@dell>
References: <20180420083909.66a6t63s5q6vpwp7@dell>
 <20180420090910.GA26071@mwanda>
 <20180423064417.2e2ng3su23w4i7hx@dell>
 <20180423102717.tmx7mlk2yzovnpkh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180423102717.tmx7mlk2yzovnpkh@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, Dan Carpenter wrote:

> I really don't want authorship credit for a patch that does:
> 
> #define COMP1 0
> #define COMP2 1
> 
> It just makes me itch to look at it...

As I say, I get where you're coming from, but it was the decision made
by the H/W engineers.  Doesn't mean it's not the correct thing to do
from a S/W POV.

If you're not happy putting your SOB on the patch, I'll draft it and
sign it off.  /me has no shame!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
