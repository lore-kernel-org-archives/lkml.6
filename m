Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969002AbeE3JqX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:46:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33143 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965213AbeE3JqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:46:22 -0400
X-ME-Proxy: <xmx:7XIOW96-BTguMJpllCQNs1z_KPyXNvQvCz4jWZ2qP1Ce-TEldCzOtg>
X-ME-Proxy: <xmx:7XIOW2h-Fw4Cm1bkZcNqvcLVB4s_-kCKHSSo-lVV5oy3TALCY0RHfg>
X-ME-Proxy: <xmx:7XIOW2nZGXOD0pTyd59O6onsVq0vbLsUcxQ3iAdczWObfHR14_W6TQ>
X-ME-Proxy: <xmx:7XIOW0g4omU3_hDYr8bizf6bTuGamMDbnc1O7-N3JmL9pr_eGlKf1w>
X-ME-Proxy: <xmx:7XIOW-10ztgWigXz9iq3hcBwdh96D0zBQ1O3dSTQkSd_8pN-ChRQ0g>
X-ME-Proxy: <xmx:7XIOW4nrIVYZvrBpsQILCOl-pR7_VKagP2qI68KJHCWK73zbqfbiDQ>
X-ME-Sender: <xms:7XIOW__udBlGgA1uTo83IwXWymptAY9Lv4nRuHFB2pI9WeyGrXjKEQ>
Date: Wed, 30 May 2018 11:46:02 +0200
From: Greg KH <greg@kroah.com>
To: YaoJun <yaojun8558363@gmail.com>
Cc: kernel-hardening@lists.openwall.com, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 1/4] arm64/mm: migrate swapper_pg_dir
Message-ID: <20180530094602.GB25193@kroah.com>
References: <20180530091259.9386-1-yaojun8558363@gmail.com>
 <20180530091259.9386-2-yaojun8558363@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530091259.9386-2-yaojun8558363@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 05:12:56PM +0800, YaoJun wrote:
> Introduce __pa_swapper_pg_dir to save physical address
> of swapper_pg_dir. And pass it as an argument to
> __enable_mmu().
> 
> Signed-off-by: YaoJun <yaojun8558363@gmail.com>

This is better, but your subject line is still identical for all 4
patches (which doesn't make sense as they do different things), and I
think you need to put a space in your name somewhere, right?

thanks,

greg k-h
