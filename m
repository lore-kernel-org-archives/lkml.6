Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753759AbeC1THc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:07:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753730AbeC1THb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:07:31 -0400
Date: Wed, 28 Mar 2018 21:07:26 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Use octal not symbolic permissions
Message-ID: <20180328190726.GR9275@dhcp22.suse.cz>
References: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
 <20180328130623.GB8976@dhcp22.suse.cz>
 <1522251891.12357.102.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522251891.12357.102.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-03-18 08:44:51, Joe Perches wrote:
> On Wed, 2018-03-28 at 15:06 +0200, Michal Hocko wrote:
> > On Mon 26-03-18 15:22:32, Joe Perches wrote:
> > > mm/*.c files use symbolic and octal styles for permissions.
> > > 
> > > Using octal and not symbolic permissions is preferred by many as more
> > > readable.
> > > 
> > > https://lkml.org/lkml/2016/8/2/1945
> > > 
> > > Prefer the direct use of octal for permissions.
> > > 
> > > Done using
> > > $ scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace mm/*.c
[...]
> > I hope I haven't overlooked any potential mismatch...
> 
> Doubtful as the conversion is completely automated.

Ohh, I failed to see --fix-inplace option for checkpatch. I wasn't aware
that checkpatch can perform changes as well.

-- 
Michal Hocko
SUSE Labs
