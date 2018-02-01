Date: Thu, 1 Feb 2018 07:42:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: John Stultz <john.stultz@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Rob Herring <rob.herring@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Ronald Tschalaer <ronald@innovation.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Backport d73e17281665 to v4.15 stable
Message-ID: <20180201064230.GA15417@kroah.com>
References: <CALAqxLVTff-XX7bbQ8a1Pihqe=QW1HDMKST3F3okCV8jY+wGqw@mail.gmail.com>
 <CALAqxLW9gzcBrwy3TWB5x_OpKtcLTe7P8PX4KeUgvibbAaMX_A@mail.gmail.com>
 <20171116213045.GA17506@wunner.de>
 <20171116214504.GB17506@wunner.de>
 <CALAqxLX-qp=rc8P7ynGrUwWHgP2EBAwoEES-aOOuehtnJSDR+A@mail.gmail.com>
 <f181189de5fd4c75da4708425df99e70abc6a127.1510875912.git.lukas@wunner.de>
 <25BE9D66-9609-42D0-8A83-E15758FA3A1B@holtmann.org>
 <CALAqxLXeN3fF_ZUVeKLEYnDy25bd0+D7DgK3eLA3rVv3dEv6qQ@mail.gmail.com>
 <CALAqxLWbh=pmbZEfa03LvOTxBD7bnPVNdHs-os5xZjvhkSWT2Q@mail.gmail.com>
 <20180201055052.GA19082@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201055052.GA19082@wunner.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 06:50:52AM +0100, Lukas Wunner wrote:
> Dear Greg,
> 
> when you refill the patch queue for v4.15 stable one of these days,
> please consider adding
> 
>     commit d73e172816652772114827abaa2dbc053eecbbd7
>     Author: Lukas Wunner <lukas@wunner.de>
>     Date:   Fri Nov 17 00:54:53 2017 +0100
>     
>     Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops
> 
> to fix a boot crash on certain machines with UART-attached Bluetooth
> which was kindly reported by John Stultz.  The patch unfortunately
> lacked a Fixes: or Cc: stable tag.  It landed in Linus' tree 7 hours ago.

Now queued up, thanks.

greg k-h
