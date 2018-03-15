Date: Thu, 15 Mar 2018 18:28:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Slaby <jslaby@suse.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Mark the variable earlycon_acpi_spcr_enable
 maybe_unused
Message-ID: <20180315172803.GC28917@kroah.com>
References: <20180310180645.7014-1-malat@debian.org>
 <87lgeuf9ap.fsf@concordia.ellerman.id.au>
 <CA+7wUszUs1X8b43KLYXT_U4EbcDYv-927c2B3yV_N4xe+UHXvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUszUs1X8b43KLYXT_U4EbcDYv-927c2B3yV_N4xe+UHXvQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 08:08:29AM +0100, Mathieu Malaterre wrote:
> On Thu, Mar 15, 2018 at 1:54 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Mathieu Malaterre <malat@debian.org> writes:
> >> Subject: Re: [PATCH] powerpc: Mark the variable earlycon_acpi_spcr_enable maybe_unused
> >
> > You're fixing an error on powerpc, but the patch is to the serial code,
> > so the subject should probably be more like:
> >
> >   serial: core: Mark the variable earlycon_acpi_spcr_enable maybe_unused
> 
> Ah, right. I should have double-checked when re-sending this one.
> 
> Greg, do you want a v2 ?

Oops, no, already applied this, it's fine :)
