Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeFEUfc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:35:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56905 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeFEUfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:35:30 -0400
Date: Tue, 5 Jun 2018 22:35:10 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Haim Boot <hayim@marvell.com>,
        Hanna Hawa <hannah@marvell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/16] dt-bindings/interrupt-controller: update
 Marvell ICU bindings
Message-ID: <20180605223510.0249b86c@windsurf>
In-Reply-To: <20180605202902.GA8875@rob-hp-laptop>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
        <20180522094042.24770-13-miquel.raynal@bootlin.com>
        <20180605202902.GA8875@rob-hp-laptop>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 5 Jun 2018 14:29:02 -0600, Rob Herring wrote:
> On Tue, May 22, 2018 at 11:40:38AM +0200, Miquel Raynal wrote:
> > Change the documentation to reflect the new bindings used for Marvell
> > ICU. This involves describing each interrupt group as a subnode of the
> > ICU node. Each of them having their own compatible.  
> 
> Need to explain why you need to do this and why breaking backwards 
> compatibility is okay.

It does not break backward compatibility. The driver changes keep
support for the previous DT binding where there was a single node with
no subnodes.

The DT binding documentation still documents the legacy binding,
because it is still supported, and still works.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
