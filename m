Date: Wed, 14 Mar 2018 12:29:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging fixes for 4.16-rc6
Message-ID: <20180314112946.GA23773@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.16-rc6

for you to fetch changes up to 740a5759bf222332fbb5eda42f89aa25ba38f9b2:

  staging: android: ashmem: Fix possible deadlock in ashmem_ioctl (2018-03-06 07:21:10 -0800)

----------------------------------------------------------------
Staging fixes for 4.16-rc6

Here are 3 staging driver fixes for 4.16-rc6

Two of them are lockdep fixes for the ashmem driver that have been
reported by a number of people recently.  The last one is a fix for the
comedi driver core.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Frank Mori Hess (1):
      staging: comedi: fix comedi_nsamples_left.

Joel Fernandes (1):
      staging: android: ashmem: Fix lockdep issue during llseek

Yisheng Xie (1):
      staging: android: ashmem: Fix possible deadlock in ashmem_ioctl

 drivers/staging/android/ashmem.c | 23 ++++++++++-------------
 drivers/staging/comedi/drivers.c |  3 +--
 2 files changed, 11 insertions(+), 15 deletions(-)
