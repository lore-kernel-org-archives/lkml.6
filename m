Date: Tue, 8 May 2018 05:07:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Masanari Iida <standby24x7@gmail.com>, linux-pm@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 02/18] docs: fix location of request_firmware & friends
Message-ID: <20180508030724.GB1882@kroah.com>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <9e40d0b3a085a937b42ec60a3b2409cf820ca713.1525684985.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e40d0b3a085a937b42ec60a3b2409cf820ca713.1525684985.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 06:35:38AM -0300, Mauro Carvalho Chehab wrote:
> commit 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> and other commits renamed the old firmware_class.c file and split it
> into separate files, but documentation was not changed accordingly,
> causing Sphinx errors.
> 
> Change the location accordingly at the documentation files.
> 
> While here, add a missing entry at request_firmware.rst for
> release_firmware() function.
> 
> Fixes: 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
