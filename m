Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeBGOAe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:00:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:3575 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbeBGOAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:00:32 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="32829482"
Date: Wed, 7 Feb 2018 16:00:28 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, Jiri Koshina <jikos@kernel.org>
Subject: Re: [PATCH] x86: PM: Make APM idle driver initialize polling state
Message-ID: <20180207140028.GV5453@intel.com>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com>
 <1862424.1bTBpgPzTf@aspire.rjw.lan>
 <20180206182617.GQ5453@intel.com>
 <1595367.GFL0qxR379@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595367.GFL0qxR379@aspire.rjw.lan>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 10:20:58AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 6, 2018 7:26:17 PM CET Ville Syrjälä wrote:
> > On Tue, Feb 06, 2018 at 07:02:58PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Update the APM driver overlooked by commit 1b39e3f813b4 (cpuidle: Make
> > > drivers initialize polling state) to initialize the polling state like
> > > the other cpuidle drivers modified by that commit to prevent cpuidle
> > > from crashing.
> > > 
> > > Fixes: 1b39e3f813b4 (cpuidle: Make drivers initialize polling state)
> > > Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > And maybe?
> > 
> > Cc: <stable@vger.kernel.org> # v4.14+
> 
> I add these when applying patches.
> 
> Actually, I've queued up the patch with this tag already.

Cool. Thanks.

-- 
Ville Syrjälä
Intel OTC
