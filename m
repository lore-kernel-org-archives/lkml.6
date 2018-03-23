Date: Fri, 23 Mar 2018 14:32:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 4.16-rc7
Message-ID: <20180323133213.GA25708@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-4.16-rc7

for you to fetch changes up to 655296c8bbeffcf020558c4455305d597a73bde1:

  Drivers: hv: vmbus: Fix ring buffer signaling (2018-03-06 09:52:59 -0800)

----------------------------------------------------------------
Char/Misc fix for 4.16-rc7

This is a single hyperv bugfix for 4.16-rc7.

It resolves an issue with the ring-buffer signaling to resolve reported
problems.

It's been in linux-next for a while now with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Michael Kelley (1):
      Drivers: hv: vmbus: Fix ring buffer signaling

 drivers/hv/ring_buffer.c | 52 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)
