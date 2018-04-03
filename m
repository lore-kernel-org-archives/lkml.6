Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754963AbeDCKCa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:02:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbeDCKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:02:29 -0400
Date: Tue, 3 Apr 2018 13:02:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: fix spelling mistake: "Usupported" ->
 "Unsupported"
Message-ID: <20180403100207.ve3r6aluj6udilie@mwanda>
References: <20180330160047.7368-1-colin.king@canonical.com>
 <87tvssaawl.fsf@intel.com>
 <alpine.DEB.2.20.1804031139110.3630@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804031139110.3630@hadrien>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=939
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030099
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 11:41:05AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 3 Apr 2018, Jani Nikula wrote:
> 
> > On Fri, 30 Mar 2018, Colin King <colin.king@canonical.com> wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > Trivial fix to spelling mistake in DRM_ERROR error message text
> >
> > Thanks for the patch.
> >
> > Please do consider limiting the distribution in the future,
> > though. There's no need to include lkml or even dri-devel for trivial
> > patches like this.
> 
> It's complex to have to remember the preferences for every subsystem.
> Preferences should be expressed in the MAINTAINERS file in some way.
> Also, since no one reads lkml, does it hurt to have even trivial patches?

I always tell people not to CC lkml when there is a smaller subsystem
list which can handle it but Linus said my advice was bad.

regards,
dan carpenter
