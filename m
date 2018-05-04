Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeEDN7W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:59:22 -0400
Received: from imap.thunk.org ([74.207.234.97]:52580 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbeEDN7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:59:06 -0400
Date: Fri, 4 May 2018 09:59:04 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: serial: custom baud rate
Message-ID: <20180504135904.GJ29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Muni Sekhar <munisekharrms@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
 <20180503175401.GD29205@thunk.org>
 <CAHhAz+iiv+h+RAPXACQuJRiEQmE1jxeS7+qaz-8fu30Fm9tNaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+iiv+h+RAPXACQuJRiEQmE1jxeS7+qaz-8fu30Fm9tNaw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:34:51PM +0530, Muni Sekhar wrote:
> > See the setserial man page:t
> >
> >         https://linux.die.net/man/8/setserial
> >
> > Not all serial devices support the spd_cust and divisor, however.  In
> > general, only devices where the kernel directly programs the
> > 8250/16450/16550 UART directly will support this feature.
> >
> So custom baud's can be set via TIOCSSERIAL IOCtl in kernel mode?

ioctl's are in general designed for use in userspace.  So are the
termios interface.

					- Ted
