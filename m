Date: Wed, 14 Mar 2018 11:54:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Daniel Vacek <neelx@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@suse.com>,
	Paul Burton <paul.burton@imgtec.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.15 049/146] mm/page_alloc: fix memmap_init_zone
 pageblock alignment
Message-ID: <20180314105419.GE32615@kroah.com>
References: <20180313152320.439085687@linuxfoundation.org>
 <20180313152324.434860515@linuxfoundation.org>
 <20180313193457.gjqbfwd6eorxeedc@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313193457.gjqbfwd6eorxeedc@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 02:34:57PM -0500, Dan Rue wrote:
> On Tue, Mar 13, 2018 at 04:23:36PM +0100, Greg Kroah-Hartman wrote:
> > 4.15-stable review patch.  If anyone has any objections, please let me know.
> 
> On 4.14 and 4.15, this patch breaks booting on dragonboard 410c and
> hikey 620 (both arm64). The fix has been proposed and tested but is not
> yet in mainline per https://lkml.org/lkml/2018/3/12/710

Thanks for letting me know, now dropped.

I'll go respin a -rc2 with this change.

thanks,

greg k-h
