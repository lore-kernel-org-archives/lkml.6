Date: Wed, 28 Feb 2018 13:08:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Shi <alex.shi@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] arm64: mm: Use non-global mappings for kernel space
Message-ID: <20180228120828.GB8453@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <1519790211-16582-2-git-send-email-alex.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519790211-16582-2-git-send-email-alex.shi@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 11:56:23AM +0800, Alex Shi wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> commit e046eb0c9bf2 upstream.
> 
> In preparation for unmapping the kernel whilst running in userspace,
> make the kernel mappings non-global so we can avoid expensive TLB
> invalidation on kernel exit to userspace.
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Laura Abbott <labbott@redhat.com>
> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> 
> Conflicts:
> 	skip PTE_RDONLY of PAGE_NONE in arch/arm64/include/asm/pgtable-prot.h

These "Conflicts:" lines need to be removed, or put below the --- line
please.

thanks,

greg k-h
