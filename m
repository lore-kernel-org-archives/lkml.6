Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967060AbeBNKJ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:09:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:13294 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966963AbeBNKJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:09:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="201041964"
Date: Wed, 14 Feb 2018 12:09:50 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [PATCH 17/18] thunderbolt: Introduce USB only (SL4) security
 level
Message-ID: <20180214100950.GM27191@lahna.fi.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <20180213170018.9780-18-mika.westerberg@linux.intel.com>
 <5b787d94-af95-a249-69ba-54f1528be11e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b787d94-af95-a249-69ba-54f1528be11e@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 04:29:42PM -0800, Randy Dunlap wrote:
> On 02/13/2018 09:00 AM, Mika Westerberg wrote:
> > This new security level works so that it creates one PCIe tunnel to the
> > connected Thunderbolt dock, removing PCIe links downstream of the dock.
> > This leaves only the internal USB controller visible.
> > 
> > Display Port tunnels are created normally.
> > 
> > While there make sure security sysfs attribute returns "unknown" for any
> > future security level.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Hi,
> 
> Also update Documentation/admin-guide/thunderbolt.rst ??

Good point. I'll do that in v2.
