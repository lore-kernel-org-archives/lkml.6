Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBGWvz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:51:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52007 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeBGWvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:51:54 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mario.Limonciello@dell.com, pali.rohar@gmail.com,
        andy.shevchenko@gmail.com, dvhart@infradead.org,
        platform-driver-x86@vger.kernel.org, acelan.kao@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI driver
Date: Wed, 07 Feb 2018 23:50:11 +0100
Message-ID: <2040799.1aJPVOsbqr@aspire.rjw.lan>
In-Reply-To: <1518009532.22495.140.camel@linux.intel.com>
References: <20180131182614.19524-1-andriy.shevchenko@linux.intel.com> <8d143fabe24f43de933dc60ce6480d00@ausx13mpc120.AMER.DELL.COM> <1518009532.22495.140.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 7, 2018 2:18:52 PM CET Andy Shevchenko wrote:
> On Wed, 2018-02-07 at 13:08 +0000, Mario.Limonciello@dell.com wrote:
> > > -----Original Message-----
> > > From: Pali Rohár [mailto:pali.rohar@gmail.com]
> > > Sent: Wednesday, February 7, 2018 3:55 AM
> > > To: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Limonciello, Mario
> > > <Mario_Limonciello@Dell.com>; andriy.shevchenko@linux.intel.com;
> > > dvhart@infradead.org; platform-driver-x86@vger.kernel.org;
> > > acelan.kao@canonical.com; linux-kernel@vger.kernel.org
> > > Subject: Re: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to
> > > pure ACPI driver
> > > 
> > > On Wednesday 07 February 2018 10:47:57 Rafael J. Wysocki wrote:
> > > > BTW, please CC patches with ACPI material to linux-acpi.  They are
> > > > less likely
> > > > to be overlooked by me then and the others on that list may have
> > > > opinions on
> > > > them too.
> > > 
> > > Maybe we can update MAINTAINERS file for acpi based platform-x86
> > > drivers
> > > to include linux-acpi list? Darren, Andy, any idea?
> > > 
> > 
> > I would also wonder if the intel-vbtn driver should still live in
> > platform-x86 as it's
> > now pure ACPI driver with this change Andy proposed.
> > 
> > Btw Andy for your v2 with your fixups that were in your review branch
> > feel free
> > to add:
> > Tested-by: Mario Limonciello <mario.limonciello@dell.com>
> > 
> > When you resubmit it.
> 
> Mario, Rafael clarifies the matter and NACKed this one (which kinda was
> expected by me, that's why RFC was in the first place).
> 
> I'm going to drop this patch from my queue.

Thanks!
