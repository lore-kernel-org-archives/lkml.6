Date: Fri, 2 Feb 2018 08:56:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] checkpatch.pl: Add SPDX license tag check
Message-ID: <20180202075603.GB13420@kroah.com>
References: <20180201211429.32696-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201211429.32696-1-robh@kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:14:29PM -0600, Rob Herring wrote:
> Add SPDX license tag check based on the rules defined in
> Documentation/process/license-rules.rst. To summarize, SPDX license tags
> should be on the 1st line (or 2nd line in scripts) using the appropriate
> comment style for the file type.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
