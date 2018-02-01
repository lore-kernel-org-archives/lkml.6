Date: Thu, 1 Feb 2018 18:01:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jaegeuk@kernel.org, alex.lemberg@wdc.com
Subject: Re: [PATCH v4 03/10] ufs: sysfs: interconnect descriptor
Message-ID: <20180201170139.GC12838@kroah.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1517501746-19075-4-git-send-email-stanislav.nijnikov@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517501746-19075-4-git-send-email-stanislav.nijnikov@wdc.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 06:15:39PM +0200, Stanislav Nijnikov wrote:
> This patch introduces a sysfs group entry for the UFS interconnect
> descriptor parameters. The group adds "interconnect_descriptor" folder
> under the UFS driver sysfs entry (/sys/bus/platform/drivers/ufshcd/*).
> The parameters are shown as hexadecimal numbers. The full information
> about the parameters could be found at UFS specifications 2.1.
> 
> Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Nit, you should not have blank lines between these two statements,
otherwise tools can get confused.

You do that in later patches as well.

thanks,

greg k-h
