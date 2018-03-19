Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031040AbeCST7Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:59:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:63287 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967646AbeCST6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:58:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39356606"
Date: Mon, 19 Mar 2018 13:33:12 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] block: sed-opal support write to shadow mbr
Message-ID: <20180319193311.bkwq3ir75dz6awcn@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
 <20180319195335.GB3380@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319195335.GB3380@lst.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 08:53:35PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 19, 2018 at 07:36:42PM +0100, Jonas Rabenstein wrote:
> > Hi,
> > I was advised to resend the patchset as a v2 where all the patches are
> > in a flat hierarchy. So here is a complete set which hopefully pleases
> > all requirements.
> > As the previous fixes have by now all landed into linux-next, no
> > additional patches are required for testing.
> 
> Btw, what userspace do you use for this?  The only one I know so far
> is Scotts sed-opal-temp, which really should grow a more permanent
> name / location.

He has a forked verison here:
https://github.com/ghostav/sed-opal-temp

He sent out a v1, obviously, but I had him clean up/resubmit and CC you. So you could
chime in on the new ioctl.

v1:
https://marc.info/?l=linux-block&m=152094656909515&w=4


As for the moving of sed-opal-temp I am more than willing to place this else where. I just
don't have a location other than github to place it. If people have suggestions on where to store it
that *isnt* on my personal github I will do that. And give access to the necessary maintainers.
