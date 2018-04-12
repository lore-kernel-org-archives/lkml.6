Date: Thu, 12 Apr 2018 10:25:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	Andrei Vagin <avagin@virtuozzo.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Michael Kerrisk <mtk.manpages@googlemail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Ingo Molnar <mingo@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.9 022/310] pidns: disable pid allocation if
 pid_ns_prepare_proc() is failed in alloc_pid()
Message-ID: <20180412082526.GB6054@kroah.com>
References: <20180411183622.305902791@linuxfoundation.org>
 <20180411183623.247331431@linuxfoundation.org>
 <87r2nlilwo.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2nlilwo.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 02:27:19PM -0500, Eric W. Biederman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > 4.9-stable review patch.  If anyone has any objections, please let me
> > know.
> 
> No objections but if you are grabbing that one please check if you
> have it's follow on fix.
> 
> c0ee554906c3 ("pid: Handle failure to allocate the first pid in a pid namespace")
> 
> There were a few cases not handled but the fix below, that made a more
> comprehensive fix desirable.

Ok, but it looks like that commit needs to also go into 4.14.y as well,
as the original patch here, 8896c23d2ef8 ("pidns: disable pid allocation
if pid_ns_prepare_proc() is failed in alloc_pid()") showed up in 4.12.

Is that ok?

thanks,

greg k-h
