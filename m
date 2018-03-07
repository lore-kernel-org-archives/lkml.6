Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbeCGJQy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 04:16:54 -0500
Received: from 8bytes.org ([81.169.241.247]:45818 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeCGJQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 04:16:52 -0500
Date: Wed, 7 Mar 2018 10:16:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vinod.koul@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] MAINTAINERS: Add linux/of_*.h headers to appropriate
 subsystems
Message-ID: <20180307091651.GA18430@8bytes.org>
References: <20180306151334.28720-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306151334.28720-1-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 09:13:34AM -0600, Rob Herring wrote:
> The DeviceTree support code for specific subsystems are maintained by
> the respective subsystem maintainers. However, only the DT
> maintainers are listed for most of the linux/of_*.h headers. Fix this
> and add the headers to the appropriate subsystem maintainer.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Joerg Roedel <jroedel@suse.de>
