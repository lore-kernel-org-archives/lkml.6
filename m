Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeBFJj6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:39:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34456 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752283AbeBFJjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:39:47 -0500
Date: Tue, 6 Feb 2018 09:39:39 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, kishon@ti.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com, stelford@cadence.com,
        dgary@cadence.com, kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/11] PCI: Add support to the Cadence PCIe controller
Message-ID: <20180206093939.GA2579@e107981-ln.cambridge.arm.com>
References: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
 <20180128214741.GA232763@bhelgaas-glaptop.roam.corp.google.com>
 <20180130114155.GA12009@e107981-ln.cambridge.arm.com>
 <8cec81b2-85c4-d7bf-4171-9e94a745eab0@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cec81b2-85c4-d7bf-4171-9e94a745eab0@free-electrons.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:12:36PM +0100, Cyrille Pitchen wrote:

[...]

> >>> v4 -> v5:
> >>> - rebase on today's (20180128) linux-pci/next
> >>
> >> Don't bother rebasing onto linux-pci/next.
> >>
> >> If your patches actually *depend* on something that has already been
> >> merged onto a PCI topic branch, you should mention that and say which
> >> branch.
> > 
> > Yes - Cyrille please advise which branch(es) this series depends on,
> > it does not apply cleanly to -rc4.
> > 
> > Merge window is open and I do not know what we can do with this series
> > for v4.16 but please let me know.
> >
> 
> I've just sent v6. No change from v5 except that the series has been
> rebased onto linux-pci/master (v4.15-rc4) and tested on the Palladium.
> I've cherry-picked one Kishon's patch from linux-pci/next to test the
> endpoint mode.

We have applied v6 that should get into v4.16, thank you !

Lorenzo
