Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032888AbeBNQnh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:43:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:29834 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032509AbeBNQne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:43:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="204113471"
Date: Wed, 14 Feb 2018 18:43:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [PATCH 00/18] thunderbolt: Add support for Intel Titan Ridge
Message-ID: <20180214164329.GV27191@lahna.fi.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <CAHp75Vf0shEVjdGkh6TiaGNLyK-jMeGWOq-RqvdgZRUMbCXxOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf0shEVjdGkh6TiaGNLyK-jMeGWOq-RqvdgZRUMbCXxOA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 03:58:52PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Hi,
> >
> > This series adds support for Intel Titan Ridge Thunderbolt controller.
> > Titan Ridge is the next generation Thunderbolt 3 controller and successor
> > of Alpine Ridge.
> >
> > In addition to fixes and Titan Ridge support this series adds following:
> >
> >   - USB only security level (SL4).
> >
> >   - A new attribute for devices telling whether they were connected
> >     automatically during boot.
> >
> >   - Preboot ACL allows userspace to specify a list of devices (based on
> >     device unique_id) that the firmware automatically connects during boot.
> >
> > Bjorn, I've Cc'd you the series as well because I would like to get your
> > blessing for patch [2/18] as it uses functions from PCI subsystem.
> >
> > Thanks!
> 
> For patches 1-17,
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!
