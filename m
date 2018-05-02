Date: Wed, 2 May 2018 13:06:15 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
Message-ID: <20180502200615.GB16341@kroah.com>
References: <20180502193735.GA2444@zrhn9910b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502193735.GA2444@zrhn9910b>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 09:37:35PM +0200, damian wrote:
> Hello together,
> 
> after commit "Merge tag 'char-misc-4.17-rc3' d8a332730e757129e70675679f2b2a03f1ecf65e my virtualbox with Ubuntu 16.04 no longer works correctly.
> The focus on a window for example "terminal window" only works very delayed. Or a move of the window with the mouse isnt possible. 
> I reverted the commit 'd8a332730e757129e70675679f2b2a03f1ecf65e' and now works all normal. 

Reverting a merge is a pain, can you try looking at the 4 vbox-specific
commits in that merge to find the specific problem?

thanks,

greg k-h
