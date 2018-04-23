Date: Mon, 23 Apr 2018 13:38:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: Moving framework and drivers to SPDX
 identifier
Message-ID: <20180423113828.GA8720@kroah.com>
References: <1523981817-16176-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523981817-16176-1-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 10:16:57AM -0600, Mathieu Poirier wrote:
> Moving all kernel side CoreSight framework and drivers to SPDX identifier.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
> Change for V2:
> * Added drivers/hwtracing/stm/ftrace.c as pointed out by Alex.

This doesn't apply to 4.17-rc2 :(

thanks,

greg k-h
