Date: Fri, 4 May 2018 10:31:47 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangq95 <qiangzh.hust@gmail.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
	hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
	cgroups@vger.kernel.org, riel@redhat.com, gs051095@gmail.com,
	akpm@linux-foundation.org, oleg@redhat.com, tglx@linutronix.de,
	keescook@chromium.org, longman@redhat.com, prsood@codeaurora.org,
	guro@fb.com, davem@davemloft.net, mhocko@suse.com,
	kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
	hoeun.ryu@gmail.com, rostedt@goodmis.org, bigeasy@linutronix.de,
	alexander.levin@verizon.com, paulmck@linux.vnet.ibm.com,
	fweisbec@gmail.com
Subject: Re: [PATCH] Add a file named cgroup.procs_stat in cgroup
Message-ID: <20180504173147.GA4649@kroah.com>
References: <1525444100-4858-1-git-send-email-qiangzh.hust@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525444100-4858-1-git-send-email-qiangzh.hust@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 10:28:20PM +0800, zhangq95 wrote:
> When I run "cat /proc/stat" in a container, container will access
> host's file directly which is a security risk.

Why is this a "security risk"?  What can be learned there that is
somehow "bad"?

thanks,

greg k-h
