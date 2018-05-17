Date: Thu, 17 May 2018 08:54:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
	Catalin.Marinas@arm.com, Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
	Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com,
	palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
	jhugo@codeaurora.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
Message-ID: <20180517065449.GA13589@kroah.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 12:15:08PM -0500, Jeremy Linton wrote:
> Hi Greg,
> 
> Have you had a chance to look at the cachinfo parts of this patch?

Nope :)

I didn't write that, and while it is dumped in the driver core section
of the kernel, I know nothing about it.  If you get an ack from Sundeep
for this, which you did, that's fine with me, merge away!

thanks,

greg k-h
