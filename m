Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeDUPAU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 11:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbeDUPAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 11:00:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C320214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 16:00:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Fabian Mewes <architekt@coding4coffee.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, Lukas Wunner <lukas@wunner.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: mcp320x: Use vendor prefix
 compatible strings
Message-ID: <20180421160012.235db7ea@archlinux>
In-Reply-To: <20180416214355.qa4y3jbqnaegmtzl@rob-hp-laptop>
References: <1523892846-25000-1-git-send-email-architekt@coding4coffee.org>
        <20180416214355.qa4y3jbqnaegmtzl@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018 16:43:55 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Apr 16, 2018 at 05:34:06PM +0200, Fabian Mewes wrote:
> > Update the example to use the compatible string including the
> > vendor prefix instead of the ones deprecated in 3a872138e4b.
> > 
> > Signed-off-by: Fabian Mewes <architekt@coding4coffee.org>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/mcp320x.txt |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Good catch - Applied to the togreg branch of iio.git and
pushed out as testing to be completely ignored by the autobuilders.

Thanks,

Jonathan
