Date: Tue, 27 Feb 2018 14:40:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Avery <tavery321@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: Improve readability by removing warnings
Message-ID: <20180227134011.GA6881@kroah.com>
References: <20180226152756.s2pr2et47lvjuphb@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226152756.s2pr2et47lvjuphb@debian>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 10:27:56AM -0500, Thomas Avery wrote:
> Fix warning given when running checkpatch.pl, make line less than 80
> characters 
> 
> ---
>  drivers/staging/vboxvideo/vbox_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch breaks the build.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
