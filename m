Date: Sat, 28 Apr 2018 13:58:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Teck Choon Giam <giamteckchoon@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>
Subject: Re: kernel-4.9.94 compile error: 'KMOD_DECOMP_LEN' undeclared
Message-ID: <20180428115815.GA4301@kroah.com>
References: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
 <84b1d534-9b9d-ff70-ead6-3f8bb70a4d4b@infradead.org>
 <20180428050026.GA29422@kroah.com>
 <5a56f585-d3c1-ee42-20a3-b47921f160c4@infradead.org>
 <20180428081122.GA27926@kroah.com>
 <CAEwRVpPQeHZqXaX55nx93rZihzVMm89aSo_aiP4yU_56gkOq8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEwRVpPQeHZqXaX55nx93rZihzVMm89aSo_aiP4yU_56gkOq8w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 07:54:36PM +0800, Teck Choon Giam wrote:
> >> It still fails in 4.9.96. (not #defined there)
> >
> > Should be fixed in 4.9.97-r1, I know .96 still had the issue.
> >
> 
> Test compiled without issue for 4.9.97-rc1:
> 
> wget https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/snapshot/linux-stable-rc-linux-4.9.y.tar.gz
> tar zxvfp linux-stable-rc-linux-4.9.y.tar.gz
> cd linux-stable-rc-linux-4.9.y/
> make mrproper
> cp -pvf ~/config-x86_64 .config
> make oldconfig
> make bzImage
> make V=1 -j 2 modules
> make -C tools/perf V=1 HAVE_CPLUS_DEMANGLE=1 NO_DWARF=1 WERROR=0

Wonderful, thanks for testing.

greg k-h
