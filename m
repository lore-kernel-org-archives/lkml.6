Date: Mon, 23 Apr 2018 10:58:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: jslaby@suse.com, alan@llwyncelyn.cymru,
	bot+1a77aeddeaf63317949b59c3df98f139a1ca34f9@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	dvyukov@google.com, hannes@cmpxchg.org, hch@lst.de, mhocko@suse.com
Subject: Re: [PATCH] tty: Avoid possible error pointer dereference at
 tty_ldisc_restore().
Message-ID: <20180423085857.GA20744@kroah.com>
References: <001a1141f0c87da52c055d385a4d@google.com>
 <20171105103404.GB1487@kroah.com>
 <2e8fd7a6-6841-d660-8e1c-17b5a07618fa@I-love.SAKURA.ne.jp>
 <20180405142503.627552ca@alans-desktop>
 <201804162006.GBB48461.FFJFSOMOOQHVLt@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804162006.GBB48461.FFJFSOMOOQHVLt@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 08:06:34PM +0900, Tetsuo Handa wrote:
> Greg and Jiri, are you OK with this patch?

Yes, I'll queue it up now, thanks.

greg k-h
