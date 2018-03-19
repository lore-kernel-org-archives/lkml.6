Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970909AbeCSTvR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:51:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32947 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969480AbeCSTvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:51:13 -0400
Date: Mon, 19 Mar 2018 20:50:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Jan Kiszka <jan.kiszka@siemens.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Benedikt Spranger <b.spranger@linutronix.de>,
        Juergen Gross <jgross@suse.com>, Mark Rutland <mark.rutland@arm.com>,
        Otavio Pontes <otavio.pontes@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 0/7] jailhouse: Enhance secondary Jailhouse guest
 support /wrt PCI
In-Reply-To: <20180319194813.GJ77194@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.21.1803192049500.1520@nanos.tec.linutronix.de>
References: <cover.1520408357.git.jan.kiszka@siemens.com> <20180319194813.GJ77194@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Mon, 19 Mar 2018, Bjorn Helgaas wrote:

> On Wed, Mar 07, 2018 at 08:39:11AM +0100, Jan Kiszka wrote:
> > Basic x86 support [1] for running Linux as secondary Jailhouse [2] guest
> > is currently pending in the tip tree. This builds on top and enhances
> > the PCI support for x86 and also ARM guests (ARM[64] does not require
> > platform patches and works already).
> > ...
> 
> Hi Jan,
> 
> What tree do you plan to merge this through?  I was sort of assuming
> x86, since the main point of jailhouse is not PCI, but I do notice
> most of the changes here are PCI-related, so thought I should make
> sure you're not waiting on me.

I picked it up already. It's sitting in tip x86/platform

Thanks,

	tglx
