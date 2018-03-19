Date: Mon, 19 Mar 2018 16:38:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL
 boiler-plate
Message-ID: <20180319153822.GB23694@kroah.com>
References: <20180319091721.18193-1-brgl@bgdev.pl>
 <20180319091721.18193-5-brgl@bgdev.pl>
 <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
 <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
 <2c828644-8797-2ec7-fbd7-a6ef21fa1356@axentia.se>
 <CAMRc=Mc3AYVDscyj-RsCDZCD4X7pR5V5QdOJsOde9r2mcz_t4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mc3AYVDscyj-RsCDZCD4X7pR5V5QdOJsOde9r2mcz_t4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 01:56:28PM +0100, Bartosz Golaszewski wrote:
> 2018-03-19 13:51 GMT+01:00 Peter Rosin <peda@axentia.se>:
> > On 2018-03-19 13:12, Bartosz Golaszewski wrote:
> >> 2018-03-19 12:03 GMT+01:00 Peter Rosin <peda@axentia.se>:
> >>> Also, use a // style comment for the SPDX line in C files.
> >>
> >> I'm seeing both /* */ and // style comments used for SPDX headers - is
> >> there any reason not to use /* */ here?
> >
> > Documentation/process/license-rules.rst states:
> >
> > 2. Style:
> >
> >    The SPDX license identifier is added in form of a comment.  The comment
> >    style depends on the file type::
> >
> >       C source: // SPDX-License-Identifier: <SPDX License Expression>
> >       C header: /* SPDX-License-Identifier: <SPDX License Expression> */
> >       ASM:      /* SPDX-License-Identifier: <SPDX License Expression> */
> >       scripts:  # SPDX-License-Identifier: <SPDX License Expression>
> >       .rst:     .. SPDX-License-Identifier: <SPDX License Expression>
> >       .dts{i}:  // SPDX-License-Identifier: <SPDX License Expression>
> >
> > Read more in that file for reasons. If there are none, I personally
> > think the reason is that "Linus said so". Or something like that?
> >
> > Cheers,
> > Peter
> 
> Makes sense, thanks.
> 
> I'm thinking about dropping this file from this series and submitting
> it separately for Greg to Ack.
> 
> Unless he sees our exchange and acks it here. :)

I can't ack a patch that is incorrect :(

Please fix it up and resend...

thanks,

greg k-h
