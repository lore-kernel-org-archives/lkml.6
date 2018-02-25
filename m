Date: Sun, 25 Feb 2018 13:47:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Or Idgar <idgar@virtualoco.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, oidgar@redhat.com,
	ghammer@redhat.com, Or Idgar <oridgar@gmail.com>
Subject: Re: [PATCH v2] drivers/virt: vm_gen_counter: initial driver
 implementation
Message-ID: <20180225124747.GA592@kroah.com>
References: <20180225122631.22834-1-idgar@virtualoco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225122631.22834-1-idgar@virtualoco.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 25, 2018 at 02:26:31PM +0200, Or Idgar wrote:
> From: Or Idgar <oridgar@gmail.com>
> 
> This patch is a driver which expose the Virtual Machine Generation ID
> via sysfs. The ID is a UUID value used to differentiate between virtual
> machines.
> 
> The VM-Generation ID is a feature defined by Microsoft (paper:
> http://go.microsoft.com/fwlink/?LinkId=260709) and supported by multiple
> hypervisor vendors.
> 
> Signed-off-by: Or Idgar <oridgar@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-hypervisor |  13 +++
>  drivers/misc/Kconfig                       |   6 ++
>  drivers/misc/Makefile                      |   1 +
>  drivers/misc/vmgenid.c                     | 140 +++++++++++++++++++++++++++++
>  4 files changed, 160 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-hypervisor
>  create mode 100644 drivers/misc/vmgenid.c

What changed from v1?  Always put that below the --- line like
Documentation/SubmittingPatches describes how to do.

v3?

thanks,

greg k-h
