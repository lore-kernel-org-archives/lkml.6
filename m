Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCOFVG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 01:21:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44718 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeCOFVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 01:21:04 -0400
X-Google-Smtp-Source: AG47ELs0nu7uRydqIMwrGMLyBZb41WsqoawEql0iHMWPsp4o8/OPW2b4KCQqJmLd4pYWxDLwCz4Yyw==
Date: Thu, 15 Mar 2018 00:21:02 -0500
From: Andy Gross <andy.gross@linaro.org>
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: msm8974: castor: Fix typo and add startup
 delay in touchscreen node
Message-ID: <20180315051936.GC5910@hector.attlocal.net>
References: <20180312160734.5606-1-ctatlor97@gmail.com>
 <20180313164638.7211-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313164638.7211-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 04:46:38PM +0000, Craig Tatlor wrote:
> The compatible string was mistakenly pulled from the downstream tree and the
> startup delay property is needed to prevent io errors on initial page select.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Thanks for the patch.  I'll add Bjorn's reviewed-by and apply it.

Regards,
Andy
