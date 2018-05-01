Date: Tue, 1 May 2018 08:01:37 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sriram R <srirrama@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>
Subject: Re: [PATCH 4.4 44/44] ath10k: fix rfc1042 header retrieval in
 QCA4019 with eth decap mode
Message-ID: <20180501150137.GB14123@kroah.com>
References: <20180430190946.093694747@linuxfoundation.org>
 <20180430190948.085407552@linuxfoundation.org>
 <454d05a202b8f44728e2660e3d6f95c2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454d05a202b8f44728e2660e3d6f95c2@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 05:26:41AM +0530, Sriram R wrote:
> On 2018-05-01 00:54, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me
> > know.
> Hi Greg,
> 
>   This is a dependency patch to the actual fix ,
> [PATCH 2/2 - linux-stable-4.4] ath10k: rebuild crypto header in rx data
> frames.
> 
> We would like both these patches to be upstreamed to 4.4 together.
> 
> As mentioned in cover, These patches depends on 3 other mac80211 patches so
> the below mac80211 commits needs to be picked first in the same order and
> then apply this patchset.
> 
> f980ebc058c2 : mac80211: allow not sending MIC up from driver for HW crypto
> f631a77ba920 : mac80211: allow same PN for AMSDU sub-frames
> cef0acd4d7d4 : mac80211: Add RX flag to indicate ICV stripped
> 
> These patches should be applied in that order(commit f980ebc058c2 first) and
> they should apply cleanly with --3-way merge.
> 
> Kindly revert if you face any issues.

As I stated in the other response just now, I'll drop this for this
release and revisit this later this week.

thanks,

greg k-h
