Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeCTO01 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:26:27 -0400
Received: from muru.com ([72.249.23.125]:60962 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeCTO00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:26:26 -0400
Date: Tue, 20 Mar 2018 07:26:23 -0700
From: Tony Lindgren <tony@atomide.com>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am43xx: Enable dual-role mode for USB1
Message-ID: <20180320142623.GV5799@atomide.com>
References: <1521198703-27352-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521198703-27352-1-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [180316 04:12]:
> USB1 port is micro-AB type and can function as peripheral
> as well as host. Enable dual-role mode for USB1.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Tony,
> 
> The USB driver side patches are already in Felipe's next branch.

Thanks applying into omap-for-v4.17/dt.

Regards,

Tony
