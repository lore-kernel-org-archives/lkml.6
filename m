Date: Tue, 13 Feb 2018 17:00:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3.18 0/9] Backports for security and critical bug fixes
Message-ID: <20180213160000.GH14300@kroah.com>
References: <cover.1518036867.git.shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518036867.git.shuahkh@osg.samsung.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 02:20:23PM -0700, Shuah Khan wrote:
> As I started backporting security fixes, found a few problems
> that prevent tools to build on newer gcc releases, deadlock bug,
> and another bug that prevents client from being able to use
> imported devices.
> 
> This patch series consists of security fixes and fixes to critical
> bugs.

All now applied, thanks!

greg k-h
