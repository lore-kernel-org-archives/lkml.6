Date: Fri, 6 Apr 2018 09:33:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Timmy Li <lixiaoping3@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 68/97] net: hns: fix ethtool_get_strings overflow in
 hns driver
Message-ID: <20180406073348.GE15735@kroah.com>
References: <20180323094157.535925724@linuxfoundation.org>
 <20180323094201.429866014@linuxfoundation.org>
 <1522791583.2654.140.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522791583.2654.140.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 10:39:43PM +0100, Ben Hutchings wrote:
> On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Timmy Li <lixiaoping3@huawei.com>
> > 
> > 
> > [ Upstream commit 412b65d15a7f8a93794653968308fc100f2aa87c ]
> [...]
> 
> This is not a correct fix; please also apply:
> 
> commit d61d263c8d82db7c4404a29ebc29674b1c0c05c9
> Author: Matthias Brugger <matthias.bgg@gmail.com>
> Date:   Thu Mar 15 17:54:20 2018 +0100
> 
>     net: hns: Fix ethtool private flags

Thanks, now queued up.

greg k-h
