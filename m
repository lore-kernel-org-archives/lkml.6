Date: Mon, 23 Apr 2018 12:45:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH driver-core 2/2] test_firmware: fix setting old custom fw
 path back on exit, second try
Message-ID: <20180423104504.GA26502@kroah.com>
References: <20180404203712.zecit6po44qsde4c@xylophone.i.decadent.org.uk>
 <20180404203848.3txsangsvaxtxsu4@xylophone.i.decadent.org.uk>
 <20180418203808.GQ30543@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418203808.GQ30543@wotan.suse.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 10:38:09PM +0200, Luis R. Rodriguez wrote:
> On Wed, Apr 04, 2018 at 10:38:49PM +0200, Ben Hutchings wrote:
> > Commit 65c79230576 tried to clear the custom firmware path on exit by
> > writing a single space to the firmware_class.path parameter.  This
> > doesn't work because nothing strips this space from the value stored
> > and fw_get_filesystem_firmware() only ignores zero-length paths.
> > 
> > Instead, write a null byte.
> > 
> > Fixes: 0a8adf58475 ("test: add firmware_class loader test")
> > Fixes: 65c79230576 ("test_firmware: fix setting old custom fw path back on exit")
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> 
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> Greg, let me know if you want to take these two in now, or if you want me to
> queue them up on my own and then send you what I get in the queue later.

I can take them now, thanks.

greg k-h
